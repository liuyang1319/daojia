//
//  YDRecommendCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/4.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDRecommendCollectionViewCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect(x: 0, y: 0, width:(LBFMScreenWidth-50)*0.25, height: 135)
    }
    var baerImage : String = "" {
        didSet {
            self.imageView.kf.setImage(with: URL(string:baerImage))
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
