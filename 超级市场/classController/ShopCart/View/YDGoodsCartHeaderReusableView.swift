//
//  YDGoodsCartHeaderReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/18.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDGoodsCartHeaderReusableViewDelegate:NSObjectProtocol {
    //    选择地址
    func goHomeGoodsCartHeaderReusableView()
}
class YDGoodsCartHeaderReusableView: UICollectionReusableView {
    weak var delegate : YDGoodsCartHeaderReusableViewDelegate?
    var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    var cartImage : UIImageView = {
        let cartImage = UIImageView()
        cartImage.image = UIImage(named:"cartGoods_image")
        return cartImage
    }()
    var titleLabel:UILabel = {
        let titleName = UILabel()
        titleName.text = "购物车还空空如也～\n为您购物车去添加的商品吧"
        titleName.numberOfLines = 2
        titleName.textAlignment = .center
        titleName.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        titleName.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return titleName
    }()
    
    var goHome : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finisHomeButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 12.5
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("去逛逛", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 10, width: LBFMScreenWidth, height: 260)
        
        self.backView.addSubview(self.cartImage)
        self.cartImage.frame = CGRect(x: (LBFMScreenWidth-165)*0.5, y: 25, width: 165, height: 120)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y: self.cartImage.frame.maxY+20, width: 170, height: 35)
        
        self.backView.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-95)*0.5, y: self.titleLabel.frame.maxY+20, width: 95, height: 25)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func finisHomeButtonClick(){
        delegate?.goHomeGoodsCartHeaderReusableView()
    }
}
