//
//  YDGoodsCategoryHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDGoodsCategoryHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        titleLabel.backgroundColor = UIColor.red
        titleLabel.textColor = UIColor.white
        titleLabel.text = "惊爆价"
        titleLabel.frame = CGRect(x: 15, y: 10, width: LBFMScreenWidth-30, height: 20)
        self.addSubview(titleLabel)
    }
}
