//
//  YDShopCartFooterReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDShopCartFooterReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.black
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout()  {
        let downView = UIView()
        downView.backgroundColor = UIColor.green
        self.addSubview(downView)
        downView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 40)
        let titleLabel = UILabel()
        titleLabel.text = "CartFooter"
        titleLabel.backgroundColor = UIColor.white
        titleLabel.frame = CGRect(x: 15, y: 10, width: LBFMScreenWidth-30, height: 20)
        downView.addSubview(titleLabel)
    }
}
