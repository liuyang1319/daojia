//
//  YDApplyRefundViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDApplyRefundViewController: YDBasicViewController {
    private let kYDApplyRefundCell = "YDApplyRefundCell"
    
//    退款金额
    var prickGoods = Double()
//    订单号
    var orderNum = String()
////    退款原因
//    var selectIssue = String()
//    退款类型
    var payType = String()
    
    private var dataSource:[YDCancelCauseModel] = []
    private var selectModel: YDCancelCauseModel?
    
    var backLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "小主，您确定要放弃当前选择吗？"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = YDTableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.regiestCellsForNibs(cellIds: [kYDApplyRefundCell])
        return tableView
    }()
    
//    var titleName1 : UILabel = {
//        let label = UILabel()
//        label.text = "商品不想买了"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//    var selectBtn1 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick1), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//    var lineLabel1 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
//
//    var titleName2 : UILabel = {
//        let label = UILabel()
//        label.text = "忘记使用优惠券/积分"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//    var selectBtn2 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick2), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//    var lineLabel2 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
//
//    var titleName3 : UILabel = {
//        let label = UILabel()
//        label.text = "收货地址填错了"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//    var selectBtn3 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick3), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//    var lineLabel3 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
//
//    var titleName4 : UILabel = {
//        let label = UILabel()
//        label.text = "商品买错/买多/买少了"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//    var selectBtn4 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick4), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//    var lineLabel4 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
//
//    var titleName5 : UILabel = {
//        let label = UILabel()
//        label.text = "配送太慢"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//
//
//    var selectBtn5 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick5), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//    var lineLabel5 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
//
//    var titleName6 : UILabel = {
//        let label = UILabel()
//        label.text = "其他"
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        return label
//    }()
//    var selectBtn6 : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectIssueButtonClick6), for: UIControl.Event.touchUpInside)
//        return button
//    }()
  
//    var lineLabel6 : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
//        return label
//    }()
    
    var backView : UIView = {
        let back = UIView()
        back.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return back
    }()
    
    var submitBtn : UIButton = {
        let button = UIButton()
        button.backgroundColor = YMColor(r: 88, g: 202, b: 54, a: 1)
        button.setTitle("提交", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(submitButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 0, y: LBFMNavBarHeight, width:LBFMScreenWidth, height: 15)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 0, y:self.backLabel.frame.maxY+15, width:LBFMScreenWidth, height: 15)
        
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 15, y: titleLabel.frame.maxY + 10, width: LBFMScreenWidth - 30, height: 240)
//        self.view.addSubview(self.titleName1)
//        self.titleName1.frame = CGRect(x: 15, y: self.titleLabel.frame.maxY+20, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn1)
//        self.selectBtn1.frame = CGRect(x: LBFMScreenWidth-45, y: self.titleLabel.frame.maxY+15, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel1)
//        self.lineLabel1.frame = CGRect(x: 15, y: self.titleName1.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
//
//
//
//        self.view.addSubview(self.titleName2)
//        self.titleName2.frame = CGRect(x: 15, y: self.lineLabel1.frame.maxY+10, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn2)
//        self.selectBtn2.frame = CGRect(x: LBFMScreenWidth-45, y: self.lineLabel1.frame.maxY+5, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel2)
//        self.lineLabel2.frame = CGRect(x: 15, y: self.titleName2.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
//
//        self.view.addSubview(self.titleName3)
//        self.titleName3.frame = CGRect(x: 15, y: self.lineLabel2.frame.maxY+10, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn3)
//        self.selectBtn3.frame = CGRect(x: LBFMScreenWidth-45, y: self.lineLabel2.frame.maxY+5, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel3)
//        self.lineLabel3.frame = CGRect(x: 15, y: self.titleName3.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
//
//        self.view.addSubview(self.titleName4)
//        self.titleName4.frame = CGRect(x: 15, y: self.lineLabel3.frame.maxY+10, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn4)
//        self.selectBtn4.frame = CGRect(x: LBFMScreenWidth-45, y: self.lineLabel3.frame.maxY+5, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel4)
//        self.lineLabel4.frame = CGRect(x: 15, y: self.titleName4.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
//        self.view.addSubview(self.titleName5)
//        self.titleName5.frame = CGRect(x: 15, y: self.lineLabel4.frame.maxY+10, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn5)
//        self.selectBtn5.frame = CGRect(x: LBFMScreenWidth-45, y: self.lineLabel4.frame.maxY+5, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel5)
//        self.lineLabel5.frame = CGRect(x: 15, y: self.titleName5.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
//
//        self.view.addSubview(self.titleName6)
//        self.titleName6.frame = CGRect(x: 15, y: self.lineLabel5.frame.maxY+10, width: LBFMScreenWidth-50, height: 20)
//
//        self.view.addSubview(self.selectBtn6)
//        self.selectBtn6.frame = CGRect(x: LBFMScreenWidth-45, y: self.lineLabel5.frame.maxY+5, width: 30, height: 30)
//
//        self.view.addSubview(self.lineLabel6)
//        self.lineLabel6.frame = CGRect(x: 15, y: self.titleName6.frame.maxY+10, width: LBFMScreenWidth-30, height: 1)
//
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y:tableView.frame.maxY, width: LBFMScreenWidth, height: LBFMScreenHeight - self.tableView.frame.maxY)
        
        self.backView.addSubview(self.submitBtn)
        self.submitBtn.frame = CGRect(x: 15, y: 20, width: LBFMScreenWidth-30, height: 40)
        
        getData()
    }
    
    private func getData() {
        YDShopCartViewProvider.request(.getGoodsRefundResean(
            type: GoodsRefundReseanType.before.rawValue,
            token: UserDefaults.LoginInfo.string(forKey: .token) ?? "",
            memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    if json["success"] == true{
                        if let dataSource = JSONDeserializer<YDCancelCauseModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.dataSource = dataSource as! [YDCancelCauseModel]
                            self.tableView.reloadData()
                        } else {
                            self.toast(title: "没有获取到原因，请重新获取")
                        }
                        
                    }else{
                        self.toast(errorJson: json)
                    }
                }
        }
    }
//
//    @objc func selectIssueButtonClick1(){
//        self.selectIssue = "商品不想买了"
//        self.selectBtn1.isSelected = true
//        self.selectBtn2.isSelected = false
//        self.selectBtn3.isSelected = false
//        self.selectBtn4.isSelected = false
//        self.selectBtn5.isSelected = false
//        self.selectBtn6.isSelected = false
//
//    }
//    @objc func selectIssueButtonClick2(){
//        self.selectIssue = "忘记使用优惠券/积分"
//        self.selectBtn1.isSelected = false
//        self.selectBtn2.isSelected = true
//        self.selectBtn3.isSelected = false
//        self.selectBtn4.isSelected = false
//        self.selectBtn5.isSelected = false
//        self.selectBtn6.isSelected = false
//    }
//    @objc func selectIssueButtonClick3(){
//        self.selectIssue = "收货地址填错了"
//        self.selectBtn1.isSelected = false
//        self.selectBtn2.isSelected = false
//        self.selectBtn3.isSelected = true
//        self.selectBtn4.isSelected = false
//        self.selectBtn5.isSelected = false
//        self.selectBtn6.isSelected = false
//    }
//    @objc func selectIssueButtonClick4(){
//        self.selectIssue = "商品买错/买多/买少了"
//        self.selectBtn1.isSelected = false
//        self.selectBtn2.isSelected = false
//        self.selectBtn3.isSelected = false
//        self.selectBtn4.isSelected = true
//        self.selectBtn5.isSelected = false
//        self.selectBtn6.isSelected = false
//    }
//    @objc func selectIssueButtonClick5(){
//        self.selectIssue = "配送太慢"
//        self.selectBtn1.isSelected = false
//        self.selectBtn2.isSelected = false
//        self.selectBtn3.isSelected = false
//        self.selectBtn4.isSelected = false
//        self.selectBtn5.isSelected = true
//        self.selectBtn6.isSelected = false
//    }
//    @objc func selectIssueButtonClick6(){
//        self.selectIssue = "其他"
//        self.selectBtn1.isSelected = false
//        self.selectBtn2.isSelected = false
//        self.selectBtn3.isSelected = false
//        self.selectBtn4.isSelected = false
//        self.selectBtn5.isSelected = false
//        self.selectBtn6.isSelected = true
//    }
//  提交
    @objc func submitButtonClick(){
        if selectModel == nil {
            toast(title: "请选择一个原因")
            return
        }
        
        YDShopGoodsListProvider.request(.getOrderGoodsPayRefundList(orderNum: self.orderNum, problemId: self.selectModel!.id, token: UserDefaults.LoginInfo.string(forKey: .token) ?? "", memberPhone: UserDefaults.LoginInfo.string(forKey: .phone) ?? "")) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if self.payType == "1"{
                        self.payAlipay()
                    }else if self.payType == "2" {
                        self.payWeChat()
                    }
                }else{
                    self.toast(errorJson: json)
                }
            }
        }
 
    }
    
    func payAlipay(){
        YDShopCartViewProvider.request(.getGoodsCartAlipayReimburse(orderNum:self.orderNum, token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
                if case let .success(response) = result {
                        //解析数据
                            let data = try? response.mapJSON()
                            let json = JSON(data!)
                            print("支付宝---------------%@",json)
                            if json == true{
                                let mdessage = String(format:"您有一笔%.2f元的退款已通过，预计1-3个工作日内到账。", self.prickGoods)
                                let alertController = UIAlertController(title: "辉鲜到家",
                                                                        message:mdessage, preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler:{action in
                                    self.navigationController?.popViewController(animated: true)
                                })
                                
                                let okAction = UIAlertAction(title: "去看看", style: .default,
                                                             handler: {action in
                                                                
                                                                
                                    let undereay = YDUnderwayRefundViewController()
                                    undereay.orderNum = self.orderNum
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
                                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                                hud.mode = MBProgressHUDMode.text
                                hud.label.text = "申请失败"
                                hud.removeFromSuperViewOnHide = true
                                hud.hide(animated: true, afterDelay: 1)
                            }
            
                }
        }
        
    }
    func payWeChat(){
        YDShopCartViewProvider.request(.getGoodsCartWeChatPayReimburse(orderNo: self.orderNum,memberId:UserDefaults.LoginInfo.string(forKey: .id) ?? "", token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    print("微信---------------%@",json)
                        if json == true{
                            let mdessage = String(format:"您有一笔%.2f元的退款已通过，预计1-3个工作日内到账。", self.prickGoods)
                            let alertController = UIAlertController(title: "辉鲜到家",
                                                                    message:mdessage, preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler:{action in
                                let viewCtl = self.navigationController?.viewControllers[1];
                                self.navigationController?.popToViewController(viewCtl!, animated:true)
                            })
                            
                            let okAction = UIAlertAction(title: "去看看", style: .default,
                                                         handler: {action in
                                                            
                                let undereay = YDUnderwayRefundViewController()
                                undereay.orderNum = self.orderNum
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
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = "申请失败"
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
                        }
        
                    }
            }
    }
    
    
    
    
}

extension YDApplyRefundViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kYDApplyRefundCell) as! YDApplyRefundCell
        cell.spaceHidden(isHidden: indexPath.row == dataSource.count - 1)
        if dataSource.count > indexPath.row {
            let model = dataSource[indexPath.row]
            cell.setValue(model: model)
            cell.isSelect(isSelect: cell.isSelect(model: selectModel))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YDApplyRefundCell.getHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataSource.count <= indexPath.row {
            return
        }
        
        let model = dataSource[indexPath.row]
        for cell in tableView.visibleCells {
            (cell as! YDApplyRefundCell).isSelect(isSelect: false)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! YDApplyRefundCell
        cell.isSelect(isSelect: true)
        selectModel = model
    }
}
