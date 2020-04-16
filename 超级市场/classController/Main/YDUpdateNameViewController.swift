//
//  YDUpdateNameViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD

class YDUpdateNameViewController: YDBasicViewController ,UITextFieldDelegate{
    
    
    private lazy var nameField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        // 边框样式
//        textField.borderStyle = UITextField.BorderStyle.roundedRect
//        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "请输入昵称"
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
//        textField.keyboardType = UIKeyboardType.emailAddress
        // 键盘外观
//        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
//        textField.isSecureTextEntry = false
        return textField
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = NSTextAlignment.left
        label.text = "用户昵称规范：可以使用中文、大写英文、数字、下划线及其组合"
        return label
    }()
    
    
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishSaveButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("保存", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.title = "修改昵称"
        self.view.addSubview(self.nameField)
        self.nameField.frame = CGRect(x: 15, y: LBFMNavBarHeight+10, width: LBFMScreenWidth-30, height: 45)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: self.nameField.frame.maxY+15, width: LBFMScreenWidth-30, height: 35)

        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x: 15, y: self.nameField.frame.maxY+85, width: LBFMScreenWidth-30, height: 35)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if isLetterWithDigital(string) == true{
            let text = textField.text ?? ""
            let len = text.count + string.count - range.length
            return len<=50
        }else{
            return false
        }
      
    }
    @objc func finishSaveButtonClick() {
  
        if self.nameField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入昵称"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        let nameDate:Data = self.nameField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
        let nameStr:String = String.init(data:nameDate, encoding:String.Encoding.utf8) ?? ""
        YDUserCenterProvider.request(.setUpdateUserCenterNameInfo(token: UserDefaults.LoginInfo.string(forKey: .token)! as NSString, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as NSString, name: nameStr)){ result  in

            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "修改成功"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    NotificationCenter.default.post(name: NSNotification.Name(YDUserUpdateName), object: self, userInfo: ["name":self.nameField.text])
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
