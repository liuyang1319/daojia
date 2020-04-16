//
//  YDSpecialCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSpecialCollectionViewCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.text = "水果"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 180)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
