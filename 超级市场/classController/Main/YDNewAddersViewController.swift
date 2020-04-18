//
//  YDNewAddersViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDNewAddersViewController: YDBasicViewController,YDSearchAddersViewControllerDelegate,YDSelectCityViewControllerDelegate,UITextFieldDelegate {
 
    var type = String() //1.公司 2.家  3.学校
    var isDefault = String() //0 非默认  1.默认
    var sexType = String() //1.男 2.女
    var addressCode = String()//code码
    var cityStr = String() //城市
//    经纬度
    var longitude = String()
    var latitude = String()
    var code = String()
    var linkLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    lazy var takeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "收货人"
        return label
    }()
    private lazy var nameField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        // 背景颜色
        textField.backgroundColor = UIColor.white
        // 提示语
        textField.placeholder = "请输入姓名"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.`default`
        
        return textField
    }()
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    private lazy var selectMadam : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectMrButtonClick(isSelectMr:)), for: UIControl.Event.touchUpInside)
        button.isSelected = false
        button.setImage(UIImage(named: "onSelectImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "isSelectImage"), for: UIControl.State.selected)
        return button
    }()
    private lazy var MadamLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "先生"
        return label
    }()
    private lazy var selectMan : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectMadamButtonClick(isSelectMadam:)), for: UIControl.Event.touchUpInside)
        button.isSelected = false
        button.setImage(UIImage(named: "onSelectImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "isSelectImage"), for: UIControl.State.selected)
        return button
    }()
    private lazy var ManLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "女士"
        return label
    }()
    lazy var line2 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    private lazy var iphoneLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "手机号："
        return label
    }()
    
    private lazy var iphoneField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        // 背景颜色
        textField.backgroundColor = UIColor.white
        // 提示语UserDefaults.LoginInfo.string(forKey: .phone)
        textField.text = ""
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.numberPad
        
        return textField
    }()
    lazy var line3 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var cityLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "所在城市:"
        return label
    }()
    private lazy var selectCity : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    private lazy var cityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "popImage"), for: UIControl.State.normal)
        return button
    }()
    
    private lazy var seleectCityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectCityButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var line4 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var areaLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "所在区域:"
        return label
    }()
    private lazy var selectArea : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        label.numberOfLines = 2
        return label
    }()

    private lazy var areaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "popImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var selectAreaButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectAreaButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var line5 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    private lazy var numberLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "门牌号："
        return label
    }()
    
    private lazy var numberField:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        // 提示语
        textField.placeholder = "例：6号楼301室"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        // 完成按钮样式
        textField.returnKeyType = UIReturnKeyType.done
        // 清除按钮显示状态
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // 键盘样式
        textField.keyboardType = UIKeyboardType.`default`
        
        return textField
    }()
    lazy var line6 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "地址类型："
        return label
    }()
    private lazy var companyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitle("公司", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "type_image_n"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "type_image"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selectcompanyButtonClick(company:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitle("家", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "type_image_n"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "type_image"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selecthomeButtonClick(home:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var schoolButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setBackgroundImage(UIImage(named: "type_image_n"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "type_image"), for: UIControl.State.selected)
        button.setTitle("学校", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectschoolButtonClick(school:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var line7 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var defaultLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "设置默认地址"
        return label
    }()
    
    private lazy var onSelect : UISwitch = {
        let onswitch = UISwitch()
        onswitch.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        return onswitch
    }()
    
    private lazy var hintLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = "每次购物时会先优先定位至该地址，方便您轻松购物"
        return label
    }()
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("保存", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建收货地址"
        
        self.type = ""
        self.isDefault = "0"
        self.sexType = ""
        
        self.view.backgroundColor = UIColor.white
        
        self.companyButton.isSelected = false
        self.homeButton.isSelected = false
        self.schoolButton.isSelected = false
        self.view.addSubview(self.linkLabel)
        self.linkLabel.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 10)
        //输入姓名
        self.view.addSubview(self.takeLabel)
        self.takeLabel.frame = CGRect(x: 15, y: self.linkLabel.frame.maxY+15, width:80, height: 20)
        
        self.view.addSubview(self.nameField)
        self.nameField.frame = CGRect(x: self.takeLabel.frame.maxX, y: self.linkLabel.frame.maxY+15, width: 200, height: 20)
        
        self.view.addSubview(self.line)
        self.line.frame = CGRect(x: self.takeLabel.frame.maxX, y: self.nameField.frame.maxY+15, width: LBFMScreenWidth-90, height: 1)
//        选择性别
        self.view.addSubview(self.selectMan)
        self.selectMan.frame = CGRect(x: self.takeLabel.frame.maxX, y: self.line.frame.maxY+15, width: 20, height: 20)
        
        self.view.addSubview(self.ManLabel)
        self.ManLabel.frame = CGRect(x: self.selectMan.frame.maxX+5, y: self.line.frame.maxY+15, width: 30, height: 20)
        
        self.view.addSubview(self.selectMadam)
        self.selectMadam.frame = CGRect(x: self.ManLabel.frame.maxX+50, y: self.line.frame.maxY+15, width: 20, height: 20)
        
        self.view.addSubview(self.MadamLabel)
        self.MadamLabel.frame = CGRect(x: self.selectMadam.frame.maxX+5, y: self.line.frame.maxY+15, width: 30, height: 20)
        
    
        self.view.addSubview(self.line2)
        self.line2.frame = CGRect(x: self.takeLabel.frame.maxX, y: self.ManLabel.frame.maxY+15, width: LBFMScreenWidth-90, height: 1)
        
//        手机号
        self.view.addSubview(self.iphoneLabel)
        self.iphoneLabel.frame = CGRect(x: 15, y: self.line2.frame.maxY+15, width: 80, height: 20)
        
        self.view.addSubview(self.iphoneField)
        self.iphoneField.frame = CGRect(x: self.iphoneLabel.frame.maxX, y: self.line2.frame.maxY+15, width: 200, height: 20)
        
        self.view.addSubview(self.line3)
        self.line3.frame = CGRect(x: 15, y:self.iphoneField.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
//        所在城市
//        self.view.addSubview(self.cityLabel)
        self.cityLabel.frame = CGRect(x: 15, y: self.line3.frame.maxY+15, width: 80, height: 20)
        
        self.view.addSubview(self.selectCity)
        self.selectCity.frame = CGRect(x: self.cityLabel.frame.maxX, y: self.line3.frame.maxY+15, width: LBFMScreenWidth-140, height: 20)
//        self.view.addSubview(self.seleectCityButton)
        
        self.seleectCityButton.frame = CGRect(x: self.cityLabel.frame.maxX, y: self.line3.frame.maxY, width: LBFMScreenWidth-140, height: 50)

        
//        self.view.addSubview(self.cityButton)
        self.cityButton.frame = CGRect(x: LBFMScreenWidth-45, y: self.line3.frame.maxY+10, width:30, height: 30)
        
//        self.view.addSubview(self.line4)
        self.line4.frame = CGRect(x: 15, y: self.cityLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
//        所在区域
        self.view.addSubview(self.areaLabel)
        self.areaLabel.frame = CGRect(x: 15, y: self.line3.frame.maxY+15, width: 80, height: 20)
        
        self.view.addSubview(self.selectArea)
        self.selectArea.frame = CGRect(x: self.areaLabel.frame.maxX, y: self.line3.frame.maxY+5, width: LBFMScreenWidth-130, height: 40)
        
        
        self.view.addSubview(self.areaButton)
        self.areaButton.frame = CGRect(x: LBFMScreenWidth-35, y: self.line3.frame.maxY+10, width: 20, height: 30)
        
        self.view.addSubview(self.selectAreaButton)
        self.selectAreaButton.frame = CGRect(x: self.areaLabel.frame.maxX, y: self.line3.frame.maxY, width: LBFMScreenWidth-110, height: 50)
        
        
        self.view.addSubview(self.line5)
        self.line5.frame = CGRect(x: 15, y: self.areaLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
//        门牌号
        self.view.addSubview(self.numberLabel)
        self.numberLabel.frame = CGRect(x:15, y: self.line5.frame.maxY+15, width: 80, height: 20)
        self.view.addSubview(self.numberField)
        self.numberField.frame = CGRect(x: self.numberLabel.frame.maxX, y: self.line5.frame.maxY+15, width: LBFMScreenWidth-150, height: 20)
        self.view.addSubview(self.line6)
        self.line6.frame = CGRect(x: 15, y: self.numberField.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
//        地址类型
        self.view.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: self.line6.frame.maxY+15, width: 80, height: 20)
        self.view.addSubview(self.companyButton)
        self.companyButton.frame = CGRect(x: self.titleLabel.frame.maxX, y: self.line6.frame.maxY+15, width: 50, height: 20)
        self.view.addSubview(self.homeButton)
        self.homeButton.frame = CGRect(x: self.companyButton.frame.maxX+15, y: self.line6.frame.maxY+15, width: 50, height: 20)
        self.view.addSubview(self.schoolButton)
        self.schoolButton.frame = CGRect(x: self.homeButton.frame.maxX+15, y: self.line6.frame.maxY+15, width: 50, height: 20)
        self.view.addSubview(self.line7)
        self.line7.frame = CGRect(x: 15, y: self.titleLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
//        设置默认地址
        
        self.view.addSubview(self.defaultLabel)
        self.defaultLabel.frame = CGRect(x: 15, y: self.line7.frame.maxY+15, width: 100, height: 20)
        self.view.addSubview(self.onSelect)
        self.onSelect.frame = CGRect(x: LBFMScreenWidth-60, y: self.line7.frame.maxY+10, width: 35, height: 25)
        self.view.addSubview(self.hintLabel)
        self.hintLabel.frame = CGRect(x: 15, y:self.defaultLabel.frame.maxY+3, width:LBFMScreenWidth-30, height: 15)
//        保存
        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x: 15, y: self.hintLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 40)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameField.resignFirstResponder()
        self.iphoneField.resignFirstResponder()
        self.numberField.resignFirstResponder()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if self.iphoneField == textField {
                let text = self.iphoneField.text!
                let len = text.count + string.count - range.length
                return len<=11
            }else if self.nameField == textField{
                if isLetterWithChinese(string) == true || string == ""{
                    let text = self.nameField.text!
                    let len = text.count + string.count - range.length
                    return len<=6
                }else{
                    return false
                }
            }else{
                if stringContainsEmoji(input: string) != true || string == ""{
                    let text = self.numberField.text!
                    let len = text.count + string.count - range.length
                    return len<=50
                }else{
                    return false
                }
            }
    }
//    先生
    @objc func selectMrButtonClick(isSelectMr:UIButton){
            self.sexType = "1"
            self.selectMadam.isSelected = true
            self.selectMan.isSelected = false
    }
//    女士
    @objc func selectMadamButtonClick(isSelectMadam:UIButton){
        self.sexType = "2"
        self.selectMadam.isSelected = false
        self.selectMan.isSelected = true
    }
//    选择城市
    @objc func selectCityButtonClick(){

        let cityVC = YDSelectCityViewController()
        cityVC.delegate = self
        self.navigationController?.pushViewController(cityVC, animated: true)
    }
    func returnAddersregCodeValue(adders: String, regCode: String) {
        self.selectCity.text = adders
        self.addressCode = regCode
        print("-----------%@",regCode)
    }
    
//    选择区域
    @objc func selectAreaButtonClick(){
        let area = YDSearchAddersViewController()
        area.delegate = self
        self.navigationController?.pushViewController(area, animated: true)
    }
//    选择区域
    func returnAddersValue(city:String,adders: String, longitude: CGFloat, latitude: CGFloat, code: String) {
        
        self.longitude = String(describing: longitude)
        self.latitude = String(describing: latitude)
        self.code = code
        self.cityStr = city
        print("-------------%@",self.longitude)
        self.selectArea.text = adders
    }
    
//    公司
    @objc func selectcompanyButtonClick(company:UIButton){
        if company.isSelected == true{
            company.isSelected = false
            self.type = ""
            company.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        }else{
            self.homeButton.isSelected = false
            self.schoolButton.isSelected = false
            company.isSelected = true
            self.type = "1"
            company.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.selected)
        }
      
    }
//    家
    @objc func selecthomeButtonClick(home:UIButton){
        if home.isSelected == true{
            home.isSelected = false
            self.type = ""
            home.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        }else{
            self.companyButton.isSelected = false
            self.schoolButton.isSelected = false
            home.isSelected = true
            self.type = "2"
            home.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.selected)
        }
    }
//    学校
    @objc func selectschoolButtonClick(school:UIButton){
        if school.isSelected == true{
            school.isSelected = false
            self.type = ""
            school.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        }else{
            self.companyButton.isSelected = false
            self.homeButton.isSelected = false
            school.isSelected = true
            self.type = "3"
            school.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.selected)
        }
    }
    
    @objc func switchDidChange(_ sender: UISwitch){
        //打印当前值
        print(sender.isOn)
        if sender.isOn == true {
            self.isDefault = "1"
        }else if sender.isOn == false{
            self.isDefault = "0"
        }
    }
//    保存
    @objc func finishIphoneButtonClick(){
        if self.nameField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入姓名"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        if self.sexType.isEmpty == true{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择性别"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
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
//        if self.selectCity.text!.count <= 0{
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请选择城市"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }
        if self.selectArea.text!.count <= 0{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择区域"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        if self.numberField.text!.count <= 0{
            //只显示文字
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入街道门牌号"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
//        let nameDate:Data = self.nameField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
//        let nameStr:String = String.init(data:nameDate, encoding:String.Encoding.utf8) ?? ""
//
//        let numberDate:Data = self.numberField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
//        let numberStr:String = String.init(data:numberDate, encoding:String.Encoding.utf8) ?? ""
//
        YDUserAddersProvider.request(.setAddNewAdderssIfo(name:self.nameField.text ?? "", type: self.type, isDefault: self.isDefault, addressRegion: self.cityStr, memberId: UserDefaults.LoginInfo.string(forKey: .id)! as String, sex:self.sexType, phone: self.iphoneField.text! as String, doorNumber: self.numberField.text ?? "", addressCode:self.code, longitude: self.longitude, latitude: self.latitude, street: self.selectArea.text! as String, token: UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
//                    let userDefault = UserDefaults.standard
//                    let dictionary = ["addressPhone":self.iphoneField.text ?? "","sex":self.sexType ?? "","name":self.nameField.text ?? "","type":self.type ?? "","addressRegion":self.selectCity.text ?? "","street":model.street ?? "","addressCode":self.addressCode ?? "","addressId":model.id ?? ""] as [String : Any]
//                    userDefault.set(dictionary, forKey: "AddersDictionary")
                    
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "地址添加成功"
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
