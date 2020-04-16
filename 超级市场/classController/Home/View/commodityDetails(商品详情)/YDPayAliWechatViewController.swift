//
//  YDPayAliWechatViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDPayAliWechatViewController: YDBasicViewController {

    let countDownTimer = WMCountDown()
//    区分从购物车支付还是订单支付
    var typeId = String()
//    订单号
    var orderNumber = String()
//   金额
    var countSum = Double()
    var typeString = String()
    var creationTimer = String()
    private lazy var backView : UIView = {
        let baclView = UIView()
        baclView.backgroundColor = YDLabelColor
        return baclView
    }()
    private lazy var moneyLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "¥0.00"
        return label
    }()
    private lazy var timerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "支付倒计时 30:00"
        return label
    }()
    
    private lazy var backPayView : UIView = {
        let baclView = UIView()
        baclView.backgroundColor = UIColor.white
        return baclView
    }()
    
    private lazy var wechatImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"wecher_iamge")
        return imageView
    }()
    
    private lazy var wechatLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "微信支付"
        return label
    }()
    
    private lazy var wechatBtn:UIButton = {
        let button = UIButton()
        button.isSelected = true
//        button.backgroundColor = UIColor.red
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:-LBFMScreenWidth+70)
        button.setImage(UIImage(named:"noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named:"selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(payWeChatButtonClick(weChat:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var alipayImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"alipay_image")
        return imageView
    }()
    
    private lazy var alipayLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "支付宝支付"
        return label
    }()
    
    private lazy var alipayBtn:UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.red
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right:-LBFMScreenWidth+70)
        button.addTarget(self, action: #selector(payAlipayButtonClick(Alipay:)), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named:"noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named:"selectGoodsImage"), for: UIControl.State.selected)
        return button
    }()
    
    private lazy var unionpayImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"Unionpay_iamge")
        return imageView
    }()
    
    private lazy var unionpayLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "银联云支付"
        return label
    }()
    
    private lazy var unionpayBtn:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named:"selectGoodsImage"), for: UIControl.State.selected)
        return button
    }()
    
    private lazy var goPayBtn:UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("确认支付", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goGoodsCartListPay), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    // - 导航栏左边按钮
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:5, width:20, height: 20)
        button.addTarget(self, action: #selector(selectBackButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named:"bb_navigation_back"), for: .normal)
        return button
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"service_Image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarSelectButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         navBarBarTintColor = YDLabelColor
        self.title = "收银台"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.typeString = "1"
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y:64, width: LBFMScreenWidth, height: 95)
        self.backView.addSubview(self.moneyLabel)
        self.moneyLabel.frame = CGRect(x: 0, y: 20, width: LBFMScreenWidth, height: 35)
        
        self.backView.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: 0, y: self.moneyLabel.frame.maxY+10, width: LBFMScreenWidth, height: 10)
//        微信
        self.view.addSubview(self.backPayView)
        self.backPayView.frame = CGRect(x: 15, y: self.backView.frame.maxY+25, width: LBFMScreenWidth-30, height: 120)
        
        self.backPayView.addSubview(self.wechatImage)
        self.wechatImage.frame = CGRect(x: 15, y: 20, width: 25, height: 25)
        
        self.backPayView.addSubview(self.wechatLabel)
        self.wechatLabel.frame = CGRect(x: self.wechatImage.frame.maxX+10, y: 20, width: 70, height: 25)
        
        self.backPayView.addSubview(self.wechatBtn)
        self.wechatBtn.frame = CGRect(x: 0, y: 10, width:LBFMScreenWidth-32, height: 35)
        
//        支付宝
        
        self.backPayView.addSubview(self.alipayImage)
        self.alipayImage.frame = CGRect(x: 15, y: self.wechatImage.frame.maxY+25, width: 25, height: 25)
        
        self.backPayView.addSubview(self.alipayLabel)
        self.alipayLabel.frame = CGRect(x: self.wechatImage.frame.maxX+10, y: self.wechatImage.frame.maxY+25, width:90, height: 25)
        
        self.backPayView.addSubview(self.alipayBtn)
        self.alipayBtn.frame = CGRect(x:0, y: self.wechatBtn.frame.maxY+17, width:LBFMScreenWidth-30, height: 35)
        
//        银联云支付
//        self.backPayView.addSubview(self.unionpayImage)
        self.unionpayImage.frame = CGRect(x: 15, y: self.alipayImage.frame.maxY+25, width: 25, height: 25)
        
//        self.backPayView.addSubview(self.unionpayLabel)
        self.unionpayLabel.frame = CGRect(x: self.wechatImage.frame.maxX+10, y: self.alipayImage.frame.maxY+25, width: 90, height: 25)
        
//        self.backPayView.addSubview(self.unionpayBtn)
        self.unionpayBtn.frame = CGRect(x: self.backPayView.frame.maxX-54, y: self.alipayBtn.frame.maxY+30, width: 18, height: 18)
        
        
        self.view.addSubview(self.goPayBtn)
        self.goPayBtn.frame = CGRect(x: 15, y: LBFMScreenHeight-65, width: LBFMScreenWidth-30, height: 50)
        
//        支付宝
        NotificationCenter.default.addObserver(self, selector: #selector(addGoodsOrderaliPaySucceess(nofit:)), name: NSNotification.Name(rawValue:"aliPaySucceess"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(addGoodsOrderalialiPayUnknowStatus(nofit:)), name: NSNotification.Name(rawValue:"aliPayUnknowStatus"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addGoodsOrderalialialiPayDefeat(nofit:)), name: NSNotification.Name(rawValue:"aliPayDefeat"), object: nil)

//        微信
         NotificationCenter.default.addObserver(self, selector: #selector(addGoodsOrderdidWXPaySucceededPayDefeat(nofit:)), name: NSNotification.Name(rawValue:"didWXPaySucceeded"), object: nil)

        
         NotificationCenter.default.addObserver(self, selector: #selector(addGoodsOrderdidWXPayFailedPayDefeat(nofit:)), name: NSNotification.Name(rawValue:"didWXPayFailed"), object: nil)


        countDownTimer.countDown = { [weak self] (m, s) in
            let time = m + ":" + s
            self?.timerLabel.text = "支付倒计时 " + time
            print("支付倒计时 \(m):\(s)")
        }
        if creationTimer.isEmpty == true{
            let date = Date()
            let timeFormatter = DateFormatter()
            //日期显示格式，可按自己需求显示
            timeFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
            let strNowTime = timeFormatter.string(from: date) as String
            let nowLater = Date.init(timeIntervalSinceNow: 1800)// 比GMT时间晚1分钟
            let endTimer = timeFormatter.string(from: nowLater) as String
            countDownTimer.start(with: strNowTime, end: endTimer)
        }else{
            let date = Date()
            let timeFormatter = DateFormatter()
            //日期显示格式，可按自己需求显示
            timeFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
             let strNowTime = timeFormatter.string(from: date) as String
            
            let timer = creationTimer.prefix(19)
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date1 = dateFormatter.date(from:String(timer))!
            
            let interval = date.timeIntervalSince(date1)
            let second = 1800 - Int(round(interval))
            print("------------%d",interval)
            
            let nowLater = Date.init(timeIntervalSinceNow:TimeInterval(Int(second)))// 比GMT时间晚1分钟
            let endTimer = timeFormatter.string(from: nowLater) as String
            countDownTimer.start(with:strNowTime, end: endTimer)
            
        }

        
    }
    //    客服
    @objc func rightBarSelectButtonClick(){
         hw_callPhone("13482814061")
    }
//    返回
    @objc func selectBackButtonClick(){
     
        if typeId == "999"{
            self.navigationController?.popViewController(animated:true)
        }else{
            let orderVC = YDOrderDetailsViewController()
            orderVC.orderNumber = self.orderNumber
            orderVC.backStr = "888"
            self.navigationController?.pushViewController(orderVC, animated:true)
        }
       
        countDownTimer.stop()
    }
    var countsumPrice:Double = 0.00{
        didSet {
            self.countSum = countsumPrice
            self.moneyLabel.text = String(format: "¥%.2f",self.countSum)
        }
    }
    var number : String = ""{
        didSet {
            self.orderNumber = number
        }
    }

//    支付宝支付成功
    @objc func addGoodsOrderaliPaySucceess(nofit:NSNotification){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = "支付成功"
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
        
        let Finish = YDPayFinishViewController()
        Finish.orderNumber = self.orderNumber
        Finish.countsumPrice = self.countSum
        self.navigationController?.pushViewController(Finish, animated: true)
    }
//   支付宝 支付失败
    @objc func addGoodsOrderalialiPayUnknowStatus(nofit:NSNotification){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = nofit.object as? String
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
    }
//   支付宝支付失败
    @objc func addGoodsOrderalialialiPayDefeat(nofit:NSNotification){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text =  nofit.object as? String
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
    }
//  微信支付
        @objc func addGoodsOrderdidWXPaySucceededPayDefeat(nofit:NSNotification){
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "支付成功"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            
            let Finish = YDPayFinishViewController()
            Finish.orderNumber = self.orderNumber
            Finish.countsumPrice = self.countSum
            self.navigationController?.pushViewController(Finish, animated: true)
        }
    @objc func addGoodsOrderdidWXPayFailedPayDefeat(nofit:NSNotification){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = "支付失败"
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
    }
//    微信支付
    @objc func payWeChatButtonClick(weChat:UIButton){
        weChat.isSelected = true
        self.alipayBtn.isSelected = false
        self.typeString = "1"
    }
//    支付宝
    @objc func payAlipayButtonClick(Alipay:UIButton){
        Alipay.isSelected = true
        self.wechatBtn.isSelected = false
        self.typeString = "2"
    }
    //  确认支付
    @objc func goGoodsCartListPay(){
//        let date = Date()
//        let timer = creationTimer.prefix(19)
//        let dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date1 = dateFormatter.date(from:String(timer))!
//        let interval = date.timeIntervalSince(date1)
//        let second =  Int(round(interval))
//        if second < 1800 {
            if self.typeString == "1" {
                payWeChat()
            }else if self.typeString == "2"{
                payAlipay()
            }
//        }else{
//            YDShopCartViewProvider.request(.getOrderGoodCancelListInfo(orderNum:self.orderNumber, cancelReason:"订单超时", token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
//                if case let .success(response) = result {
//                    let data = try? response.mapJSON()
//                    let json = JSON(data!)
//                    print("------------------%@",json)
//                    if json["success"] == true{
//                        
//                    }else{
//                        
//                    }
//                }
//            }
//        }
    }

//    支付宝支付
    @objc func payAlipay(){
        YDShopCartViewProvider.request(.getGoodsCartListAlipaySDK(orderNum:self.orderNumber, body: self.orderNumber,countsum:self.countSum, token:UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-----------%@",json)
                let sign = String(describing:json["body"])

                AlipaySDK.defaultService()?.payOrder(sign, dynamicLaunch: true, fromScheme: "AlipayHuiXian", callback: { (result) in
//                    print("------------%@",result)
                })
            }
        }
    }
    
//    微信支付
    @objc func payWeChat(){
        YDClassifyViewProvider.request(.getGoodsOrderCartWeChatPay(orderNum: self.orderNumber, countsum: self.countSum, body:self.orderNumber,memberId:UserDefaults.LoginInfo.string(forKey: .id) ?? "",token: UserDefaults.LoginInfo.string(forKey: .token) as! String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-----------%@",json["data"])
                if  !WXApi.isWXAppInstalled(){
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "没有安装微信"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    return
                }
                let req = PayReq()
                req.partnerId = json["data"]["partnerid"].string ?? ""
                req.nonceStr = json["data"]["noncestr"].string ?? ""
                req.prepayId = json["data"]["prepayid"].string ?? ""
                req.timeStamp = UInt32(String(format:"%@", json["data"]["timestamp"].string ?? "" as CVarArg)) ?? 0
                req.openID = json["data"]["appid"].string ?? ""
                req.sign = json["data"]["sign"].string ?? ""
                req.package = "Sign=WXPay"
                WXApi.send(req)
            print("appid=\(req.openID)\npartid=\(req.partnerId)\nprepayid=\(req.prepayId)\nnoncestr=\(req.nonceStr)\ntimestamp=\(req.timeStamp)\npackage=\(req.package)\nsign=\(req.sign)");

            }
            }
        }
    }
    deinit {
        countDownTimer.stop()
    }
}

