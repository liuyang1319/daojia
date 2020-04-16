//
//  YDApplicationRefundViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/26.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import HandyJSON
class YDApplicationRefundViewController: YDBasicViewController {
//    let singleData = ["商品变质不新鲜", "商品漏发", "商家发错货了", "未按约定时间送达", "包装/商品破损/污渍", "显示签收实际未收到货", "商品信息描述不符", "商品临近质保期", "商品已过期", "活动/优惠未享受","食品里有异物"]
    private var problemArray: [YDCancelCauseModel] = [] // 问题列表
    let YDApplicationRefundTableViewCellID = "YDApplicationRefundTableViewCell"
    let YDApplicationRefundFooterViewID = "YDApplicationRefundFooterView"
//    订单号
    var orderGoodsNumber = String()
//    退款原因
//    var refundReasonStr = String()
    private var selectProblem: YDCancelCauseModel?
//    退款金额
    var refundPrice = Double()
//    退款商品code
    var goodsCode = [String]()
    var goodsCodeStr = String()
//    商品数量
    var goodsCount = Int()
//    折叠商品
    var selectCount = Int()
    //    商品列表
    var refundGoodsList = [YDorderDetailGoodsModel]()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图

//        tableView.register(YDUnderwayRefundHeaderView.self, forHeaderFooterViewReuseIdentifier: YDUnderwayRefundHeaderViewID)
        tableView.register(YDApplicationRefundFooterView.self, forHeaderFooterViewReuseIdentifier: YDApplicationRefundFooterViewID)
        tableView.register(YDApplicationRefundTableViewCell.self, forCellReuseIdentifier: YDApplicationRefundTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "申请退款"
        self.selectCount = 1
        self.refundPrice = 0
        self.goodsCount = 0
        self.goodsCode.removeAll()
        for (index,goodsModel) in refundGoodsList.enumerated(){
            let model = refundGoodsList[index]
            self.refundPrice += model.salePrice ?? 0
            self.goodsCode.append(model.goodsCode ?? "")
            self.goodsCount += model.count ?? 0
        }
        print("-------%@",self.goodsCode)
        self.view.addSubview(self.tableView)
        getData()
    }
    
    private func getData() {
        YDShopCartViewProvider.request(.getGoodsRefundResean(
            type: GoodsRefundReseanType.after.rawValue,
            token: UserDefaults.LoginInfo.string(forKey: .token) ?? "",
            memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    if json["success"] == true{
                        if let dataSource = JSONDeserializer<YDCancelCauseModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.problemArray = dataSource as! [YDCancelCauseModel]
                        } else {
                            self.toast(title: "没有获取到原因，请重新获取")
                        }
                        
                    }else{
                        self.toast(error: json["error"]["errorMessage"].description)
                    }
                }
        }
    }
 
}
extension YDApplicationRefundViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.refundGoodsList.count <= 1{
            return self.refundGoodsList.count
        }else{
            return selectCount
        }
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDApplicationRefundTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDApplicationRefundTableViewCellID, for: indexPath) as! YDApplicationRefundTableViewCell
        cell.goodRefundModel = self.refundGoodsList[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 545
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDApplicationRefundFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDApplicationRefundFooterViewID) as! YDApplicationRefundFooterView
            footerView.prickName = self.refundPrice
            footerView.goodsCount = self.goodsCount
            footerView.delegate = self
        return footerView
    }
}
extension YDApplicationRefundViewController : YDApplicationRefundFooterViewViewDelegate{
//    提交
    func submitApplicationRefundFooterView(refundImg: String, refundAble: String) {
        
        if selectProblem == nil {
            //只显示文字
            self.toast(error: "请选择退款原因")
            return
        }
        self.goodsCodeStr = self.goodsCode.joined(separator: ",")
        
        YDShopGoodsListProvider.request(.setsubmitApplicationRefundGoodsLiset(
            orderNum: self.orderGoodsNumber,
            problemId: selectProblem!.id,
            goodsCode: self.goodsCodeStr,
            refundImg: refundImg,
            refundAble: refundAble,
            refundPrice:self.refundPrice,
            token: UserDefaults.LoginInfo.string(forKey: .token)! as String,
            memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    let alertController = UIAlertController(title: "辉鲜到家",message:"您的退款申请已提交，请您耐心等待客服处理。", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler:{action in
                        
                        let viewCtl = self.navigationController?.viewControllers[1];
                        self.navigationController?.popToViewController(viewCtl!, animated:true)
                    })
                    let okAction = UIAlertAction(title: "去看看", style: .default,
                                                 handler: {action in
                        let undereay = YDUnderwayRefundViewController()
                        undereay.orderNum = self.orderGoodsNumber
                        self.navigationController?.pushViewController(undereay, animated: true)
                                                    
                    })
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    if #available(iOS 13.0, *) {
                        alertController.modalPresentationStyle = .fullScreen
                    } else {
                    }
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    self.toast(error: json["error"]["errorMessage"].description)
                }
            }
        }
        
    }
    
//    商品折叠
    func selectGoodsListFoldFooterView(goodsliset: UIButton) {
        if goodsliset.isSelected == true{
            goodsliset.isSelected = false
            goodsliset.setImage(UIImage(named:"message_down"), for: UIControl.State.normal)
            self.selectCount = 1
            self.tableView.reloadData()
            
        }else{
            goodsliset.isSelected = true
            goodsliset.setImage(UIImage(named:"message_top"), for: UIControl.State.normal)
            self.selectCount =  self.refundGoodsList.count
            self.tableView.reloadData()
        }
    }
//    选择问题
    func selectApplicationRefundIssueFooterView() {
        var singleData: [String] = []
        for model in problemArray {
            singleData.append(model.name)
        }
        
        if singleData.count == 0 {
            self.toast(title: "没有获取到原因，请重新获取")
            return
        }
        
        UsefulPickerView.showSingleColPicker("", data: singleData, defaultSelectedIndex: singleData.count > 2 ? 2 : 0) {[unowned self] (selectedIndex, selectedValue) in
            if self.problemArray.count <= selectedIndex {
                return
            }
            
            self.selectProblem = self.problemArray[selectedIndex]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"ApplicationRefundIssue"), object: nil, userInfo: ["Issue":selectedValue])
            print("%@==========%@",selectedIndex,selectedValue)
        }
        
    }
}
