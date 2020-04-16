//
//  YDOrderDetailsViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDOrderDetailsViewController: YDBasicViewController {
    let YDOrderDetailsTableViewCellID = "YDOrderDetailsTableViewCell"
    let YDOrderDetailsHeaderViewID = "YDOrderDetailsHeaderView"
    let YDOrderDetailsFooterViewID = "YDOrderDetailsFooterView"
    
    var orderInfoListInfo:YDOrderorderDetailsModel?
    var orderGoodsListInfo:[YDorderDetailGoodsModel]?
    var orderNumber = String()
    var selectCount = Int()
    // - 导航栏左边按钮
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:5, width:20, height: 20)
        button.addTarget(self, action: #selector(addersButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named:"bb_navigation_back"), for: .normal)
        return button
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "service_Image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
//    从订单还是从支付完成
    var backStr = String()
//    是退款还是查看
    var typeStr = String()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:-LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight+LBFMNavBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(YDOrderDetailsTableViewCell.self, forCellReuseIdentifier: YDOrderDetailsTableViewCellID)
        // 注册头尾视图
        tableView.register(YDOrderDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: YDOrderDetailsHeaderViewID)
        tableView.register(YDOrderDetailsFooterView.self, forHeaderFooterViewReuseIdentifier: YDOrderDetailsFooterViewID)
        return tableView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reuqestDataOrader()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        selectCount = 2
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.title = "订单详情"
    }
//    联系客服
    @objc func rightBarButtonClick(){
         hw_callPhone("13482814061")
    }
//  返回
    @objc func addersButtonClick(){
        if self.backStr == "666"{
             NotificationCenter.default.post(name: NSNotification.Name.init("refreshDetailsOrderGoodsCart"), object:nil)
            self.tabBarController?.selectedIndex = 2
            let viewCtl = self.navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(viewCtl!, animated:true)
        }else if self.backStr == "888" {
            NotificationCenter.default.post(name: NSNotification.Name.init("refreshDetailsOrderGoodsCart"), object:nil)
            self.tabBarController?.selectedIndex = 2
            let viewCtl = self.navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(viewCtl!, animated:true)
        }else{
              self.navigationController?.popViewController(animated: true)
        }
        
    }
    func reuqestDataOrader(){
        YDShopCartViewProvider.request(.getOrderGoodOrderListInfo(orderNum:orderNumber, token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsOrder = JSONDeserializer<YDOrderGoodsInfoModel>.deserializeFrom(json: json["data"].description) {
                    
                    self.orderInfoListInfo = goodsOrder.orderDetails
                    self.orderGoodsListInfo = goodsOrder.orderDetailGoods
                    
                    for (index,value) in self.orderGoodsListInfo!.enumerated(){
                        let model = self.orderGoodsListInfo?[index]
                        if model?.refundStatus == "10" || model?.refundStatus == "11" || model?.refundStatus == "12" {
                            
                            self.typeStr = "11"
                        }
                        
                    }
                    self.view.addSubview(self.tableView)
//                    self.tableView.reloadData()
                }
                }
            }
            
        }
    }
}
extension YDOrderDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    //MARK: 当前控制器的滑动方法事件处理 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > -LBFMNavBarHeight{
            let alpha = scrollView.contentOffset.y / CGFloat(LBFMNavBarHeight)
            self.navBarBackgroundAlpha = alpha
            if scrollView.contentOffset.y > 0{
                
            }
        }else{
            
            self.navBarBackgroundAlpha = 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.orderGoodsListInfo?.count ?? 0 <= 2{
            return self.orderGoodsListInfo?.count ?? 0
        }else{
            return selectCount
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDOrderDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDOrderDetailsTableViewCellID, for: indexPath) as! YDOrderDetailsTableViewCell
        //        cell.delegate = self
        cell.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        cell.selectionStyle = .none
        cell.orderGoodsModel = self.orderGoodsListInfo![indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isIphoneX == true{
            return 290 - 60 //仓隐藏
        }else{
            return 264 - 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:YDOrderDetailsHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDOrderDetailsHeaderViewID) as! YDOrderDetailsHeaderView
            headerView.lookRefund = self.typeStr
            headerView.orderInfoModel = self.orderInfoListInfo
            headerView.delegate = self
            return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 720
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDOrderDetailsFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDOrderDetailsFooterViewID) as! YDOrderDetailsFooterView
        footerView.orderInfoModel = self.orderInfoListInfo
        footerView.goodListCount = self.orderGoodsListInfo
        footerView.delegate = self
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goodsModel = self.orderGoodsListInfo![indexPath.row]
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = goodsModel.goodsId ?? ""
        goodsVC.goodsCode = goodsModel.goodsCode ?? ""
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
}
extension YDOrderDetailsViewController :YDOrderDetailsFooterViewDelegate{

    //    折叠
    func selectGoodsListFoldFooterView(goodsliset:UIButton) {
        if goodsliset.isSelected == true{
            goodsliset.isSelected = false
            goodsliset.setImage(UIImage(named:"message_down"), for: UIControl.State.normal)
            self.selectCount = 2
            self.tableView.reloadData()
            
        }else{
            goodsliset.isSelected = true
            goodsliset.setImage(UIImage(named:"message_top"), for: UIControl.State.normal)
            self.selectCount =  self.orderGoodsListInfo?.count ?? 0
            self.tableView.reloadData()
        }
    }
}
extension YDOrderDetailsViewController :YDOrderDetailsHeaderViewDelegate{
//    物流信息
    func goodsOrderInfoMessageHeaderView() {
        
    }
//    联系配送员
    func cellIphoneMessageHeaderView() {
         let orderModel = self.orderInfoListInfo
        hw_callPhone(orderModel?.deliveryPhone ?? "")
    }
//    申请退款
    func goodsOrderInfoPaymentHeaderView() {
      let orderModel = self.orderInfoListInfo
        if self.typeStr == "11" {
            let undereay = YDUnderwayRefundViewController()
            undereay.orderNum = orderModel?.orderNum ?? ""
            self.navigationController?.pushViewController(undereay, animated: true)
        }else {
            if self.orderGoodsListInfo?.count ?? 0 > 0{
                let applicationRefundList = YDApplicationRefundListViewController()
                applicationRefundList.orderGoodsList = self.orderGoodsListInfo!
                applicationRefundList.orderNumber = orderModel?.orderNum ?? ""
            self.navigationController?.pushViewController(applicationRefundList, animated: true)
            }
        }
    }
}
