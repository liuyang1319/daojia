//
//  YDOrderCommentView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/15.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDOrderCommentView: UIView ,JNStarReteViewDelegate{
    var searchHeight: CGFloat = 0
    fileprivate var lastX: CGFloat = 10
    fileprivate var lastY: CGFloat = 20
    var array = NSArray()
    lazy var integralLabel:UILabel = {
        let backView = UILabel()
        backView.text = "配送服务评价"
        backView.font = UIFont.systemFont(ofSize: 14)
        backView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return backView
    }()
    lazy var iconImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.backgroundColor = UIColor.red
        return iamgeView
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "张三丰"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    lazy var anonymityLabel:UILabel = {
        let label = UILabel()
        label.text = "已对骑手匿名"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
        return label
    }()
    lazy var timerLabel:UILabel = {
        let label = UILabel()
        label.text = "50分钟(21:43送达)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.integralLabel)
        self.integralLabel.frame = CGRect(x:(LBFMScreenWidth-90)*0.5, y: 15, width: 90, height: 20)
        
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 10, y: self.integralLabel.frame.maxY+10, width: 50, height: 50)
        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: self.integralLabel.frame.maxY+20, width: 150, height: 15)
        
        self.addSubview(self.anonymityLabel)
        self.anonymityLabel.frame = CGRect(x: LBFMScreenWidth-100, y: self.integralLabel.frame.maxY+30, width: 70, height: 15)
        
        self.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y:  self.nameLabel.frame.maxY+5, width: 200, height: 20)
        
        
        
        starReteButtonClick()
        array = ["物有所值","包装很精美","价格很实惠","绿色健康","品质有保障","强烈推荐"]
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        for i in 0..<array.count {
            let btn = UIButton()
            btn.setTitle(array[i] as? String, for: UIControl.State())
            btn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            //            btn.layer.borderWidth = 0.5
            //            btn.layer.borderColor = YMColor(r: 200, g: 200, b: 200, a: 1).cgColor
            btn.addTarget(self, action: #selector(starReteButtonClick), for: UIControl.Event.touchUpInside)
            btnW = btn.titleLabel!.width + addW
            
            if frame.width - lastX > btnW {
                btn.frame = CGRect(x: lastX, y:lastY, width: btnW, height: btnH)
            } else {
                btn.frame = CGRect(x: 10, y: lastY + marginY + btnH, width: btnW, height: btnH)
            }
            
            lastX = btn.frame.maxX + marginX
            lastY = btn.y
            searchHeight = btn.frame.maxY
            
            self.addSubview(btn)
        }
        
        self.frame = CGRect(x: 0, y: self.iconImage.frame.maxY+5, width: LBFMScreenWidth-30, height: searchHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func starReteButtonClick(){
        let starView = JNStarRateView.init(frame: CGRect(x: (LBFMScreenWidth-150)*0.5,y:self.iconImage.frame.maxY+40,width: 150,height: 20), numberOfStars: 5, currentStarCount: 0)
        //        starView.isUserInteractionEnabled = false//不支持用户操作
        starView.delegate = self
        //        starView.followDuration = 0.1//滑动或点击后跟随到达时间
        starView.userPanEnabled = true //滑动
        starView.currentStarCount = 1 //当前显示的评星数
        starView.integerStar = true // 完整星星
        self.addSubview(starView)
    }
    func starRate(view starRateView: JNStarRateView, count: Float) {
        print(count)
    }
}
