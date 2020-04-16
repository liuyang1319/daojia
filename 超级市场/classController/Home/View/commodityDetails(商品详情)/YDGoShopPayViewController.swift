//
//  YDGoShopPayViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDGoShopPayViewController: YDBasicViewController {
    var sumPrice = Double()
    var showLabel = String()
    var orderNumber = String()
//    配送时间
    var deliveryTime = String()
    
    var today = [String]()
    var tomorrow = [String]()
    
    var selectCount = Int()
//    备注
    var remarkString = String()
//    优惠劵ID
    var couponId = String()
//    优惠卷金额
    var couponPrice = Double()
    
    var GoodsOrderListInfo:YDGoodsOrderordersModel?
    var GoodsListInfo:[YDOrderGoodListModel]?
    var couponListInfo:[YDCouponDetailGoodsModel]?
//    let pickerView = TTADataPickerView(title: "请选择配送时间", type: .text, delegate: nil)
    private lazy var backView : UIView = {
        let viewBack = UIView()
        viewBack.backgroundColor = UIColor.white
        return viewBack
    }()
    
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    private lazy var cartBtn : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.layer.cornerRadius = 17.5
        button.clipsToBounds = true
        button.setTitle("确认下单", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(goPayShoppingButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let YDLookGoodsListTableViewCellID = "YDLookGoodsListTableViewCell"
    let YDGoShopPayHeaderViewID = "YDGoShopPayHeaderView"
    let YDGoShopPayFooterViewID = "YDGoShopPayFooterView"

    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:-LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight+LBFMNavBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(YDLookGoodsListTableViewCell.self, forCellReuseIdentifier: YDLookGoodsListTableViewCellID)
        
        tableView.register(YDGoShopPayHeaderView.self, forHeaderFooterViewReuseIdentifier: YDGoShopPayHeaderViewID)
        tableView.register(YDGoShopPayFooterView.self, forHeaderFooterViewReuseIdentifier: YDGoShopPayFooterViewID)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCount = 2
        self.navBarBackgroundAlpha = 0
        reuqestDataOrader()
        reuqestSelelctDataTimer()
//        选择优惠劵重新计算金额
        NotificationCenter.default.addObserver(self, selector: #selector(selectGoodsOrderCoupon(nofit:)), name: NSNotification.Name(rawValue:"selectGoodsOrderCoupon"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshDeleteGoodsCountCart"), object:nil)
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.title = "订单确认"
        self.view.addSubview(self.tableView)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm"// 自定义时间格式
        let time = dateformatter.string(from: Date())
        print(time)

        
        
        self.view.addSubview(self.backView)
        if isIphoneX == true {
             self.backView.frame = CGRect(x: 0, y:LBFMScreenHeight-45-34, width: LBFMScreenWidth, height: 80)
        }else{
             self.backView.frame = CGRect(x: 0, y:LBFMScreenHeight-45, width: LBFMScreenWidth, height: 45)
        }
        
        self.backView.addSubview(self.priceLabel)
      
        self.backView.addSubview(self.cartBtn)
        self.cartBtn.frame = CGRect(x: LBFMScreenWidth-115, y: 5, width: 100, height: 35)
        
    }

//    获取订单信息
    func reuqestDataOrader(){
        YDShopCartViewProvider.request(.getPayGoodsOrderListInfo(orderNum: orderNumber, token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsOrder = JSONDeserializer<YDGoodsOrderModel>.deserializeFrom(json: json["data"].description) {
                    self.GoodsOrderListInfo = goodsOrder.orders
                    self.GoodsListInfo = goodsOrder.orderGood
                    self.couponListInfo = goodsOrder.couponList
                    self.sumPrice = Double(goodsOrder.orders!.countSum ?? 0.00) + Double(goodsOrder.orders!.sendPrice ?? 0.00) + Double(goodsOrder.orders!.packPrice ?? 0.00)
                    self.priceLabel.text = String(format: "应付:¥%.2f", self.sumPrice ?? 0.00 as! CVarArg)
                    let attributeTextPay = NSMutableAttributedString.init(string: self.priceLabel.text!)
                    let countPay = self.priceLabel.text!.count
                    attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, countPay-3))
                    attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)], range: NSMakeRange(3, countPay-3))
                    self.priceLabel.attributedText = attributeTextPay
                    self.priceLabel.frame = CGRect(x: 25, y: 10, width:  widthForView(text:self.priceLabel.text!, font:UIFont.systemFont(ofSize: 22), height: 30), height: 30)
                    self.tableView.reloadData()
                }
               
            }
            }
            
        }
    }
//    获取配送时间
    func reuqestSelelctDataTimer(){
        YDUserAddersProvider.request(.getGoodsSubscribeTimerListInfo(token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsOrder = JSONDeserializer<YDSelectTimerModel>.deserializeFrom(json: json["data"].description) {
                  
                    if goodsOrder.today?.count ?? 0 > 0{
                        for model in goodsOrder.today! {
                            let starTimer = String(model.startTime ?? "")
                            let endTimer = String(model.endTime ?? "")
                            let index1 = starTimer.index(starTimer.startIndex, offsetBy: 0)
                            let index2 = starTimer.index(starTimer.startIndex, offsetBy: 5)
                            let starDate = starTimer[index1..<index2]
                            let index3 = endTimer.index(endTimer.startIndex, offsetBy: 0)
                            let index4 = endTimer.index(endTimer.startIndex, offsetBy: 5)
                            let endDate = endTimer[index3..<index4]
                            let timer = starDate + "-" + endDate
                            self.today.append(String(timer))
                        }
                    }
                    if goodsOrder.tomorrow?.count ?? 0 > 0{
                        for modelDay in goodsOrder.tomorrow! {
                            let starTimer = String(modelDay.startTime ?? "")
                            let endTimer = String(modelDay.endTime ?? "")
                            let index1 = starTimer.index(starTimer.startIndex, offsetBy: 0)
                            let index2 = starTimer.index(starTimer.startIndex, offsetBy: 5)
                            let starDate = starTimer[index1..<index2]
                            let index3 = endTimer.index(endTimer.startIndex, offsetBy: 0)
                            let index4 = endTimer.index(endTimer.startIndex, offsetBy: 5)
                            let endDate = endTimer[index3..<index4]
                            let timer = starDate + "-" + endDate
                            self.tomorrow.append(String(timer))
                        }
                    }
                    if self.today.count > 0 {
                        let dateformatter = DateFormatter()
                        print("--------+++++%@",dateformatter)
                        dateformatter.dateFormat = "YYYY-MM-dd"// 自定义时间格式
                        let time = dateformatter.string(from: Date())
                        self.deliveryTime = String(format:"%@ %@", time , self.today[0])
                    }else{
                        self.deliveryTime = ""
                    }
                    
                }
                
            }
            }
            
        }
    }
    
//  选择优惠劵重新计算金额
    @objc func selectGoodsOrderCoupon(nofit:Notification) {
        let couponIdStr = nofit.userInfo?["couponId"] ?? ""
        let str = String(format:"%@",nofit.object as! CVarArg)
        self.couponPrice = Double(str) ?? 0.0
        self.couponId = couponIdStr as! String
        let priceModel = self.GoodsOrderListInfo
        self.sumPrice = Double(priceModel?.countSum ?? 0.00) + Double(priceModel?.sendPrice ?? 0.00) + Double(priceModel?.packPrice ?? 0.00)
        self.sumPrice =  self.sumPrice - self.couponPrice
        self.priceLabel.text =  String(format:"应付:¥%.2f",self.sumPrice ?? 0.00 as! CVarArg)
        let attributeTextPay = NSMutableAttributedString.init(string: self.priceLabel.text!)
        let countPay = self.priceLabel.text!.count
        attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(3, countPay-3))
        attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)], range: NSMakeRange(3, countPay-3))
        self.priceLabel.attributedText = attributeTextPay
        self.priceLabel.frame = CGRect(x: 25, y: 10, width:  widthForView(text: self.priceLabel.text!, font:UIFont.systemFont(ofSize: 22), height: 30), height: 30)
    }
//    确认订单去支付
    @objc func goPayShoppingButtonClick(){
        let userDefault = UserDefaults.standard
        let adders = userDefault.dictionary(forKey: "AddersDictionary") ?? nil
        if DYStringIsEmpty(value:adders!["addressId"] as AnyObject?) == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择收货地址"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            
            return
        }
        if self.deliveryTime.isEmpty == true {
            if self.today.count > 0{
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                hud.label.text = "请选择配送时间"
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1)
                return
            }else{
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                hud.label.text = "今天已休息，您可以选择明天的配送时间"
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1)
                return
            }
        }

        YDShopCartViewProvider.request(.getPayAccountGoodsOrderListInfo(orderNum:orderNumber, expectedTime:self.deliveryTime, addressId:adders!["addressId"] as! String, invoicePayable: "0", userContent:self.remarkString.unicodeStr, couponId:self.couponId, payPrice: self.sumPrice , discountPrice:self.couponPrice , token: (UserDefaults.LoginInfo.string(forKey: .token)! as String) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as String) as String)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true && json["data"] == 1{
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    NotificationCenter.default.post(name: NSNotification.Name.init("refreshDeleteGoodsCountCart"), object:nil)
                    let pay = YDPayAliWechatViewController()
                    pay.creationTimer = ""
                    pay.number = self.orderNumber
                    pay.countsumPrice = self.sumPrice
                    self.navigationController?.pushViewController(pay, animated: true)
                }else{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "订单生成失败"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    return
                }
              }
            }
        }

    }
    
}
extension YDGoShopPayViewController : UITableViewDelegate, UITableViewDataSource {
    //MARK: 当前控制器的滑动方法事件处理 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > -64{
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
        if self.GoodsListInfo?.count ?? 0 <= 2{
            return self.GoodsListInfo?.count ?? 0
        }else{
            return selectCount
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDLookGoodsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDLookGoodsListTableViewCellID, for: indexPath) as! YDLookGoodsListTableViewCell
        //  cell.delegate = self
        cell.goodListModel = self.GoodsListInfo![indexPath.row]
        cell.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        cell.selectionStyle = .none
        return cell

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isIphoneX == true {
            return 324 - 60 // 仓隐藏
        }else{
            return 300 - 60
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:YDGoShopPayHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDGoShopPayHeaderViewID) as! YDGoShopPayHeaderView
        headerView.goodOrderModel = self.GoodsOrderListInfo
        headerView.timerStr = self.today.count
        headerView.delegate = self
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDGoShopPayFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDGoShopPayFooterViewID) as! YDGoShopPayFooterView
        footerView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        footerView.goodListModel = self.GoodsOrderListInfo
        footerView.goodListCount = self.GoodsListInfo
        footerView.couponListCount = self.couponListInfo?.count ?? 0
        footerView.delegate = self
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 570
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension YDGoShopPayViewController :YDGoShopPayHeaderViewDelegate{
    func selectTimerHeaderView(timerDate: UILabel) {
        self.deliveryTime = ""
        var dictM = [String : Any]()
        if self.today.count > 0{
            dictM  = ["今天":self.today as AnyObject,"明天":self.tomorrow as AnyObject]
        }else{
            dictM  = ["明天":self.tomorrow as AnyObject]
        }
        
        YDTimePickerView.shared?.show(dataArray:dictM as NSDictionary)
        YDTimePickerView.shared?.hanSureBtnBlock = {(arr) in
            print("============%@",arr)
            if arr.count > 0{
                if arr[0] == "今天" {
                    let dateformatter = DateFormatter()
                    print("--------+++++%@",dateformatter)
                    dateformatter.dateFormat = "YYYY-MM-dd"// 自定义时间格式
                    let time = dateformatter.string(from: Date())
                    self.deliveryTime = String(format:"%@ %@", time , arr[1])
                    print("-----------%@",self.deliveryTime)
                    
                }else if arr[0] == "明天" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    let today = Date()
                    let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
                    let time = dateFormatter.string(from: nextDate!)
                    self.deliveryTime = String(format:"%@ %@", time , arr[1])
                }
                if arr[1].count > 0{
                    timerDate.text = arr[0] + arr[1]
                }else{
                    timerDate.text = ""
                    self.deliveryTime = ""
                }
            }else{
                timerDate.text = ""
                self.deliveryTime = ""
            }
           
        }
    }
    
    
    func goEditAddersHeaderView() {
        let addersVC = YDEditAddersViewController()
        self.navigationController?.pushViewController(addersVC, animated: true)
    }

}
extension YDGoShopPayViewController :YDGoShopPayFooterViewDelegate{
//    备注
    func lookGoodsListFooterView(remark: String) {
        self.remarkString = remark
        print("------------%@",self.remarkString)
    }
//    优惠劵
    func lookGoodsCouponFooterView() {
        if self.couponListInfo?.count ?? 0 > 0 {
            let couponVC = YDOrderCouponViewController()
            couponVC.couponListModel = self.couponListInfo!
            self.navigationController?.pushViewController(couponVC, animated: true)
        }
    }
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
            self.selectCount =  self.GoodsListInfo?.count ?? 0
            self.tableView.reloadData()
        }
    }
}

extension YDGoShopPayViewController:YDGoShopPayTableViewCellDelegate{
//    查看商品列表
    func lookGoodsListHeaderView() {
        if self.GoodsListInfo!.count > 0 {
            let goodList = YDLookGoodsListViewController()
            goodList.goodListModel = self.GoodsListInfo
            self.navigationController?.pushViewController(goodList, animated: true)
        }
    }
//    查看优惠卷
    func lookGoodsCouponHeaderView() {
        if self.couponListInfo?.count ?? 0 > 0 {
            let couponVC = YDOrderCouponViewController()
            couponVC.couponListModel = self.couponListInfo!
            self.navigationController?.pushViewController(couponVC, animated: true)
        }
    }
}

