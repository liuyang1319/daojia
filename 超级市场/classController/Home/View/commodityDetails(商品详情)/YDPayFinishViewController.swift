//
//  YDPayFinishViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDPayFinishViewController: YDBasicViewController {
    
    var orderNumber = String()
    
    var backImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pay_back_image")
        return imageView
    }()
    
    var finishImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"pay_demo_iamge")
        return imageView
    }()
    
    var iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"pay_i_image")
        return imageView
    }()
    var payTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "支付成功"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    
    var goodsPrice:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        return label
    }()
    
    var timerLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "预计 10:00-10:30 送达"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "小主，您的锦囊正在准备，请稍等"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    var orderLook :UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        button.setTitle("查看订单", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named:"buyAgainImage"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(backInishSelectButton), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    var finishBtn :UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        button.setTitle("随意逛逛", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named:"buyAgainImage"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(backHomeSelectButton), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    var titleNa:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "辉鲜，只为给您提供更好的服务"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var countsumPrice:Double = 0.00{
        didSet {
            self.goodsPrice.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
            self.goodsPrice.text = String(format: "¥%.2f",countsumPrice)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reuqestOrderTimer()
        self.view.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 215)
        
        
        self.view.addSubview(self.finishImage)
        self.finishImage.frame = CGRect(x: (LBFMScreenWidth-35)*0.5, y:LBFMNavBarHeight+15, width: 35, height: 35)
        
        
        
        self.view.addSubview(self.payTitle)
        self.payTitle.frame = CGRect(x: (LBFMScreenWidth-75)*0.5, y:self.finishImage.frame.maxY+10, width: 75, height: 25)
        
        
        self.view.addSubview(self.goodsPrice)
        self.goodsPrice.frame = CGRect(x: 15, y: self.payTitle.frame.maxY+25, width: LBFMScreenWidth-30, height: 50)
        
        self.view.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x:(LBFMScreenWidth-145)*0.5, y: self.goodsPrice.frame.maxY, width: 145, height: 145)
        
        
        self.view.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: 15, y: self.iconImage.frame.maxY+15, width: LBFMScreenWidth-30, height: 20)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: self.timerLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 20)
        
        self.view.addSubview(self.orderLook)
        self.orderLook.frame = CGRect(x: (LBFMScreenWidth-240)/3, y:self.titleLabel.frame.maxY+30, width: 120, height: 35)
        
        self.view.addSubview(self.finishBtn)
        self.finishBtn.frame = CGRect(x: ((LBFMScreenWidth-240)/3)*2 + 120 , y:self.titleLabel.frame.maxY+30, width: 120, height: 35)
        
        
        self.view.addSubview(self.titleNa)
        self.titleNa.frame = CGRect(x: 15, y:LBFMScreenHeight - 30 , width: LBFMScreenWidth-30, height: 15)
    }
    func reuqestOrderTimer(){
        YDShopCartViewProvider.request(.getGoodsOrderCreateTimer(orderNum:self.orderNumber, token:UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-----------%@",json)
                let sign = String(describing:json["data"]["expectTime"])
                let str1 = sign.suffix(12)
                self.timerLabel.text = "预计 \(str1) 送达"
                }
            }
        }
    }
//    查看订单详情
    @objc func backInishSelectButton(){
        let detailsVC = YDOrderDetailsViewController()
        detailsVC.orderNumber = self.orderNumber
        detailsVC.backStr = "666"
        self.navigationController?.pushViewController(detailsVC, animated: true)
//        self.tabBarController?.selectedIndex = 3
    }
//    去首页
    @objc func backHomeSelectButton(){
        self.tabBarController?.selectedIndex = 0
        let viewCtl = self.navigationController?.viewControllers[0]
        self.navigationController?.popToViewController(viewCtl!, animated:true)
        
    }
    
}
