//
//  YDUserLoginViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDUserLoginViewController: YDBasicViewController,UITextFieldDelegate {
    private var typeID = NSString()
    private var token = NSString()
    
    private lazy var iphoneTitle:UILabel = {
        let label = UILabel()
        label.text = "手机号"
        label.isHidden = true
        label.textColor = YDLabelColor
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        return label
    }()
    private lazy var backImage : UIImageView = {
           let  backImage = UIImageView()
            backImage.image = UIImage(named: "back_image")
            return backImage
    }()
    
    
    private lazy var popButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeIcon"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backtrackButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var codeButton:UIButton = {
        let button = UIButton()
        button.setTitle("密码登录", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(codeBackButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var iphoneField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "请输入手机号"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.delegate = self
        // 自动更正功能
        //        textField.autocorrectionType = UITextAutocorrectionType.no
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.numberPad
        // 键盘外观
        //        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
        //        textField.isSecureTextEntry = false
        return textField
    }()
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var codeField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "请输入验证码"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        // 自动更正功能
        //        textField.autocorrectionType = UITextAutocorrectionType.no
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.numberPad
        // 键盘外观
        //        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
        //        textField.isSecureTextEntry = false
        return textField
    }()
    private lazy var passwordField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "请输入密码"
        textField.layer.cornerRadius = 5
        textField.isHidden = true
        textField.clipsToBounds = true
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 14)
        // 自动更正功能
        //        textField.autocorrectionType = UITextAutocorrectionType.no
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.`default`
        // 键盘外观
        //        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
        textField.isSecureTextEntry = true
        return textField
    }()
    private lazy var lookBtn : SendCodeBtn = {
        let button = SendCodeBtn()
        button.setImage(UIImage(named: "closeImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "lookImage"), for: UIControl.State.selected)
        button.isHidden = true
        button.isSelected = false
        button.addTarget(self, action: #selector(lookPasswordButtonClick(isButton:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    private lazy var forgetPasswordBtn : SendCodeBtn = {
        let button = SendCodeBtn()
        button.setTitle("忘记密码？", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 153, g: 153, b: 153, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.isHidden = true
        button.addTarget(self, action: #selector(forgetPasswordButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var underlineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var codeBtn : SendCodeBtn = {
        let button = SendCodeBtn()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(codeFinishButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("获取验证码", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YMColor(r: 147, g: 216, b: 129, a: 1)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(loginIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("登录", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    
    lazy var line1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    lazy var line2Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    lazy var otherLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = "第三方账号登录"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var WeChatButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "weChatImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(weChatButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var AlipayButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AlipayImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(alipayButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var agreeLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = "登录/注册即表示你同意"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        return label
    }()
    private lazy var agreeButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
        button.setTitle("《辉辉服务协议》", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.addTarget(self, action: #selector(lookServerProtocolButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录/注册"
        self.view.backgroundColor = UIColor.white
        self.typeID = "1"
        self.view.addSubview(self.iphoneTitle)
        
        NotificationCenter.default.addObserver(self, selector: #selector(requestWeChatLoginSucceess(nofit:)), name: NSNotification.Name(rawValue:"weChatLoginSucceess"), object: nil)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"weChatLoginSucceess"), object:dic)
        self.view.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMNavBarHeight)
        self.view.addSubview(self.popButton)
        if  isIphoneX == false {
            self.iphoneTitle.frame = CGRect(x: 30, y:LBFMNavBarHeight+45, width: 35, height: 15)
            self.codeButton.frame = CGRect(x: LBFMScreenWidth-95, y: 35, width: 80, height: 20)
            self.popButton.frame = CGRect(x: 15, y: 35, width: 20, height: 20)
        }else{
            self.popButton.frame = CGRect(x: 15, y: 55, width: 20, height: 20)
            self.codeButton.frame = CGRect(x: LBFMScreenWidth-95, y: 55, width: 80, height: 20)
            self.iphoneTitle.frame = CGRect(x: 30, y: LBFMNavBarHeight+45, width: 35, height: 15)
        }
//          返回
        
        
//        验证码密码切换
        self.view.addSubview(self.codeButton)
       
//        输入手机号
        self.view.addSubview(self.iphoneField)
        self.iphoneField.frame = CGRect(x: 30, y: self.iphoneTitle.frame.maxY+5, width: LBFMScreenWidth-60, height: 30)
//        分割线
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 30, y: self.iphoneField.frame.maxY, width: LBFMScreenWidth-60, height: 1)
//        输入密码
        self.view.addSubview(self.passwordField)
        self.passwordField.frame = CGRect(x: 30, y: self.lineLabel.frame.maxY+25, width:LBFMScreenWidth - 120, height: 30)
//        查看密码
        self.view.addSubview(self.lookBtn)
        self.lookBtn.frame = CGRect(x: self.passwordField.frame.maxX+20, y: self.lineLabel.frame.maxY+25, width: 30, height: 30)
//        验证码
        self.view.addSubview(self.codeField)
        self.codeField.frame = CGRect(x: 30, y: self.lineLabel.frame.maxY+25, width: LBFMScreenWidth-160, height: 30)
//        获取验证码
        self.view.addSubview(self.codeBtn)
        self.codeBtn.frame = CGRect(x: self.codeField.frame.maxX+10, y:  self.lineLabel.frame.maxY+25, width: 90, height: 25)
//        分割线
        self.view.addSubview(self.underlineLabel)
        self.underlineLabel.frame = CGRect(x: 30, y: self.codeField.frame.maxY, width: LBFMScreenWidth-60, height: 1)
//        忘记密码
        self.view.addSubview(self.forgetPasswordBtn)
        self.forgetPasswordBtn.frame = CGRect(x: LBFMScreenWidth-80, y: self.underlineLabel.frame.maxY+15, width: 60, height: 15)
//        登录
        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x:30, y: self.underlineLabel.frame.maxY+45, width: LBFMScreenWidth-60, height: 50)
        //        协议
        self.view.addSubview(self.agreeLabel)
        self.agreeLabel.frame = CGRect(x:(LBFMScreenWidth-205)*0.5, y: self.finishLabel.frame.maxY+25, width: 120, height: 15)
        //        查看协议
        self.view.addSubview(self.agreeButton)
        self.agreeButton.frame = CGRect(x:self.agreeLabel.frame.maxX, y: self.finishLabel.frame.maxY+25, width: 90, height: 15)
        
        if WXApi.isWXAppInstalled() == true {
//        分割线
        self.view.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 40, y: LBFMScreenHeight-130, width: (LBFMScreenWidth-200)*0.5, height: 1)
//        第三方登录
        self.view.addSubview(self.otherLabel)
        self.otherLabel.frame = CGRect(x: self.line1Label.frame.maxX, y: LBFMScreenHeight-138, width: 120, height: 16)
//        分割线
        self.view.addSubview(self.line2Label)
        self.line2Label.frame = CGRect(x: self.otherLabel.frame.maxX, y: LBFMScreenHeight-130, width: (LBFMScreenWidth-200)*0.5, height: 1)
//        微信登录
        self.view.addSubview(self.WeChatButton)
        self.WeChatButton.frame = CGRect(x:(LBFMScreenWidth-30)*0.5, y: LBFMScreenHeight-90, width: 30, height: 30)
//        支付宝登录
//        self.view.addSubview(self.AlipayButton)
        self.AlipayButton.frame = CGRect(x:self.WeChatButton.frame.maxX+60, y: LBFMScreenHeight-90, width: 30, height: 30)
        }

    }
    deinit {
           NotificationCenter.default.removeObserver(self)
    }
//    微信登录
    @objc func requestWeChatLoginSucceess(nofit:NSNotification) {
        let weChatInfo = UserDefaults.WeChatLoginInfo.string(forKey: .openid) ?? ""
        let unionid = UserDefaults.WeChatLoginInfo.string(forKey: .unionid) ?? ""
        let nickname = UserDefaults.WeChatLoginInfo.string(forKey: .nickname) ?? ""
        let province = UserDefaults.WeChatLoginInfo.string(forKey: .province) ?? ""
        let city = UserDefaults.WeChatLoginInfo.string(forKey: .city) ?? ""
        let country = UserDefaults.WeChatLoginInfo.string(forKey: .country) ?? ""
        let headimgurl = UserDefaults.WeChatLoginInfo.string(forKey: .headimgurl) ?? ""
        
        YDUserLoginProvider.request(.setWeChatLoginPasddWord(openid:weChatInfo, unionid: unionid , nickname:nickname, province: province, city:city , country:country , headimgurl: headimgurl)){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                     print("----------------%@",json["data"]["wechatStatus"])
                    if json["data"]["wechatStatus"] == 1 {
                        self.typeID = "3"
                        self.requestWeChatLogin()
                    }else if json["data"]["wechatStatus"] == 2 {
                        UserDefaults.LoginInfo.set(value:json["data"]["phone"].description, forKey:.phone)
                        UserDefaults.LoginInfo.set(value:json["data"]["id"].description, forKey:.id)
                        UserDefaults.LoginInfo.set(value:json["data"]["status"].description, forKey:.status)
                        
                        self.token = json["data"]["token"].description as NSString
                        print("-------%@",UserDefaults.LoginInfo.string(forKey: .id))
                        if self.token.boolValue {
                            print("-------有token")
                            UserDefaults.LoginInfo.set(value:json["data"]["token"].description, forKey:.token)
                        }
                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshLoginMain"), object:nil)
                        self.dismiss(animated: true, completion: nil)
                        //                            新用户领取礼包登录成功通知
                        NotificationCenter.default.post(name: NSNotification.Name.init("YDNewUserGiftViewController"), object:nil)
                    }

                }
            }
        }
        
    }
//    绑定接口
    @objc func requestWeChatLogin(){
        if self.iphoneField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入手机号"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if isTelNumber(num: self.iphoneField.text!) == false {
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "手机号错误"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        if self.codeField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入验证码"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        let weChatInfo = UserDefaults.WeChatLoginInfo.string(forKey: .openid) ?? ""
          let unionid = UserDefaults.WeChatLoginInfo.string(forKey: .unionid) ?? ""
          let nickname = UserDefaults.WeChatLoginInfo.string(forKey: .nickname) ?? ""
          let province = UserDefaults.WeChatLoginInfo.string(forKey: .province) ?? ""
          let city = UserDefaults.WeChatLoginInfo.string(forKey: .city) ?? ""
          let country = UserDefaults.WeChatLoginInfo.string(forKey: .country) ?? ""
          let headimgurl = UserDefaults.WeChatLoginInfo.string(forKey: .headimgurl) ?? ""
        
        YDUserLoginProvider.request(.setBindingWeChatUserLogin(openid: weChatInfo, unionid: unionid, nickname: nickname , province: province , city: city , country: country , headimgurl: headimgurl , phone:self.iphoneField.text ?? "", phoneCode:self.codeField.text ?? "")){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                     print("登录-------%@",json)
                    
                    UserDefaults.LoginInfo.set(value:json["data"]["phone"].description, forKey:.phone)
                    UserDefaults.LoginInfo.set(value:json["data"]["id"].description, forKey:.id)
                    UserDefaults.LoginInfo.set(value:json["data"]["status"].description, forKey:.status)

                    self.token = json["data"]["token"].description as NSString
                    print("-------%@",UserDefaults.LoginInfo.string(forKey: .id))
                    if self.token.boolValue {
                        print("-------有token")
                        UserDefaults.LoginInfo.set(value:json["data"]["token"].description, forKey:.token)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name.init("refreshLoginMain"), object:nil)
                    self.dismiss(animated: true, completion: nil)
                    //                            新用户领取礼包登录成功通知
                    NotificationCenter.default.post(name: NSNotification.Name.init("YDNewUserGiftViewController"), object:nil)
                }
            }
        }
        
    }
//    返回
    @objc func backtrackButtonClick(){
        self.dismiss(animated: true, completion: nil)
    }
//  验证码登录
    @objc func codeBackButtonClick(){
        
        if typeID.isEqual(to:"1"){
            self.typeID = "2"
            self.codeButton.setTitle("验证码登录", for: UIControl.State.normal)
            self.passwordField.isHidden = false
            self.lookBtn.isHidden = false
            self.forgetPasswordBtn.isHidden = false
            self.codeField.isHidden = true
            self.codeBtn.isHidden = true
            self.codeField.text = ""
        }else if typeID.isEqual(to: "2"){
            self.typeID = "1"
            self.codeButton.setTitle("密码登录", for: UIControl.State.normal)
            self.passwordField.isHidden = true
            self.lookBtn.isHidden = true
            self.forgetPasswordBtn.isHidden = true
            self.codeField.isHidden = false
            self.codeBtn.isHidden = false
            self.passwordField.text = ""
        }
        self.finishLabel.backgroundColor = YMColor(r: 147, g: 216, b: 129, a: 1)
        self.finishLabel.isUserInteractionEnabled = false
    }
//    显示密码
    @objc func lookPasswordButtonClick(isButton:UIButton){
        if isButton.isSelected == true{
            isButton.isSelected = false
            self.passwordField.isSecureTextEntry = true

        }else{
            isButton.isSelected = true
            self.passwordField.isSecureTextEntry = false
        }
        
    }
//    获取验证码
    @objc func codeFinishButtonClick(){
        if self.iphoneField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入手机号"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        if isTelNumber(num: self.iphoneField.text!) == false {
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "手机号错误"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        YDUserLoginProvider.request(.getIphoneCode(phone: self.iphoneField.text! as NSString)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                    let json = JSON(data!)
                    print("-------%@",json)
                    if json["success"] == true{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "验证码发送成功"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                        self.codeBtn.timeFailBeginFrom(60)
                    }else{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = json["error"]["errorMessage"].description
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                    }
                }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.iphoneField.text?.count ?? 0 >= 2 && self.codeField.text?.count ?? 0 >= 2 || self.iphoneField.text?.count ?? 0 >= 2 && self.passwordField.text?.count ?? 0 >= 2{
            self.finishLabel.backgroundColor = YDLabelColor
            self.finishLabel.isUserInteractionEnabled = true
        }else{
            self.finishLabel.backgroundColor = YMColor(r: 147, g: 216, b: 129, a: 1)
            self.finishLabel.isUserInteractionEnabled = false
        }
        
        if self.iphoneField == textField {
            if string.count > 0 || self.iphoneField.text?.count ?? 0 > 1{
                self.iphoneTitle.isHidden = false
            }else{
                self.iphoneTitle.isHidden = true
            }
            
            let text = self.iphoneField.text!
            let len = text.count + string.count - range.length
            return len<=11
        }else{
            let text = self.codeField.text!
            let len = text.count + string.count - range.length
            return len<=6
        }
        

        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.iphoneField == textField {
            self.lineLabel.backgroundColor = YDLabelColor
            self.underlineLabel.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
            return true
        }else{
            self.underlineLabel.backgroundColor = YDLabelColor
            self.lineLabel.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
            return true
        }
    }

//    忘记密码
    @objc func forgetPasswordButtonClick(){
        let password = YDForgetPasswordViewController()
        if #available(iOS 13.0, *) {
            password.modalPresentationStyle = .fullScreen
        } else {
                          // Fallback on earlier versions
        }
        self.present(password, animated: true, completion: nil)
//        self.navigationController?.pushViewController(password, animated: true)
        
    }
//    登录
    @objc func loginIphoneButtonClick(){
        self.view.endEditing(true)
        if self.iphoneField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入手机号"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if isTelNumber(num: self.iphoneField.text!) == false {
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "手机号错误"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        if self.typeID.isEqual(to: "1"){
            if self.codeField.text!.count <= 0{
                //只显示文字
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                hud.label.text = "请输入验证码"
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1)
                return
            }
        YDUserLoginProvider.request(.getUsetLogin(
                phone: self.iphoneField.text! as NSString
                ,phoneCode:self.codeField.text! as NSString
            )) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "登录成功"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 2)
                    
                        UserDefaults.LoginInfo.set(value:json["data"]["phone"].description, forKey:.phone)
                        UserDefaults.LoginInfo.set(value:json["data"]["id"].description, forKey:.id)
                        UserDefaults.LoginInfo.set(value:json["data"]["status"].description, forKey:.status)
                    
                        self.token = json["data"]["token"].description as NSString
                        print("-------%@",UserDefaults.LoginInfo.string(forKey: .id))
                        if self.token.boolValue {
                            print("-------有token")
                            UserDefaults.LoginInfo.set(value:json["data"]["token"].description, forKey:.token)
                        }
                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshLoginMain"), object:nil)
                        self.dismiss(animated: true, completion: nil)
//                            新用户领取礼包登录成功通知
                        NotificationCenter.default.post(name: NSNotification.Name.init("YDNewUserGiftViewController"), object:nil)
                    }
                }else{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = json["error"]["errorMessage"].description
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                }
                }
            }
        }}else if self.typeID.isEqual(to: "2"){
            if self.passwordField.text!.count < 6{
                //只显示文字
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                hud.label.text = "密码最少六位"
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1)
                return
            }
            YDUserLoginProvider.request(.getUserPasswordLogin(password: self.passwordField.text!, phone: self.iphoneField.text!)) { result  in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    if data != nil{
                    let json = JSON(data!)
                    print("-------%@",json)
                    if json["success"] == true{
                        if json["data"].isEmpty != true{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = "登录成功"
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 2)
                        
                            UserDefaults.LoginInfo.set(value:json["data"]["phone"].description, forKey:.phone)
                            UserDefaults.LoginInfo.set(value:json["data"]["id"].description, forKey:.id)
                            UserDefaults.LoginInfo.set(value:"2", forKey:.status)
                        
                            self.token = json["data"]["token"].description as NSString
                            print("-------%@",UserDefaults.LoginInfo.string(forKey: .id))
                            if self.token.boolValue {
                                print("-------有token")
                                UserDefaults.LoginInfo.set(value:json["data"]["token"].description, forKey:.token)
                            }
                            NotificationCenter.default.post(name: NSNotification.Name.init("refreshLoginMain"), object:nil)

                            self.dismiss(animated: true, completion: nil)
                            
                            //                            新用户领取礼包登录成功通知
                            NotificationCenter.default.post(name: NSNotification.Name.init("YDNewUserGiftViewController"), object:nil)
                        }
                    }else{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = json["error"]["errorMessage"].description
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                    }
                    }
                }
            }
        }else if self.typeID.isEqual(to: "3"){
            if self.codeField.text!.count <= 0{
                //只显示文字
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                hud.label.text = "请输入验证码"
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1)
                return
            }
              let weChatInfo = UserDefaults.WeChatLoginInfo.string(forKey: .openid) ?? ""
              let unionid = UserDefaults.WeChatLoginInfo.string(forKey: .unionid) ?? ""
              let nickname = UserDefaults.WeChatLoginInfo.string(forKey: .nickname) ?? ""
              let province = UserDefaults.WeChatLoginInfo.string(forKey: .province) ?? ""
              let city = UserDefaults.WeChatLoginInfo.string(forKey: .city) ?? ""
              let country = UserDefaults.WeChatLoginInfo.string(forKey: .country) ?? ""
              let headimgurl = UserDefaults.WeChatLoginInfo.string(forKey: .headimgurl) ?? ""
            
            YDUserLoginProvider.request(.setBindingWeChatUserLogin(openid: weChatInfo, unionid: unionid, nickname: nickname , province: province , city: city , country: country , headimgurl: headimgurl , phone:self.iphoneField.text ?? "", phoneCode:self.codeField.text ?? "")){ result  in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    if data != nil{
                        let json = JSON(data!)
                         print("登录-------%@",json)
                        
                        UserDefaults.LoginInfo.set(value:json["data"]["phone"].description, forKey:.phone)
                        UserDefaults.LoginInfo.set(value:json["data"]["id"].description, forKey:.id)
                        UserDefaults.LoginInfo.set(value:json["data"]["status"].description, forKey:.status)

                        self.token = json["data"]["token"].description as NSString
                        print("-------%@",UserDefaults.LoginInfo.string(forKey: .id))
                        if self.token.boolValue {
                            print("-------有token")
                            UserDefaults.LoginInfo.set(value:json["data"]["token"].description, forKey:.token)
                        }
                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshLoginMain"), object:nil)
                        self.dismiss(animated: true, completion: nil)
                        //                            新用户领取礼包登录成功通知
                        NotificationCenter.default.post(name: NSNotification.Name.init("YDNewUserGiftViewController"), object:nil)
                    }
                }
            }
        }
    }
//    查看服务协议
    @objc func lookServerProtocolButtonClick(){
        let lookPrive = YDPrivacyLookUrlViewController()
        if #available(iOS 13.0, *) {
            lookPrive.modalPresentationStyle = .fullScreen
        } else {
                          // Fallback on earlier versions
        }
        self.present(lookPrive,animated:true,completion:nil)
    }
//    微信登录
    @objc func weChatButtonClick(){
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo" //获取用户信息
            req.state = String(Date().timeIntervalSince1970) //随机值即可，这里用时间戳
            WXApi.send(req)
    }
//    支付宝登录
    @objc func alipayButtonClick(){
        
    }
}
