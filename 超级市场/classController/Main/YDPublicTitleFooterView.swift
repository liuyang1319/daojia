//
//  YDPublicTitleFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDPublicTitleFooterView: UITableViewHeaderFooterView {

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
    // 提示
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
        
        self.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: (LBFMScreenWidth-130)*0.5, y: 0, width: 130, height: 150)
        
        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x:15, y: self.backImage.frame.maxY+15, width: LBFMScreenWidth-30, height: 20)
        
    }
   
//        if isUserLogin() != true{
//            self.nameLabel.text = "您还没有此类订单哦～"
//            //            self.backImage
//        }else{
//            self.nameLabel.text = "登陆后才能查看订单哦"
//            //            self.backImage
//        }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var IntegralGoods:String = "0"{
        didSet {
            self.nameLabel.text = IntegralGoods
        }
    }
    var headImg : String = "" {
        didSet {

            self.backImage.kf.setImage(with: URL(string:headImg))
        }
    }

}
