//
//  YDSelectCityViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
protocol YDSelectCityViewControllerDelegate:NSObjectProtocol{
    func returnAddersregCodeValue(adders:String ,regCode:String)
}
class YDSelectCityViewController: YDBasicViewController {
    
    weak var delegate : YDSelectCityViewControllerDelegate?
    
    var province = String()
    var provinceRegCode = String()
    var namearray:[String] = []
    
    var city = String()
    var cityCode = String()
    var cityarray:[String] = []
    
    
    var area = String()
    var areaCode = String()
    var areaArray:[String] = []
    
    var selectProvinceModel:[YDSelectProvinceModel]?
    lazy var line3 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var provinceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "所在省:"
        return label
    }()
    private lazy var selectProvince : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    private lazy var provinceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "popImage"), for: UIControl.State.normal)
        return button
    }()
    
    private lazy var seleectProvinceButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectProvinceButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var line4 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    private lazy var CityLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "所在市:"
        return label
    }()
    private lazy var selectCity : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    
    private lazy var CityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "popImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var selectCityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectCityButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var line1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    
    private lazy var areaLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "所在区县:"
        return label
    }()
    private lazy var selectArea : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        label.textAlignment = .right
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
    
    lazy var line2 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("完 成", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "选择城市"
        
        
        self.view.addSubview(self.provinceLabel)
        self.provinceLabel.frame = CGRect(x: 15, y:LBFMNavBarHeight + 15, width: 80, height: 20)
        
        self.view.addSubview(self.selectProvince)
        self.selectProvince.frame = CGRect(x: self.provinceLabel.frame.maxX, y:LBFMNavBarHeight + 15, width: LBFMScreenWidth-140, height: 20)
        
        self.view.addSubview(self.provinceButton)
        self.provinceButton.frame = CGRect(x: LBFMScreenWidth-35, y:LBFMNavBarHeight + 10, width:30, height: 30)
        
        self.view.addSubview(self.line4)
        self.line4.frame = CGRect(x: 15, y: self.provinceLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        self.view.addSubview(self.seleectProvinceButton)
        self.seleectProvinceButton.frame = CGRect(x: self.provinceLabel.frame.maxX, y:LBFMNavBarHeight, width: LBFMScreenWidth-140, height: 50)
        
        
        self.view.addSubview(self.CityLabel)
        self.CityLabel.frame = CGRect(x: 15, y:self.line4.frame.maxY + 15, width: 80, height: 20)
        
        self.view.addSubview(self.selectCity)
        self.selectCity.frame =  CGRect(x: self.CityLabel.frame.maxX, y:self.line4.frame.maxY + 15, width: LBFMScreenWidth-140, height: 20)
        
        self.view.addSubview(self.CityButton)
        self.CityButton.frame = CGRect(x: LBFMScreenWidth-35, y:self.line4.frame.maxY + 10, width:30, height: 30)
        
        self.view.addSubview(self.selectCityButton)
        self.selectCityButton.frame = CGRect(x: self.CityLabel.frame.maxX, y:self.line4.frame.maxY, width: LBFMScreenWidth-140, height: 50)
        
        
        self.view.addSubview(self.line1)
        self.line1.frame = CGRect(x: 15, y: self.CityLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        

        self.view.addSubview(self.areaLabel)
        self.areaLabel.frame = CGRect(x: 15, y:self.line1.frame.maxY + 15, width: 80, height: 20)
        
        self.view.addSubview(self.selectArea)
        self.selectArea.frame =  CGRect(x: self.CityLabel.frame.maxX, y:self.line1.frame.maxY + 15, width: LBFMScreenWidth-140, height: 20)
        
        self.view.addSubview(self.areaButton)
        self.areaButton.frame = CGRect(x: LBFMScreenWidth-35, y:self.line1.frame.maxY + 10, width:30, height: 30)
        
        self.view.addSubview(self.selectAreaButton)
        self.selectAreaButton.frame = CGRect(x: self.CityLabel.frame.maxX, y:self.line1.frame.maxY, width: LBFMScreenWidth-140, height: 50)
        
        self.view.addSubview(self.line2)
        self.line2.frame = CGRect(x: 15, y: self.areaLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
//        self.view.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x: 20, y: self.line2.frame.maxY+150, width: LBFMScreenWidth-40, height: 40)
    }
    
//    完成
    @objc func finishIphoneButtonClick(){
        
//        if self.selectProvince.text?.isEmpty == true {
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请选择省份"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }else if self.selectCity.text?.isEmpty == true{
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请选择城市"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }else if self.selectArea.text?.isEmpty == true{
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请选择区县"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//            return
//        }
        
        delegate?.returnAddersregCodeValue(adders: String(format:"%@%@",self.city,self.area), regCode:String(format: "%@,%@,%@", self.provinceRegCode,self.cityCode,self.areaCode))
        
        self.navigationController?.popViewController(animated: true)

    }
    
//    所在省
    @objc func selectProvinceButtonClick(){
         self.namearray.removeAll()
        YDUserAddersProvider.request(.getCityAddersCode(level:"1", reg_code: "110")) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                for (index,value) in json["data"] {
                    self.namearray.append(value["regName"].string!)
                }
                
                let picker = QDatePicker { (date: String) in
                    self.province = date as String
                    
                    self.selectProvince.setValue(self.province, forKey: "text")
                    for (index,value) in json["data"] {
                        
                        if self.province == value["regName"].string!{
                            print("-------%@",value["regCode"])
                            self.provinceRegCode = String(reflecting: value["regCode"])
                             print("++++++++%@",self.provinceRegCode)
                        }
                        self.namearray.append(value["regName"].string!)
                    }
                    self.selectCity.text = ""
                    self.selectArea.text = ""
                    
                }
                    picker.themeColor = YDLabelColor
                    picker.pickerStyle = .singlePicker
                    picker.animationStyle = .styleDefault
                    picker.singlePickerDatas = self.namearray
                    picker.show()
            }
        }
    }
//     所在市
    @objc func selectCityButtonClick(){
        if DYStringIsEmpty(value: self.provinceRegCode as AnyObject) == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择省份"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        self.cityarray.removeAll()
        YDUserAddersProvider.request(.getCityAddersCode(level:"2", reg_code:self.provinceRegCode)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                for (index,value) in json["data"] {
                    self.cityarray.append(value["regName"].string!)
                }
                
                let picker = QDatePicker { (date: String) in
                    self.city = date as String
                    
                    self.selectCity.setValue(self.city, forKey: "text")
                    for (index,value) in json["data"] {
                        if self.city == value["regName"].string!{
                            print("-------%@",value["regCode"])
                            self.cityCode =  String(reflecting: value["regCode"])
                        }
                        self.cityarray.append(value["regName"].string ?? "")
                    }
                    
                    self.selectArea.text = ""
                }
                picker.themeColor = YDLabelColor
                picker.pickerStyle = .singlePicker
                picker.animationStyle = .styleDefault
                picker.singlePickerDatas = self.cityarray
                picker.show()
            }
        }
    }
//    所在区
    @objc func selectAreaButtonClick(){
        if DYStringIsEmpty(value: self.cityCode as AnyObject) == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择城市"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        self.areaArray.removeAll()
        YDUserAddersProvider.request(.getCityAddersCode(level:"3", reg_code:self.cityCode)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                
                let json = JSON(data!)
                print("-------%@",json)
                for (index,value) in json["data"] {
                    self.areaArray.append(value["regName"].string!)
                }
                
                let picker = QDatePicker { (date: String) in
                    self.area = date as String
                    
                    self.selectArea.setValue(self.area, forKey: "text")
                    for (index,value) in json["data"] {
                        if self.area == value["regName"].string!{
                            print("-------%@",value["regCode"])
                            self.areaCode =  String(reflecting: value["regCode"])
                            
                            self.finishIphoneButtonClick()
                            
                        }
                        self.areaArray.append(value["regName"].string!)
                    }
                    
                    
                }
                picker.themeColor = YDLabelColor
                picker.pickerStyle = .singlePicker
                picker.animationStyle = .styleDefault
                picker.singlePickerDatas = self.areaArray
                picker.show()
            }
        }
    }
    
}
