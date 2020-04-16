//
//  YDRightCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/4.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDRightCollectionViewCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "more_Image")
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.center
        label.text = "全部"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect(x:((LBFMScreenWidth-110)/3 - 45)*0.5, y: 30, width: 45, height: 45)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 0, y: self.imageView.frame.maxY+20, width:(LBFMScreenWidth-110)/3, height: 20)

    }
    var selectName : String = ""{
        didSet {
            self.titleLabel.text = String(format: "全部")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
