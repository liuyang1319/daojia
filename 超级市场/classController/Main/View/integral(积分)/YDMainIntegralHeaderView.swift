//
//  YDMainIntegralHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDMainIntegralHeaderView: UIView {
    // 图片
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "integral_Image")
        return imageView
    }()
    // 毛玻璃背景
    private lazy var blurImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "integral_BackImage")
        return imageView
    }()
    // 标题
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "我得积分"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    // 积分
    private lazy var integralLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        return label
    }()
    // 昵称图片
    private lazy var nickView:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "help_image"), for: UIControl.State.normal)
        return button
    }()
    // 昵称
    private lazy var nickLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "积分可以当钱花哦!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    var integralString:String = ""{
        didSet {
            self.integralLabel.text = integralString
        }
    }
    func setUpUI(){
        self.addSubview(self.blurImageView)
        self.blurImageView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 240)
        
        self.addSubview(self.nickView)
        self.nickView.frame = CGRect(x: LBFMScreenWidth-80, y: 30, width: 80, height: 25)
        
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect(x: (LBFMScreenWidth - 160)*0.5, y: 30, width: 160, height: 160)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: (LBFMScreenWidth - 75)*0.5, y: 75, width: 75, height: 25)
        
        
        self.addSubview(self.integralLabel)
        self.integralLabel.frame = CGRect(x:(LBFMScreenWidth - 160)*0.5, y: self.titleLabel.frame.maxY+5, width: 160, height: 45)
        
        self.addSubview(self.nickLabel)
        self.nickLabel.frame = CGRect(x: (LBFMScreenWidth-110)*0.5, y: self.imageView.frame.maxY+15, width: 110, height: 15)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
