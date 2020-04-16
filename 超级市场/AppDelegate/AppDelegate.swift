//
//  AppDelegate.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages
import IQKeyboardManagerSwift

var search: AMapSearchAPI!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate,AMapLocationManagerDelegate{
    var window: UIWindow?
    let locationManager = AMapLocationManager()
    let locationManager1 = CLLocationManager()
    let home = YDHomeViewController()
    let classify = YDClassifyViewController()
    let shopCart = YDShopCartViewController()
    let main = YDMainViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        高德地图
        AMapServices.shared().apiKey = "5fc3110e41f62b86e43bb94983a4ade2"
//        loadLocation()
//        Thread.sleep(forTimeInterval: 3.0) //延长3秒
        //        友盟推送
        UMConfigure.initWithAppkey("5e1d6078570df38d5f000263", channel: "App Store")
        UMConfigure.setLogEnabled(true)
        UMConfigure.setEncryptEnabled(true)
        UMConfigure.deviceIDForIntegration()
        // push组件基本功能配置
        let entity = UMessageRegisterEntity.init()
        //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
        entity.types = Int(UMessageAuthorizationOptions.badge.rawValue|UMessageAuthorizationOptions.sound.rawValue|UMessageAuthorizationOptions.alert.rawValue)
        if #available(iOS 10.0, *) {
            let action1 = UNNotificationAction.init(identifier: "action1_identifier", title: "打开应用", options: .foreground)
            let action2 = UNNotificationAction.init(identifier: "action2_identifier", title: "忽略", options: .foreground)
            //UNNotificationCategoryOptionNone
            //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
            //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
            let category1 = UNNotificationCategory.init(identifier: "category1", actions: [action1, action2], intentIdentifiers: [], options: .customDismissAction)
            let categories = NSSet.init(objects: category1)
            entity.categories = (categories as! Set<AnyHashable>)
            UNUserNotificationCenter.current().delegate = self
            UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
                if granted {
                    
                } else {
                    
                }
            }
        }else {
            // Fallback on earlier versions
            let action1 = UIMutableUserNotificationAction.init()
            action1.identifier = "action1_identifier"
            action1.title = "打开应用"
            action1.activationMode = .foreground
            let action2 = UIMutableUserNotificationAction.init()
            action2.identifier = "action2_identifier"
            action2.title = "忽略"
            action2.activationMode = .background //当点击的时候不启动程序，在后台处理
            action2.isAuthenticationRequired = true //需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
            action2.isDestructive = true
            let actionCategory1 = UIMutableUserNotificationCategory.init()
            actionCategory1.identifier = "category1" // 这组动作的唯一标示
            actionCategory1.setActions([action1, action2], for: .default)
            let categories = NSSet.init(objects: actionCategory1)
            entity.categories = (categories as! Set<AnyHashable>)
        }

        //        微信注册
        WXApi.registerApp("wx3bdbc5d61eaee4c9")
        IQKeyboardManager.shared.enable = true

        NotificationCenter.default.addObserver(self, selector: #selector(returnCartSumNumberValue(nofit:)), name: NSNotification.Name(rawValue:YDCartSumNumber), object: nil)
        // 1.加载tabbar样式
        let tabbar = self.setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        //        tabbar.isTranslucent = false
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = tabbar
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        
        
        let tabBarController = ESTabBarController()
        //        tabBarController.tabBar.isTranslucent = false
        //        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.delegate = delegate
        //        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        home.tabBarItem = ESTabBarItem.init(YDIrregularitBasicContentView(), title: "首页", image: UIImage(named: "HomeIcon"), selectedImage: UIImage(named: "HomeIcon_H"))
        classify.tabBarItem = ESTabBarItem.init(YDIrregularitBasicContentView(), title: "分类", image: UIImage(named: "ClassifyIcon"), selectedImage: UIImage(named: "ClassifyIcon_H"))
        shopCart.tabBarItem = ESTabBarItem.init(YDIrregularitBasicContentView(), title: "购物车", image: UIImage(named: "CartIcon"), selectedImage: UIImage(named: "CartIcon_H"))
        main.tabBarItem = ESTabBarItem.init(YDIrregularitBasicContentView(), title: "我的", image: UIImage(named: "MainIcon"), selectedImage: UIImage(named: "MainIcon_H"))
        let homeNav = YDMainNavigationController.init(rootViewController: home)
        let classifyNav = YDMainNavigationController.init(rootViewController: classify)
        let shopCartNav = YDMainNavigationController.init(rootViewController: shopCart)
        let mainNav = YDMainNavigationController.init(rootViewController: main)
        
        home.title = "首页"
        home.navBarTitleColor = UIColor.white
        classify.title = "分类"
        shopCart.title = "购物车"
        main.title = "我的"
        
        tabBarController.viewControllers = [homeNav, classifyNav, shopCartNav, mainNav]
        return tabBarController
        
    }
   //打开定位
        func loadLocation()
        {
//            self.locationManager1.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
//            self.locationManager1.requestAlwaysAuthorization()                            //始终授权
            //        定位
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.locationTimeout = 2
            locationManager.reGeocodeTimeout = 2
            locationManager.delegate = self
            locationManager.locatingWithReGeocode = true
            locationManager.distanceFilter = 300
            self.locationManager.requestLocation(withReGeocode: true) { (location, regeocode, error) in
                if (error == nil){
                    let locationStr = String(describing:location)
                    let index3 = locationStr.index(locationStr.startIndex, offsetBy: 11)
                    let index4 = locationStr.index(locationStr.startIndex, offsetBy: 22)
                    let latitude = locationStr[index3..<index4]
                    
                    let index1 = locationStr.index(locationStr.startIndex, offsetBy: 24)
                    let index2 = locationStr.index(locationStr.startIndex, offsetBy: 36)
                    let location = locationStr[index1..<index2]
                    print("%@=============%@",latitude,location)
                    UserDefaults.AccountInfo.set(value:"123", forKey:.latitudeStr)
                    UserDefaults.AccountInfo.set(value:"123", forKey:.locationStr)

                    let addersInfo = String(regeocode!.province ?? "") + String(regeocode!.city ?? "") + String(regeocode!.district ?? "")

                    UserDefaults.AccountInfo.set(value:addersInfo, forKey:.addersInfo)
                    UserDefaults.AccountInfo.set(value:regeocode!.poiName ?? "", forKey:.addersName)
                    UserDefaults.AccountInfo.set(value:regeocode!.city ?? "", forKey:.cityName)
                }
            }
            
        }
    @objc func returnCartSumNumberValue(nofit:Notification) {
        let str = nofit.userInfo!["namber"]
        let strValue1 = String(format:"%d",str as! CVarArg)
        if  strValue1 !=  "0" {
            shopCart.tabBarItem.badgeValue = strValue1
        }else{
            shopCart.tabBarItem.badgeValue = ""
        }
        
    }
    //    微信
    func onReq(_ req: BaseReq) {
        
    }
    func onResp(_ resp: BaseResp) {
        if resp is SendAuthResp {
            print("resp----------------",resp)
            // 微信登录
            if resp.errCode == 0 && resp.type == 0 {
                let _resp = resp as! SendAuthResp
                if let code = _resp.code {
                    let urlString = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx3bdbc5d61eaee4c9&secret=e1643595afee64dad4f6f8f20ed8df2c&code=\(code)&grant_type=authorization_code"
                    var request = URLRequest(url: URL(string: urlString)!)
                    request.httpMethod = "GET"
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        
                        DispatchQueue.main.async(execute: {
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            if error == nil && data != nil {
                                do {
                                    let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                                    print("----------------",dic)
                                    let access_token = dic["access_token"] as! String
                                    let openID = dic["openid"] as! String
                                    self.requestUserInfo(access_token, openID)
                                } catch  {
                                    print(#function)
                                }
                                return
                            }
                        })
                    }.resume()
                    //                    wxDelegate.loginSuccessByCode(code: code)
                    //                     print("state%@--code%@--country%@----lang%@",_resp.state,_resp.code,_resp.country,_resp.lang)
                }
                
            } else {
                
                print(resp.errStr)
            }
        } else if resp is SendMessageToWXResp {
            // 分享
            let send = resp as? SendMessageToWXResp
            if let sm = send {
                if sm.errCode == 0 {
                    print("分享成功")
                } else {
                    print("分享失败")
                }
            }
        } else  if let payResp = resp as? PayResp {
            switch payResp.errCode {
            case WXSuccess.rawValue:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"didWXPaySucceeded"), object: nil)
                print("支付成功")
            default:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"didWXPayFailed"), object: nil)
                print("支付失败")
            }
        }
    }
    
    func requestUserInfo(_ token: String, _ openID: String) {
        
        let urlString = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openID)"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async(execute: {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if error == nil && data != nil {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                        //dic当中包含了微信登录的个人信息，用于用户创建、登录、绑定等使用
                        print("------------------",#line, dic)
                        UserDefaults.WeChatLoginInfo.set(value: dic["openid"] as? String, forKey: .openid)
                        UserDefaults.WeChatLoginInfo.set(value: dic["unionid"] as? String, forKey: .unionid)
                        UserDefaults.WeChatLoginInfo.set(value: (dic["nickname"] as? String)?.unicodeStr, forKey: .nickname)
                        UserDefaults.WeChatLoginInfo.set(value: dic["headimgurl"] as? String, forKey: .headimgurl)
                        UserDefaults.WeChatLoginInfo.set(value: dic["city"] as? String, forKey: .city)
                        UserDefaults.WeChatLoginInfo.set(value: dic["country"] as? String, forKey: .country)
                        UserDefaults.WeChatLoginInfo.set(value: dic["province"] as? String, forKey: .province)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"weChatLoginSucceess"), object:nil)
                    } catch  {
                        //                        print(#function)
                    }
                    return
                }
            })
        }.resume()
    }
    //    支付宝
    
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if url.scheme == "wx3bdbc5d61eaee4c9" {
            return WXApi.handleOpen(url as URL, delegate: self)
        }
        if url.host == "safepay"{
            AlipaySDK.defaultService().processOrder(withPaymentResult: url as URL){
                value in
                let code = value!
                let resultStatus = code["resultStatus"] as!String
                var content = ""
                switch resultStatus {
                case "9000":
                    content = "支付成功"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPaySucceess"), object: content)
                case "8000":
                    content = "订单正在处理中"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayUnknowStatus"), object: content)
                case "4000":
                    content = "支付失败"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "5000":
                    content = "重复请求"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "6001":
                    content = "中途取消"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "6002":
                    content = "网络连接出错"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefault"), object: content)
                case "6004":
                    content = "支付结果未知"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayUnknowStatus"), object: content)
                default:
                    content = "支付失败"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                    break
                }
            }
        }
        return true
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "wx3bdbc5d61eaee4c9" {
            return WXApi.handleOpen(url as URL, delegate: self)
        }
        if url.host == "safepay"{
            
            AlipaySDK.defaultService().processOrder(withPaymentResult: url){
                value in
                let code = value!
                let resultStatus = code["resultStatus"] as!String
                var content = ""
                switch resultStatus {
                case "9000":
                    content = "支付成功"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPaySucceess"), object: content)
                case "8000":
                    content = "订单正在处理中"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayUnknowStatus"), object: content)
                case "4000":
                    content = "支付失败"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "5000":
                    content = "重复请求"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "6001":
                    content = "中途取消"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                case "6002":
                    content = "网络连接出错"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefault"), object: content)
                case "6004":
                    content = "支付结果未知"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayUnknowStatus"), object: content)
                default:
                    content = "支付失败"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aliPayDefeat"), object: content)
                    break
                }
            }
        }
        return true
        
    }
}
extension AppDelegate:UNUserNotificationCenterDelegate{
   //iOS10以下使用这个方法接收通知
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
          UMessage.didReceiveRemoteNotification(userInfo)
          
      }

      @available(iOS 10.0, *)
      //iOS10新增：处理前台收到通知的代理方法
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          let userInfo = notification.request.content.userInfo
          if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
              let info = userInfo as NSDictionary
              print(info)
              //应用处于前台时的远程推送接受
              UMessage.setAutoAlert(false)
              UMessage.didReceiveRemoteNotification(userInfo)
          }else{
              //应用处于前台时的远程推送接受
          }
          completionHandler([.alert,.sound,.badge])
      }
      @available(iOS 10.0, *)
      //iOS10新增：处理后台点击通知的代理方法
      func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
          let userInfo = response.notification.request.content.userInfo
          if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
              let info = userInfo as NSDictionary
              print(info)
              //应用处于后台时的远程推送接受
              UMessage.didReceiveRemoteNotification(userInfo)
          }else{
              //应用处于前台时的远程推送接受
          }
      }
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if #available(iOS 13.0, *) {
             var deviceTokenString = String()
             let bytes = [UInt8](deviceToken)
             for item in bytes {
                deviceTokenString += String(format:"%02x", item&0x000000FF)
             }
            print("deviceToken：\(deviceTokenString)")
        }else{
             let token: NSMutableString = NSMutableString(format: "%@", deviceToken as CVarArg)
                 token.replaceOccurrences(of: " ", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
                 token.replaceOccurrences(of: "<", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
                 token.replaceOccurrences(of: ">", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
                 
                 print("token",token);
        }
      }
}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



