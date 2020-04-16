//
//  YDMainViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/10.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import Alamofire
class YDMainViewController: UIViewController {
    let YDMainViewTableViewCellID = "YDMainViewTableViewCell"
    let YDMainViewOneTableViewCellID = "YDMainViewOneTableViewCell"
    let YDMainHeaderViewID = "YDMainHeaderView"
    let titleStr = ["收货地址","优惠券","积分","邀请有礼","我的收藏","客服/售后服务","企业招募"]
    let titleImage = ["adderss_icon_image","discounts_icon_image","integral_icon_image","gift_icon_image","collect_icon_image","server_icon_image","recruit_icon_image"]
    
    // 懒加载顶部头视图
    private lazy var headerView:YDMainHeaderView = {
        if isIphoneX == true {
            let view = YDMainHeaderView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height: 260))
            view.delegate = self
            return view
        }else{
            let view = YDMainHeaderView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height: 240))
            view.delegate = self
            return view
        }
    }()
    var wifiImage :UIImageView = {
        let wifi = UIImageView()
        wifi.isHidden = true
        wifi.image = UIImage(named:"Wifi_image")
        return wifi
    }()
    var titleName:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "哇哦，网络好像不给力哦~ \n刷新下试试吧"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    var goHome : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finisMeRequestButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("重新加载", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
//    头像
    var headImg = String()
//    昵称
    var nakname = String()
//    积分
    var integralGoods = String()
//    优惠劵
    var couponnumber = Int()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:-LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight+20), style: UITableView.Style.grouped)
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(YDMainViewTableViewCell.self, forCellReuseIdentifier: YDMainViewTableViewCellID)
        tableView.register(YDMainViewOneTableViewCell.self, forCellReuseIdentifier: YDMainViewOneTableViewCellID)
        return tableView
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "msg"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "setting"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var orderListViewModel: YDMainViewModel = {
        return YDMainViewModel()
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        currentNetReachability()
        navBarBarTintColor = YDLabelColor
//        requestUserDate()
//        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        navBarTitleColor = UIColor.white
        navBarBarTintColor = YDLabelColor
        requestUserDate()
        requestIntegralGoodsDate()
        requestCouponGoodsDate()
        self.navBarBackgroundAlpha = 0
        // 导航栏左右item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
       
        //        登录刷新
        NotificationCenter.default.addObserver(self, selector: #selector(notificationLoginRefresh(nofit:)), name: NSNotification.Name(rawValue:"refreshLoginMain"), object: nil)
        
        //        退出刷新
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpudeaRefresh(nofit:)), name: NSNotification.Name(rawValue:"refreshMain"), object: nil)
//        修改头像的刷新
         NotificationCenter.default.addObserver(self, selector: #selector(userInfoViewControllerRequestUserImage(nofit:)), name: NSNotification.Name(rawValue:"YDUserInfoViewControllerRequestUserImage"), object: nil)

        self.view.addSubview(self.wifiImage)
        self.wifiImage.frame = CGRect(x:115, y: 140, width: 260, height: 270)
        
        self.view.addSubview(self.titleName)
        self.titleName.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y:self.wifiImage.frame.maxY+10, width: 180, height: 40)
        
        self.view.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y:self.titleName.frame.maxY+30, width: 240, height: 40)
    }
    
     func currentNetReachability() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                }
//                self.requestUserDate()
//                self.requestIntegralGoodsDate()
//                self.requestCouponGoodsDate()
                self.tableView.isHidden = false
                self.view.addSubview(self.tableView)
            }
            
//            self.debugLog(statusStr as Any)
        }
        manager?.startListening()
    }

    @objc func requestUserDate(){
        if  isUserLogin() != true{
            YDUserCenterProvider.request(.getUserCenterInfo(token:UserDefaults.LoginInfo.string(forKey: .token)! as NSString, memberPhone:UserDefaults.LoginInfo.string(forKey: .phone)! as NSString)){ result  in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    if data != nil {
                        let json = JSON(data!)
                        print("-------%@",json)
                        if json["success"] == true{
                            if json["data"].isEmpty != true{
                                self.headImg = json["data"]["headImg"].string ?? ""
                                if String(format:"%@",json["data"]["name"].string ?? "").isEmpty == true{
                                    let iphone =  json["data"]["phone"].string ?? ""
                                    let endStr1 = iphone.prefix(3)
                                    let endStr2 = iphone.suffix(4)
                                    self.nakname = String(format:"%@****%@", endStr1 as CVarArg,endStr2 as CVarArg)
                                }else{
                                    self.nakname = (json["data"]["name"].string)?.unicodeStr ?? ""
                                }
                                let dict = ["name":self.nakname,"headerImage":self.headImg]
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"YDMainHeaderViewImageName"), object:nil ,userInfo:dict)
                                self.tableView.reloadData()
                        }
                    }
                    }
                }
            }
        }
    }
//    重新加载
    @objc func finisMeRequestButtonClick(){
        currentNetReachability()
    }
//    查询积分
    lazy var integralListModel: YDMainIntegralViewModel = {
        return YDMainIntegralViewModel()
    }()
    func requestIntegralGoodsDate(){
         if  isUserLogin() != true{
        // 加载数据
        integralListModel.updateDataBlock = { [unowned self] in
            self.integralGoods = self.integralListModel.integralListModel?.count ?? "0"
            self.tableView.reloadData()
        }
        integralListModel.refreshCouponDataSource(status: "1", token:  (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)
        }
    }

//    优惠劵个数查询
    lazy var couponListModel: YDGoodCouponViewMdeol = {
        return YDGoodCouponViewMdeol()
    }()
    func requestCouponGoodsDate(){
         if  isUserLogin() != true{
        // 加载数据
        couponListModel.updateDataBlock = { [unowned self] in
            self.couponnumber = self.couponListModel.couponListModel?.count ?? 0
            self.tableView.reloadData()
        }
        couponListModel.refreshCouponDataSource(status: "1",token:(UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)
        }
    }
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        
    }
    // - 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
        if isUserLogin() != true{
            let seting = YDSettingViewController()
            self.navigationController?.pushViewController(seting, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                login.modalPresentationStyle = .fullScreen
            } else {
                // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
        
    }
    //    登录刷新
    @objc func notificationLoginRefresh(nofit:Notification) {
        requestUserDate()
        requestIntegralGoodsDate()
        requestCouponGoodsDate()
        self.tableView.reloadData()
    }
    //    退出刷新
    @objc func notificationUpudeaRefresh(nofit:Notification) {
        orderListViewModel.orderListModel?.removeAll()
        self.tableView.reloadData()
    }
//    修改头像的刷新
    @objc func userInfoViewControllerRequestUserImage(nofit:Notification){
        self.requestUserDate()
    }
}
extension YDMainViewController : UITableViewDelegate, UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 3{
            return 75
        }else{
             return 45
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3{
            let cell:YDMainViewOneTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDMainViewOneTableViewCellID, for: indexPath) as! YDMainViewOneTableViewCell
            cell.titleName = titleStr[indexPath.row]
            cell.titleImage = titleImage[indexPath.row]
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }else{
            let cell:YDMainViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDMainViewTableViewCellID, for: indexPath) as! YDMainViewTableViewCell
            cell.titleName = titleStr[indexPath.row]
            cell.titleImage = titleImage[indexPath.row]
            cell.selectionStyle = .none
            if indexPath.row == 1{
                cell.number = self.couponnumber
            }else if indexPath.row == 2{
                cell.integral = self.integralGoods
            }
            return cell
        }
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            if isUserLogin() != true{
                let adderVC = YDEditAddersViewController()
                self.navigationController?.pushViewController(adderVC, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                           } else {
                               // Fallback on earlier versions
                           }
                self.present(login, animated: true, completion: nil)
            }
           
        }else if indexPath.row == 1 {
            if isUserLogin() != true{
                let coupon = YDGoodCouponViewController()
                self.navigationController?.pushViewController(coupon, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                           } else {
                               // Fallback on earlier versions
                           }
                self.present(login, animated: true, completion: nil)
            }
        }else if indexPath.row == 2 {
            if isUserLogin() != true{
                let integraVC = YDMainIntegralViewController()
                self.navigationController?.pushViewController(integraVC, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                           } else {
                               // Fallback on earlier versions
                           }
                self.present(login, animated: true, completion: nil)
            }
        }else if indexPath.row == 3 {
            
            if isUserLogin() != true{
                let collectVC = YDInvitationFriendViewController()
                self.navigationController?.pushViewController(collectVC, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                } else {
                               // Fallback on earlier versions
                }
                self.present(login, animated: true, completion: nil)
            }
            
        }else if indexPath.row == 4 {
            if isUserLogin() != true{
                let collectVC = YDCollectGoodsViewController()
                self.navigationController?.pushViewController(collectVC, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                           } else {
                               // Fallback on earlier versions
                           }
                self.present(login, animated: true, completion: nil)
            }
        }else if indexPath.row == 5 {
            let serverVC = YDServiceLinkmanViewController()
            self.navigationController?.pushViewController(serverVC, animated: true)
        }else if indexPath.row == 6 {
            if isUserLogin() != true{
                let collectVC = YDRecruitPersonnelViewController()
                self.navigationController?.pushViewController(collectVC, animated: true)
            }else{
                let  login = YDUserLoginViewController()
                if #available(iOS 13.0, *) {
                               login.modalPresentationStyle = .fullScreen
                    } else {
                               // Fallback on earlier versions
                }
                self.present(login, animated: true, completion: nil)
            }
        }
//        let model = self.orderListViewModel.orderListModel?[indexPath.row]
//        let detailsVC = YDOrderDetailsViewController()
//        detailsVC.orderNumber = model?.orderNum ?? ""
//        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
//邀请有礼
extension YDMainViewController : YDMainViewOneTableViewCellDelegate{
    func goSelectInviteFriendTableViewCell() {
        if isUserLogin() != true{
            let collectVC = YDInvitationFriendViewController()
            self.navigationController?.pushViewController(collectVC, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                login.modalPresentationStyle = .fullScreen
            } else {
                           // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
    }
}
extension YDMainViewController :YDMainHeaderViewDelegate{
// MARK: --------------   登录注册
    func userLoginRegisterButtonClickHeaderView() {
        let  login = YDUserLoginViewController()
        if #available(iOS 13.0, *) {
            login.modalPresentationStyle = .fullScreen
        } else {
                       // Fallback on earlier versions
        }
        self.present(login, animated: true, completion: nil)
    }
// MARK: --------------   个人信息
    func userDataHeaderBannerClickHeaderView() {
        if isUserLogin() != true{
            let userVc = YDUserInfoViewController()
            self.navigationController?.pushViewController(userVc, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                login.modalPresentationStyle = .fullScreen
            } else {
                           // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
    }
// MARK: --------------   待支付订单
    func awaitPayOrderButtonClickHeaderView() {
        if isUserLogin() != true{
            let order = YDOrderViewController()
            order.index = 1
            self.navigationController?.pushViewController(order, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                           login.modalPresentationStyle = .fullScreen
            } else {
                           // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
    }
// MARK: --------------   待收货订单
    func awaitTakeOrderButtonClickHeaderView() {
        if isUserLogin() != true{
            let order = YDOrderViewController()
            order.index = 2
            self.navigationController?.pushViewController(order, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                           login.modalPresentationStyle = .fullScreen
                       } else {
                           // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
    }
// MARK: --------------   待评论订单
    func awaitCommentOrderButtonClickHeaderView() {
        if isUserLogin() != true{
            let order = YDOrderViewController()
            order.index = 3
            self.navigationController?.pushViewController(order, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                           login.modalPresentationStyle = .fullScreen
                       } else {
                           // Fallback on earlier versions
                       }
            self.present(login, animated: true, completion: nil)
        }
    }
    
// MARK: --------------   全部订单
    func allOrderListHeaderView() {
        if isUserLogin() != true{
            let order = YDOrderViewController()
            order.index = 0
            self.navigationController?.pushViewController(order, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                           login.modalPresentationStyle = .fullScreen
                       } else {
                           // Fallback on earlier versions
                       }
            self.present(login, animated: true, completion: nil)
        }
    }

}

extension YDMainViewController : YDOrderListTableViewCellDelegate{
    func reconfirmGoodsPayCancelTableViewCell(cancel: UIButton) {
        
    }
// MARK: --------------   评论
    func reconfirmGoodsCommentTableViewCell(commentBtn:UIButton) {
        let model = self.orderListViewModel.orderListModel?[commentBtn.tag]
        let comment =   YDGoodsCommentViewController()
        comment.orderNum = model?.orderNum ?? ""
        self.navigationController?.pushViewController(comment, animated: true)
    }
// MARK: --------------   再次购买
    func reconfirmGoodsBuyAgainTableViewCell(buyAgain: UIButton) {
        let modelNumber = self.orderListViewModel.orderListModel?[buyAgain.tag]
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        YDShopGoodsListProvider.request(.getOrderBuyAgainCartGoodsLikeList(orderNum: modelNumber?.orderNum ?? "",deviceNumber:uuid,token:(UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{

                    let alertController = UIAlertController(title: "商品已加入购物车",
                                                            message: "", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "留在此页", style: .cancel, handler: {action in
                    self.navigationController?.popViewController(animated: true)

                    })
                    
                    let okAction = UIAlertAction(title: "去购物车", style: .default,
                                                 handler: {action in
                    self.tabBarController?.selectedIndex = 2
                    self.navigationController?.popViewController(animated: true)
                    

                    })
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        }

    }
// MARK: --------------  去支付
    func reconfirmGoodsoPayMentTableViewCell(payBtn: UIButton) {
   
        if self.orderListViewModel.orderListModel?[payBtn.tag].list?.count ?? 0 > 0 {
            let modelNumber = self.orderListViewModel.orderListModel?[payBtn.tag].list?[0]
            let pay = YDPayAliWechatViewController()
            pay.number = modelNumber?.orderNum ?? ""
            pay.countsumPrice = modelNumber?.countsum ?? 0.00
            self.navigationController?.pushViewController(pay, animated: true)
        }
       
    }
// MARK: --------------   申请退款
    func reconfirmGoodsPayReimburseTableViewCell(Reimburse: UIButton) {
        
        let applyVC = YDApplyRefundViewController()
        self.navigationController?.pushViewController(applyVC, animated: true)
        
//        let model = self.orderListViewModel.orderListModel?[Reimburse.tag]
//
//        if model?.payType == "1"{
//                    let alertController = UIAlertController(title: "是否确认退款",
//                                                            message: "", preferredStyle: .alert)
//                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {action in
//                        self.navigationController?.popViewController(animated: true)
//
//                    })
//                    let okAction = UIAlertAction(title: "确定", style: .default,
//                                                 handler: {action in
//                                                    let model = self.orderListViewModel.orderListModel?[Reimburse.tag]
//                                                    YDShopCartViewProvider.request(.getGoodsCartAlipayReimburse(orderNum: model?.orderNum ?? "", token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
//                                                        if case let .success(response) = result {
//                                                            //解析数据
//                                                            let data = try? response.mapJSON()
//                                                            let json = JSON(data!)
//                                                            print("支付宝---------------%@",json)
//                                                            if json == true{
//                                                                self.requestClassifyGoodsDate()
//                                                                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                                                                hud.mode = MBProgressHUDMode.text
//                                                                hud.label.text = "申请成功"
//                                                                hud.removeFromSuperViewOnHide = true
//                                                                hud.hide(animated: true, afterDelay: 1)
//
//                                                            }else{
//                                                                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                                                                hud.mode = MBProgressHUDMode.text
//                                                                hud.label.text = "申请失败"
//                                                                hud.removeFromSuperViewOnHide = true
//                                                                hud.hide(animated: true, afterDelay: 1)
//                                                            }
//
//                                                        }
//                                                    }
//
//                    })
//
//                    alertController.addAction(cancelAction)
//                    alertController.addAction(okAction)
//                    self.present(alertController, animated: true, completion: nil)
//
//        }else if model?.payType == "2"{
//            let alertController = UIAlertController(title: "是否确认退款",
//                                                    message: "", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {action in
//                self.navigationController?.popViewController(animated: true)
//
//            })
//            let okAction = UIAlertAction(title: "确定", style: .default,
//                                         handler: {action in
//                                            let model = self.orderListViewModel.orderListModel?[Reimburse.tag]
//                                YDShopCartViewProvider.request(.getGoodsCartWeChatPayReimburse(orderNo: model?.orderNum ?? "",memberId:UserDefaults.LoginInfo.string(forKey: .id) ?? "", token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
//                                                if case let .success(response) = result {
//                                                    //解析数据
//                                                    let data = try? response.mapJSON()
//                                                    let json = JSON(data!)
//                                                    print("微信---------------%@",json)
//                                                    if json == true{
//                                                        self.requestClassifyGoodsDate()
//                                                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                                                        hud.mode = MBProgressHUDMode.text
//                                                        hud.label.text = "申请成功"
//                                                        hud.removeFromSuperViewOnHide = true
//                                                        hud.hide(animated: true, afterDelay: 1)
//
//                                                    }else{
//                                                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                                                        hud.mode = MBProgressHUDMode.text
//                                                        hud.label.text = "申请失败"
//                                                        hud.removeFromSuperViewOnHide = true
//                                                        hud.hide(animated: true, afterDelay: 1)
//                                                    }
//
//                                                }
//                                            }
//
//            })
//
//            alertController.addAction(cancelAction)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//
    }
}
