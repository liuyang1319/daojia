//
//  YDHomeLikeTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2020/3/24.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDHomeLikeTableViewCell: UICollectionViewCell {
    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "猜你喜欢"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var lineLabel1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
     required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
        override init(frame: CGRect) {
          super.init(frame: frame)
             self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
             self.addSubview(self.lineLabel)
             self.lineLabel.frame = CGRect(x: (LBFMScreenWidth-300)*0.5, y: 35, width: 90, height: 1)
             
             self.addSubview(self.titleLabel)
             self.titleLabel.frame = CGRect(x: self.lineLabel.frame.maxX+25, y: 25, width: 70, height: 25)
             
             self.addSubview(self.lineLabel1)
             self.lineLabel1.frame = CGRect(x: self.titleLabel.frame.maxX+25, y: 35, width: 90, height: 1)
    }
}
