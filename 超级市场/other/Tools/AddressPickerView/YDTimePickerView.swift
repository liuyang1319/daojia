//
//  YDTimePickerView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDTimePickerView: UIView {

    //typedef
    typealias HanSureBtnBlock=(_ dataArr:[String])->Void
    //声明闭包
    var hanSureBtnBlock:HanSureBtnBlock?
    var array:[Any] = []
    var pickerView: UIPickerView!
    var titleArray:[String] = []
    var pickerData :NSDictionary!  //保存全部数据
    var pickerProvincesData: [String] = []  //当前的省数据
    var pickerCitiesData:[String] = []  //当前省下面的市数据
    var packArray = [String:[String]]()
    static var shared:YDTimePickerView? = YDTimePickerView(){
        didSet{
            if shared == nil{
                shared = YDTimePickerView()
            }
        }
    }
    func show(dataArray:NSDictionary)  {
        self.pickerData = nil
        self.pickerProvincesData.removeAll()
        self.pickerCitiesData.removeAll()
        self.pickerData = dataArray
        
        if self.pickerData.count == 1{
            //省份名数据
            self.pickerProvincesData = ["明天"]
            //默认取出第一个省的所有市的数据
            let seletedProvince = self.pickerProvincesData[0] as! String
            self.pickerCitiesData = self.pickerData[seletedProvince] as! [String]
        }else if self.pickerData.count == 2{
            //省份名数据
            self.pickerProvincesData = ["今天","明天"]
            
            //默认取出第一个省的所有市的数据
            let seletedProvince = self.pickerProvincesData[0] as! String
            self.pickerCitiesData = self.pickerData[seletedProvince] as! [String]
        }
        
        let rootRect = UIApplication.shared.windows.first?.frame   //应用屏幕大小
        let container = UIView()   //全屏且透明，盖在最上面， 可以自定义点击事件， 从而实现模态和非模态框效果。
        container.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        container.frame = rootRect!
        
        let whiteView = UIView.init(frame: CGRect.init(x: 0, y: LBFMScreenHeight * 0.65, width: LBFMScreenWidth , height: LBFMScreenHeight * 0.35))
        whiteView.backgroundColor = UIColor.white
        
        
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: LBFMScreenWidth, height: whiteView.frame.size.height * 0.2))
        topView.backgroundColor = YMColor(r: 243, g: 243, b: 243, a: 1)
        whiteView.addSubview(topView)
        
        
        let cancelBtn = UIButton.init(frame: CGRect.init(x:10, y: 0, width: 50, height: topView.height))
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(YMColor(r: 70, g: 130, b: 224, a: 1), for: UIControl.State.normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        topView.addSubview(cancelBtn)
        
        let sureBtn = UIButton.init(frame: CGRect.init(x: topView.width - 60, y: 0, width: 50, height: topView.height))
        sureBtn.setTitleColor(.black, for: .normal)
        sureBtn.setTitleColor(YMColor(r: 70, g: 130, b: 224, a: 1), for: UIControl.State.normal)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        topView.addSubview(sureBtn)
        
        
        pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: whiteView.frame.size.height * 0.2, width: LBFMScreenWidth, height: whiteView.frame.size.height * 0.8))
        pickerView.delegate = self
        pickerView.dataSource = self
        whiteView.addSubview(pickerView)
        
        container.addSubview(whiteView)
        
        UIApplication.shared.keyWindow?.addSubview(container)
    }
    
    @objc func cancelBtnClicked() {
        UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
        YDTimePickerView.shared = nil
        self.pickerData = nil
    }
    
    @objc func sureBtnClicked() {
        if self.titleArray.count > 0{
            hanSureBtnBlock!(self.titleArray)
            UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
            YDTimePickerView.shared = nil
        }else{
            let row1 = self.pickerView.selectedRow(inComponent: 0)
            let row2 = self.pickerView.selectedRow(inComponent: 1)
            if  self.pickerCitiesData.count > 0{
                let selected1 = self.pickerProvincesData[row1]
                let selected2 = self.pickerCitiesData[row2]
                self.titleArray.append(selected1)
                self.titleArray.append(selected2)
                hanSureBtnBlock!(self.titleArray)
                UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
                 YDTimePickerView.shared = nil
            }else{
                hanSureBtnBlock!(self.titleArray)
                UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
                 YDTimePickerView.shared = nil
            }
        }
        self.pickerData = nil
        
    }
    
    func hide() {
        UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
        YDTimePickerView.shared = nil
    }
    
}
extension YDTimePickerView:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            //第一个拨轮省份个数
            return self.pickerProvincesData.count
        } else {
            //第二个拨轮城市个数
            return self.pickerCitiesData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return self.pickerProvincesData[row] as? String
        } else {
            
            return self.pickerCitiesData[row] as? String
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0){
            let seletedProvince = self.pickerProvincesData[row]
            self.pickerCitiesData.removeAll()
            self.pickerCitiesData = self.pickerData[seletedProvince] as! [String]
            pickerView.reloadComponent(0)
            pickerView.reloadComponent(1)
        }
//        self.titleArray.removeAll()
//        self.titleArray.append(self.pickerProvincesData[component] )
//        self.titleArray.append(self.pickerCitiesData[row] )
//        print("-----%@---------%@",self.pickerProvincesData[component] ,self.pickerCitiesData[row] )
    }
    
}
