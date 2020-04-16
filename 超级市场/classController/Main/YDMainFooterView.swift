//
//  YDMainFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/29.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDMainFooterView: UITableViewHeaderFooterView {
    lazy var blackView : UIView = {
        let  menuView =  UIView()
        menuView.backgroundColor = UIColor.white
        menuView.layer.cornerRadius = 5
        menuView.clipsToBounds = true
        return menuView
    }()
    lazy var backImage:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var orderLabel:UILabel = {
        let label = UILabel()
        label.text = "我的订单"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
        label.textColor = YMColor(r:102, g:102, b:102, a: 1)
        return label
        }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.addSubview(blackView)
        self.blackView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMScreenHeight)
        
        
//        self.blackView.addSubview(self.orderLabel)
        self.orderLabel.frame = CGRect(x: 15, y: 15, width: 300, height: 25)
        
        
        self.addSubview(self.backImage)
        self.backImage.frame = CGRect(x:125, y:100, width: 165, height: 136)
        
        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x:125, y: self.backImage.frame.maxY+15, width: 130, height: 20)
        
//        if isUserLogin() != true{
            self.nameLabel.text = "您还没有此类订单哦～"
            self.backImage.image = UIImage(named: "OrderLogin_image")
//        }else{
//            self.nameLabel.text = "登陆后才能查看订单哦"
//            self.backImage.image = UIImage(named: "orderNull_image")
//        }
//
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
