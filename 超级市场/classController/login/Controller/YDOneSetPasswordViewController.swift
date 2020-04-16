//
//  YDOneSetPasswordViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDOneSetPasswordViewController: YDBasicViewController {
    
    lazy var line1Label : UILabel = {
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
//        button.isHidden = true
        button.isSelected = false
        button.addTarget(self, action: #selector(lookPasswordButtonClick(lookButton:)), for: UIControl.Event.touchUpInside)
        return button
        
    }()
    
    
    lazy var underlineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(loginIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("完成", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置密码"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 10)
        self.view.addSubview(self.passworField)
        self.passworField.frame = CGRect(x: 30, y: self.line1Label.frame.maxY+15, width:LBFMScreenWidth - 120, height: 30)
        
        self.view.addSubview(self.editBtn)
        self.editBtn.frame = CGRect(x: self.passworField.frame.maxX+20, y: self.line1Label.frame.maxY+20, width: 30, height: 30)
        
        
        self.view.addSubview(self.underlineLabel)
        self.underlineLabel.frame = CGRect(x: 30, y: self.passworField.frame.maxY+5, width: LBFMScreenWidth-60, height: 1)
        
        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x: 30, y: self.underlineLabel.frame.maxY+40, width: LBFMScreenWidth-60, height: 50)
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
//    提交密码
    @objc func loginIphoneButtonClick(){
        if self.passworField.text!.count < 6{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "密码最少六位"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        YDUserLoginProvider.request(.setOneUserPassword(password: self.passworField.text!, token: UserDefaults.LoginInfo.string(forKey: .token) ?? "", memberPhone: UserDefaults.LoginInfo.string(forKey: .phone) ?? "")) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if json["success"] == true{
                        UserDefaults.LoginInfo.set(value:"2", forKey:.status)
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "密码设置成功"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                        self.navigationController?.popViewController(animated: true)
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
