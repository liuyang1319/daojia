//
//  YDHomeHeaderGridCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDHomeHeaderGridCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(45)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
        }
    }
    
    var baerNameImage:YDHomeAllGoodListModel? {
        didSet {
            guard let model = baerNameImage else {return}
            
            self.imageView.kf.setImage(with: URL(string:model.activityImage ?? ""))
            self.titleLabel.text = model.activityName ?? ""
        }
    }
    
//    var baerImage : String = "" {
//        didSet {
//            self.imageView.kf.setImage(with: URL(string:baerImage))
//        }
//    }
//    var baerName : String = "" {
//        didSet {
//            self.titleLabel.text = baerName
//        }
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
