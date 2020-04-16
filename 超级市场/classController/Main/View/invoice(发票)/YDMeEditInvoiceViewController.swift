//
//  YDMeEditInvoiceViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDMeEditInvoiceViewController: YDBasicViewController {
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitle("保存", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitle("取消", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.text = "单位发票抬头"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    
    
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    
    lazy var back2View:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    lazy var titleName : UILabel = {
        let name = UILabel()
        name.text = "名称"
        name.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        name.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return name
    }()
    private lazy var titleField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "姓名(必填)"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        //        textField.delegate = self
        // 自动更正功能
        //        textField.autocorrectionType = UITextAutocorrectionType.no
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        //        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.`default`
        // 键盘外观
        //        textField.keyboardAppearance = UIKeyboardAppearance.alert
        // 安全文本输入，（输入密码）
        //        textField.isSecureTextEntry = false
        return textField
    }()
    lazy var line1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "修改发票抬头"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        setAddUserInvoiceView()
    }
    //    保存
    @objc func rightBarButtonClick(){
        
    }
    //    取消
    @objc func leftBarButtonClick(){
        let alertController = UIAlertController(title: "确定要放弃本次编辑？",
                                                message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil);
        
        let okAction = UIAlertAction(title: "确定", style: .default,
                                     handler: {action in
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
    
    func setAddUserInvoiceView(){
        self.view.addSubview(backView)
        backView.frame = CGRect(x: 0, y:LBFMNavBarHeight + 10, width: LBFMScreenWidth, height: 60)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 20, width: 60, height: 20)
        
        self.backView.addSubview(self.line1)
        self.line1.frame = CGRect(x: 0, y: 59, width: LBFMScreenWidth, height: 1)
        
        self.view.addSubview(self.back2View)
        self.back2View.frame = CGRect(x: 0, y: self.backView.frame.maxY, width: LBFMScreenWidth, height: 260)
        
//        self.back2View.addSubview(self.nameLabel)
//        self.nameLabel.frame = CGRect(x: 15, y: 10, width: 30, height: 20)
//
//        self.back2View.addSubview(self.nameField)
//        self.nameField.frame = CGRect(x: 85, y: 10, width: LBFMScreenWidth-110, height: 20)
        
        self.back2View.addSubview(self.line1)
        self.line1.frame = CGRect(x: 15, y: 39, width: LBFMScreenWidth-30, height: 1)
    }
 
}
