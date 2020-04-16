//
//  YDForgetPasswordViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDForgetPasswordViewController: YDBasicViewController {
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
    lazy var line1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
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
    lazy var line2Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()

    private lazy var passworField:UITextField = {
            let textField = UITextField()
            // 背景颜色
            textField.backgroundColor = UIColor.white
            // 边框样式
            //        textField.borderStyle = UITextField.BorderStyle.roundedRect
            //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
            // 提示语
            textField.placeholder = "请输入密码"
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
            textField.keyboardType = UIKeyboardType.`default`
            // 键盘外观
            //        textField.keyboardAppearance = UIKeyboardAppearance.alert
            // 安全文本输入，（输入密码）
            textField.isSecureTextEntry = true
            return textField
        }()
    
    private lazy var editBtn : SendCodeBtn = {
        let button = SendCodeBtn()
        button.setImage(UIImage(named: "closeImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "lookImage"), for: UIControl.State.selected)
        button.isHidden = false
        button.isSelected = false
        button.addTarget(self, action: #selector(lookPasswordButtonClick(lookButton:)), for: UIControl.Event.touchUpInside)
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
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(loginIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("提交", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMNavBarHeight)
        //          返回
        self.view.addSubview(self.popButton)
        self.popButton.frame = CGRect(x: 15, y: 35, width: 20, height: 20)
        
        self.view.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 10)
        
        self.view.addSubview(self.iphoneField)
        self.iphoneField.frame = CGRect(x: 30, y: self.line1Label.frame.maxY+50, width: LBFMScreenWidth-60, height: 30)
        
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 30, y: self.iphoneField.frame.maxY+5, width: LBFMScreenWidth-60, height: 1)
        
        
        self.view.addSubview(self.codeField)
        self.codeField.frame = CGRect(x: 30, y: self.lineLabel.frame.maxY+20, width: LBFMScreenWidth-160, height: 30)
        
        self.view.addSubview(self.codeBtn)
        self.codeBtn.frame = CGRect(x: self.codeField.frame.maxX+10, y:  self.lineLabel.frame.maxY+20, width: 90, height: 25)
        
        self.view.addSubview(self.line2Label)
        self.line2Label.frame = CGRect(x: 30, y: self.codeField.frame.maxY+5, width: LBFMScreenWidth-60, height: 1)
        
        self.view.addSubview(self.passworField)
        self.passworField.frame = CGRect(x: 30, y: self.line2Label.frame.maxY+15, width:LBFMScreenWidth - 120, height: 30)
        
        self.view.addSubview(self.editBtn)
        self.editBtn.frame = CGRect(x: self.passworField.frame.maxX+20, y: self.line2Label.frame.maxY+20, width: 30, height: 30)
        
        
        self.view.addSubview(self.underlineLabel)
        self.underlineLabel.frame = CGRect(x: 30, y: self.passworField.frame.maxY+5, width: LBFMScreenWidth-60, height: 1)
        
        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x: 30, y: self.underlineLabel.frame.maxY+40, width: LBFMScreenWidth-60, height: 50)
        
    }
    //    返回
    @objc func backtrackButtonClick(){
        self.dismiss(animated: true, completion: nil)
    }
//  明文密码
    @objc func lookPasswordButtonClick(lookButton:UIButton){
        if lookButton.isSelected == true{
            lookButton.isSelected = false
            self.passworField.isSecureTextEntry = true
            
        }else{
            lookButton.isSelected = true
            self.passworField.isSecureTextEntry = false
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
        YDUserLoginProvider.request(.getUserIphoneForgetPasswordCode(phone: self.iphoneField.text! as NSString)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
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
//    提交
    
    @objc func loginIphoneButtonClick(){
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
        if self.passworField.text!.count < 6{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "密码最少六位"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        
        YDUserLoginProvider.request(.setUserForgetPassword(phone: self.iphoneField.text!, phoneCode: self.codeField.text!, password: self.passworField.text!)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "密码设置成功"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                        self.dismiss(animated: true, completion: nil)
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

