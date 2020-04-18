//
//  YDOrderAllViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import MJRefresh
class YDOrderAllViewController: YDBasicViewController {
    let YDOrderListTableViewCellID = "YDOrderListTableViewCell"
    let YDMainFooterViewID = "YDMainFooterView"
    lazy var orderListViewModel: YDMainViewModel = {
        return YDMainViewModel()
    }()
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    var orderPayGoodsModel = [YDOrderAllGoodsListModel]()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight-44-LBFMNavBarHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.mj_header = header
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.register(YDOrderListTableViewCell.self, forCellReuseIdentifier: YDOrderListTableViewCellID)
        tableView.register(YDMainFooterView.self, forHeaderFooterViewReuseIdentifier: YDMainFooterViewID)
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestClassifyGoodsDate() }
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.mj_header.beginRefreshing()
        requestClassifyGoodsPayDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        header.setRefreshingTarget(self, refreshingAction: #selector(YDOrderAllViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        requestClassifyGoodsDate()
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.view.addSubview(self.tableView)
        
    }
    //    下啦刷新
    @objc func headerRefresh(){
        requestClassifyGoodsDate()
    }
//    查询全部订单
    func requestClassifyGoodsDate(){
        if  isUserLogin() != true{
            // 加载数据
            orderListViewModel.updateDataBlock = { [unowned self] in
                self.tableView.mj_header.endRefreshing()
                // 更新列表数据
                self.tableView.reloadData()
            }
            self.orderListViewModel.refreshDataSource(typeState:"all")
        }
    }
//    查询待支付订单
    func requestClassifyGoodsPayDate(){
        YDShopCartViewProvider.request(.getOrderGoodOrderList(menu:"pay", token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("++++++++++++++%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        if let mappedObject = JSONDeserializer<YDOrderAllGoodsListModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.orderPayGoodsModel = (mappedObject as? [YDOrderAllGoodsListModel])!
                            for (index ,model)in self.orderPayGoodsModel.enumerated(){
                                let date = Date()
                                let timer = model.creatAt?.prefix(19)
                                let dateFormatter = DateFormatter.init()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date1 = dateFormatter.date(from:String(timer!))!
                                let interval = date.timeIntervalSince(date1)
                                let second =  Int(round(interval))
                                if second > 1800 {
                                    // 问题标识 （超时传13）
                                    self.cancelGoodsOrder(
                                        problemId: 13,
                                        orderNum: model.orderNum ?? "",
                                        isTimeOut: true
                                    )
                                }
                            }
                        }
                    }
                }
                }
            }
        }
    }
    
//    func outoCancelGoodsOrder(message:String,orderNum:String){
//        YDShopCartViewProvider.request(.getOrderGoodCancelListInfo(orderNum:orderNum, cancelReason: message, token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
//            if case let .success(response) = result {
//                let data = try? response.mapJSON()
//                let json = JSON(data!)
//                print("------------------%@",json)
//                if json["success"] == true{
//
//                }else{
//
//                }
//            }
//        }
//    }
}
extension YDOrderAllViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderListViewModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 275
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDOrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDOrderListTableViewCellID, for: indexPath) as! YDOrderListTableViewCell
        cell.orderGoodsListModel = self.orderListViewModel.orderListModel?[indexPath.row].list
        cell.delegate = self
        cell.commentButton.tag = indexPath.row
        cell.buyAgainButton.tag = indexPath.row
        cell.cancelButton.tag = indexPath.row
        cell.payButton.tag = indexPath.row
        cell.payReimburse.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.orderListViewModel.numberOfRowsInSection(section: section) <= 0{
            return LBFMScreenHeight
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDMainFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDMainFooterViewID) as! YDMainFooterView
        return footerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.orderListViewModel.orderListModel?[indexPath.row]
        let detailsVC = YDOrderDetailsViewController()
        detailsVC.orderNumber = model?.orderNum ?? ""
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
//extension YDOrderAllViewController :YDCancelCauseViewControllerDelegate{
//  
//
//    func selectFreightButtonClickViewController(freightBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[freightBtn.tag]
//        self.cancelGoodsOrder(message:"运费问题",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func selectRepetitionButtonClickViewController(RepetitionBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[RepetitionBtn.tag]
//        self.cancelGoodsOrder(message:"重复购买",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func selectMessageErrorButtonClickViewController(messageErrorBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[messageErrorBtn.tag]
//        self.cancelGoodsOrder(message:"收货人信息有误",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func selectnotBuyButtonClickViewController(notBuyBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[notBuyBtn.tag]
//        self.cancelGoodsOrder(message:"我不想买了",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func selectUseCouponButtonClickViewController(useCouponBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[useCouponBtn.tag]
//        self.cancelGoodsOrder(message:"忘记使用优惠劵",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//    func selectOtherButtonClickViewController(otherBtn: UIButton) {
//        let model = self.orderListViewModel.orderListModel?[otherBtn.tag]
//        self.cancelGoodsOrder(message:"其他",orderNum:model?.orderNum ?? "")
//        self.dismiss(animated: true, completion: nil)
//    }
//    func selectCancelErrorButtonClickViewController() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//
//}
extension YDOrderAllViewController : YDOrderListTableViewCellDelegate{
// MARK: --------------   取消订单
    func reconfirmGoodsPayCancelTableViewCell(cancel: UIButton) {
        YDShopCartViewProvider.request(.getGoodsRefundResean(
        type: GoodsRefundReseanType.cancelOrder.rawValue,
        token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String,
        memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if json["success"] == true{
                    let array = json["data"] as Any
                    print("-----------data: ", array)
                    if let dataSource = JSONDeserializer<YDCancelCauseModel>.deserializeModelArrayFrom(json: json["data"].description) {
                        if (self.orderListViewModel.orderListModel?.count ?? 0) <= cancel.tag {
                            self.toast(title: "选择有误")
                            return
                        }
                        
                        let order = self.orderListViewModel.orderListModel![cancel.tag]
                        self.presentCancelCause(data: dataSource as! [YDCancelCauseModel], order: order)
                    } else {
                        self.toast(title: "没有获取到原因，请重新获取")
                    }
                    
                }else{
                    self.toast(errorJson: json)
                }
            }
        }
        
        
//        let shopMenuVC = YDCancelCauseViewController()
////               shopMenuVC.delegate = self
////               shopMenuVC.freightBtn.tag = cancel.tag
////               shopMenuVC.repetitionBtn.tag = cancel.tag
////               shopMenuVC.mesgErrorBtn.tag = cancel.tag
////               shopMenuVC.notBuyBtn.tag = cancel.tag
////               shopMenuVC.useCouponBtn.tag = cancel.tag
////               shopMenuVC.otherBtn.tag = cancel.tag
//                shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//                shopMenuVC.modalTransitionStyle = .crossDissolve
//                shopMenuVC.modalPresentationStyle = .custom
////                if #available(iOS 13.0, *) {
////                    shopMenuVC.modalPresentationStyle = .custom
////                } else {
//////                    shopMenuVC.modalPresentationStyle = .automatic
////                }
//
//                self.present(shopMenuVC,animated:true,completion:nil)
    }
//    手动取消订单
    func cancelGoodsOrder(problemId: Int, orderNum: String, isTimeOut: Bool){
        YDShopCartViewProvider.request(.getOrderGoodCancelListInfo(
            orderNum:orderNum,
            problemId: problemId,
            token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String,
            memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
                if isTimeOut {
                    return
                }
                
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    print("------------------%@",json)
                    if json["success"] == true{
                        if json["data"] == 1{
                            self.toast(title: "订单已取消")
                            self.requestClassifyGoodsDate()
                        }else{
                            self.toast(title: "取消失败")
                        }
                    }else{
                        self.toast(errorJson: json)
                    }
                }
        }
    }
// MARK: --------------   去支付
    func reconfirmGoodsoPayMentTableViewCell(payBtn: UIButton) {
        let modelNumber = self.orderListViewModel.orderListModel?[payBtn.tag].list?[0]
        let date = Date()
        let timer = modelNumber?.creatAt!.prefix(19)
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from:String(timer!))!
        
        let interval = date.timeIntervalSince(date1)
        let second =  Int(round(interval))
        if second < 1800 {
            if self.orderListViewModel.orderListModel?[payBtn.tag].list?.count ?? 0 > 0 {
                let pay = YDPayAliWechatViewController()
                pay.creationTimer = modelNumber?.creatAt ?? ""
                pay.number = modelNumber?.orderNum ?? ""
                pay.typeId = "999"
                pay.countsumPrice = modelNumber?.countsum ?? 0.00
                self.navigationController?.pushViewController(pay, animated: true)
            }
        }
      
    }
// MARK: --------------   申请退款
    func reconfirmGoodsPayReimburseTableViewCell(Reimburse: UIButton) {
        if self.orderListViewModel.orderListModel?[Reimburse.tag].list?.count ?? 0 > 0 {
            let modelNumber = self.orderListViewModel.orderListModel?[Reimburse.tag].list?[0]
            if modelNumber?.status == "2" || modelNumber?.status == "3" {
                let refundVC = YDApplyRefundViewController()
                refundVC.orderNum = modelNumber?.orderNum ?? ""
                refundVC.prickGoods = modelNumber?.countsum ?? 0
                refundVC.payType = modelNumber?.payType ?? ""
                self.navigationController?.pushViewController(refundVC, animated: true)
            }else if modelNumber?.status == "7" {
               
            }else if modelNumber?.status == "10" || modelNumber?.status == "11" || modelNumber?.status == "12"{
                let undereay = YDUnderwayRefundViewController()
                undereay.orderNum = modelNumber?.orderNum ?? ""
                self.navigationController?.pushViewController(undereay, animated: true)
            }
        }
    }
    
// MARK: --------------   评论
    func reconfirmGoodsCommentTableViewCell(commentBtn: UIButton) {
        let model = self.orderListViewModel.orderListModel?[commentBtn.tag]
        let comment =   YDGoodsCommentViewController()
        comment.orderNum =  model?.orderNum ?? ""
        self.navigationController?.pushViewController(comment, animated: true)
    }
// MARK: --------------   再来一单
    func reconfirmGoodsBuyAgainTableViewCell(buyAgain: UIButton) {
        let modelNumber = self.orderListViewModel.orderListModel?[buyAgain.tag]
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        YDShopGoodsListProvider.request(.getOrderBuyAgainCartGoodsLikeList(orderNum: modelNumber?.orderNum ?? "", deviceNumber: uuid,token:(UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    let alertController = UIAlertController(title: "商品已加入购物车",
                                                            message: "", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "留在此页", style: .cancel, handler: {action in
//                        self.navigationController?.popViewController(animated: true)
                        
                    })
                    let okAction = UIAlertAction(title: "去购物车", style: .default,
                                                 handler: {action in
                        self.tabBarController?.selectedIndex = 2
                        self.navigationController?.popViewController(animated: true)
                       
                                                    
                    })
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    if #available(iOS 13.0, *) {
                        alertController.modalPresentationStyle = .fullScreen
                    } else {
                    }
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
}

extension YDOrderAllViewController: YDCancelCauseViewControllerDelegate {
    func selectResean(model: YDCancelCauseModel, order: YDOrderAllGoodsListModel) {
        cancelGoodsOrder(problemId: model.id, orderNum: order.orderNum ?? "", isTimeOut: false)
    }
}

extension YDOrderAllViewController {
    private func presentCancelCause(data: [YDCancelCauseModel], order: YDOrderAllGoodsListModel) {
        let shopMenuVC = YDCancelCauseViewController()
        shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        shopMenuVC.modalTransitionStyle = .crossDissolve
        shopMenuVC.modalPresentationStyle = .custom
        shopMenuVC.delegate = self
        shopMenuVC.setDataSource(dataSource: data)
        shopMenuVC.setOrderModel(order: order)
        self.present(shopMenuVC,animated:true,completion:nil)
    }
}
