//
//  YDRecruitInfoHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDRecruitInfoHeaderViewDelegate:NSObjectProtocol {
    //    提交
    func selectSubmitButtonClickHeaderView(name:String,iphone:String,city:String)
}
class YDRecruitInfoHeaderView: UITableViewHeaderFooterView {
    weak var delegate : YDRecruitInfoHeaderViewDelegate?
    var nameString = String()
    var iphoneString = String()
    var cityString = String()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    var titleLabel :UILabel = {
        let label = UILabel()
        label.text = "配送员"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 232, g: 232, b: 232, a: 1)
        return label
    }()

    var lineLabel1:UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    
    var describeLabel :UILabel = {
        let label = UILabel()
        label.text = "职位描述"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var dutyLabel :UILabel = {
        let label = UILabel()
        label.text = "岗位职责："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    
    var dutyContent :UILabel = {
        let label = UILabel()
        label.text = "1、根据用户下单地址，保证客户订单安全，及时准确送到客户手中。\n2、复核订单数量，保证配送货物的准确性。\n3、保障配送过程中客户安全的卫生、安全、新鲜度等。\n4、保证骑行时遵守交通规则，务必保障人身安全。\n5、协助门店进行门店的理货、运营、加工等工作。 "
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var requireLabel :UILabel = {
        let label = UILabel()
        label.text = "任职要求："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()

    var requireContent :UILabel = {
        let label = UILabel()
        label.text = "1、18-40岁，高中及以上学历。\n2、工作经验：不限，有配送经验优先考虑。\n3、技能要求：车子的骑行技能，良好的方向感，会使用智能手机。\n4、能力要求：良好的客户服务意识和语言沟通能力乐观积极，阳光，能吃苦耐劳，不怕脏不怕累，有上进心有责任心，做事积极，有比较强的适应能力。 "
        label.numberOfLines = 0
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var paymentLabel :UILabel = {
        let label = UILabel()
        label.text = "薪资待遇："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    var paymentContent :UILabel = {
        let label = UILabel()
        label.text = "六险一金、年底双薪、期权"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    
    var lineLabel2:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    var lineLabel3:UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    
    var messageLabel :UILabel = {
        let label = UILabel()
        label.text = "个人信息"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    
    var nameLabel :UILabel = {
        let label = UILabel()
        label.text = "姓名："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var nameField:UITextField = {
        let textField = UITextField()
        // 背景颜色
//        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "请输入姓名"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.delegate = self
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
        //        textField.isSecureTextEntry = false
        return textField
    }()
    var lineLabel4:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    var iphoneLabel :UILabel = {
        let label = UILabel()
        label.text = "手机号码："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()

    private lazy var iphoneField:UITextField = {
        let textField = UITextField()
        // 背景颜色
//        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "我们联系您的方式"
        textField.delegate = self
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
    var lineLabel5:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    var cityLabel :UILabel = {
        let label = UILabel()
        label.text = "期望工作城市："
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var cityField:UITextField = {
        let textField = UITextField()
        // 背景颜色
//        textField.backgroundColor = UIColor.white
        // 边框样式
        //        textField.borderStyle = UITextField.BorderStyle.roundedRect
        //        textField.textColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 提示语
        textField.placeholder = "工作城市"
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
        //        textField.isSecureTextEntry = false
        return textField
    }()
    var lineLabel6:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    var mailLabel :UILabel = {
        let label = UILabel()
        label.text = "简历可投递至hr@yundazx.com"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    
    var copyrightLabel :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "©️2019 yundazaixian.com版权所有"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    
    
    var submitBtn : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("提交", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        button.backgroundColor = YMColor(r: 77, g: 195, b: 45, a: 1)
        button.addTarget(self, action: #selector(selectSubmitButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 850)
     
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 15, width: 45, height: 20)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY+15, width: LBFMScreenWidth, height: 10)
        
        self.backView.addSubview(self.lineLabel1)
        self.lineLabel1.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+15, width: 5, height: 15)
        
        self.backView.addSubview(self.describeLabel)
        self.describeLabel.frame = CGRect(x: self.lineLabel1.frame.maxX+10, y: self.lineLabel.frame.maxY+12, width: 80, height: 20)
        
        self.backView.addSubview(self.dutyLabel)
        self.dutyLabel.frame = CGRect(x: 15, y: self.describeLabel.frame.maxY+10, width: 100, height: 25)
        
        
        self.backView.addSubview(self.dutyContent)
        self.dutyContent.frame = CGRect(x: 15, y: self.dutyLabel.frame.maxY+5, width: LBFMScreenWidth-30, height: 135)
        
        self.backView.addSubview(self.requireLabel)
        self.requireLabel.frame = CGRect(x: 15, y: self.dutyContent.frame.maxY+15, width: 100, height: 25)
        
        self.backView.addSubview(self.requireContent)
        self.requireContent.frame = CGRect(x: 15, y: self.requireLabel.frame.maxY, width: LBFMScreenWidth-30, height: 160)
        
        self.backView.addSubview(self.paymentLabel)
        self.paymentLabel.frame = CGRect(x: 15, y: self.requireContent.frame.maxY+5, width: 85, height: 25)
        
        self.addSubview(self.paymentContent)
        self.paymentContent.frame = CGRect(x: self.paymentLabel.frame.maxX, y: self.requireContent.frame.maxY+5, width: 200, height: 25)
        
        
        self.backView.addSubview(self.lineLabel2)
        self.lineLabel2.frame = CGRect(x: 0, y: self.paymentLabel.frame.maxY+5, width: LBFMScreenWidth, height: 10)
        
        
        self.backView.addSubview(self.lineLabel3)
        self.lineLabel3.frame = CGRect(x: 15, y: self.lineLabel2.frame.maxY+8, width: 4, height: 16)
        
        self.backView.addSubview(self.messageLabel)
        self.messageLabel.frame = CGRect(x: self.lineLabel3.frame.maxX+10, y: self.lineLabel2.frame.maxY+6, width: 60, height: 20)
        
        
        self.backView.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 15, y: self.messageLabel.frame.maxY+15, width: 45, height: 20)
        
        self.backView.addSubview(self.nameField)
        self.nameField.frame = CGRect(x: self.nameLabel.frame.maxX, y: self.messageLabel.frame.maxY+15, width: 230, height: 20)
        
        self.backView.addSubview(self.lineLabel4)
        self.lineLabel4.frame = CGRect(x: 15, y: self.nameField.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        
        self.backView.addSubview(self.iphoneLabel)
        self.iphoneLabel.frame = CGRect(x: 15, y: self.lineLabel4.frame.maxY+15, width: 77, height: 20)
        
        self.backView.addSubview(self.iphoneField)
        self.iphoneField.frame = CGRect(x: self.iphoneLabel.frame.maxX, y: self.lineLabel4.frame.maxY+15, width: 230, height: 20)
        
        self.backView.addSubview(self.lineLabel5)
        self.lineLabel5.frame = CGRect(x: 15, y: self.iphoneLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        
        self.backView.addSubview(self.cityLabel)
        self.cityLabel.frame = CGRect(x: 15, y: self.lineLabel5.frame.maxY+15, width: 100, height: 20)
        
        self.backView.addSubview(self.cityField)
        self.cityField.frame = CGRect(x: self.cityLabel.frame.maxX, y: self.lineLabel5.frame.maxY+15, width: 230, height: 20)
        
        self.backView.addSubview(self.lineLabel6)
        self.lineLabel6.frame = CGRect(x: 15, y: self.cityLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        
        self.backView.addSubview(self.mailLabel)
        self.mailLabel.frame = CGRect(x: 0, y: self.lineLabel6.frame.maxY+30, width: LBFMScreenWidth, height: 25)
        
        
        self.backView.addSubview(self.copyrightLabel)
        self.copyrightLabel.frame = CGRect(x: 0, y: self.mailLabel.frame.maxY+5, width: LBFMScreenWidth, height: 20)
        
        
        self.backView.addSubview(self.submitBtn)
        self.submitBtn.frame = CGRect(x: 0, y: self.copyrightLabel.frame.maxY+30, width: LBFMScreenWidth, height: 45)
        

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if stringContainsEmoji(input: string) == true {
            return false
        }
        if self.iphoneField == textField {
            let text = self.iphoneField.text!
            let len = text.count + string.count - range.length
            return len<=11
        }else{
            return true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    提交
    @objc func selectSubmitButtonClick(){
        delegate?.selectSubmitButtonClickHeaderView(name: self.nameString,iphone:self.iphoneString,city: self.cityString)
    }
}
extension YDRecruitInfoHeaderView :UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameField{
            self.nameString = textField.text ?? ""
        }else if textField == self.iphoneField{
             self.iphoneString = textField.text ?? ""
        }else if textField == self.cityField{
            self.cityString = textField.text ?? ""
        }
    }
}
