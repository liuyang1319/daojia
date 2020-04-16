//
//  YDUpdateIphoneViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDUpdateIphoneViewController: YDBasicViewController {
    lazy var lineLabel4 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 242, g: 242, b: 242, a: 1)
        return label
    }()
    
    private lazy var iphoneField:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        return label
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
                textField.keyboardType = UIKeyboardType.phonePad
        // 键盘外观
        //        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
        //        textField.isSecureTextEntry = false
        return textField
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
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("验证手机", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "更改绑定手机"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.lineLabel4)
        self.lineLabel4.frame = CGRect(x: 0, y: LBFMNavBarHeight, width:LBFMScreenWidth, height: 10)
        
        self.view.addSubview(self.iphoneField)
        self.iphoneField.frame = CGRect(x: 30, y: LBFMNavBarHeight+60, width:LBFMScreenWidth-60, height: 20)
        if DYStringIsEmpty(value: UserDefaults.LoginInfo.string(forKey:.phone) as AnyObject?) != true{
            self.iphoneField.text = UserDefaults.LoginInfo.string(forKey:.phone)
        }
        
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 30, y: self.iphoneField.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)
        
        self.view.addSubview(self.codeField)
        self.codeField.frame = CGRect(x: 30, y: self.lineLabel.frame.maxY+35, width: LBFMScreenWidth-160, height: 35)
        
        self.view.addSubview(self.codeBtn)
        self.codeBtn.frame = CGRect(x: self.codeField.frame.maxX+10, y:  self.lineLabel.frame.maxY+35, width: 90, height: 25)
        
        self.view.addSubview(self.underlineLabel)
        self.underlineLabel.frame = CGRect(x: 30, y: self.codeField.frame.maxY, width: LBFMScreenWidth-60, height: 1)
        
        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x:30, y: self.underlineLabel.frame.maxY+45, width: LBFMScreenWidth-60, height: 50)
    }
// 获取验证码
    @objc func codeFinishButtonClick() {
//        if self.iphoneField.text!.count <= 0{
//            //只显示文字
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请输入手机号"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }
//        if isTelNumber(num: self.iphoneField.text!) == false {
//            //只显示文字
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "手机号错误"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }
        
        YDUserCenterProvider.request(.setUpdateUserCenterPhoneMessageInfo(token: UserDefaults.LoginInfo.string(forKey:.token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey:.phone)! as String) ){ result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("--------------%@",json)
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
//    验证手机号
    @objc func finishIphoneButtonClick(){
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
        if self.codeField.text!.count <= 0{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入验证码"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        YDUserCenterProvider.request(.setUpdateUserCenterPhoneVerifyInfo(token: UserDefaults.LoginInfo.string(forKey:.token)! as NSString, memberPhone: self.iphoneField.text! as NSString, phoneCode: self.codeField.text! as NSString) ){ result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if json["success"] == true{
                    let newPhone = YDUpdateNewphoneViewController()
                    self.navigationController?.pushViewController(newPhone, animated:true)
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

}
