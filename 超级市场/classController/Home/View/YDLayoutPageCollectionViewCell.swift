//
//  YDLayoutPageCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/30.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDLayoutPageCollectionViewCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 设置布局
        setupLayOut()
    }
    func setupLayOut(){
        self.imageView.frame = CGRect(x: 10, y: 10, width: LBFMScreenWidth-20, height: 85)
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layoutPageGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = layoutPageGoodsModel else {return}
            self.imageView.kf.setImage(with: URL(string:model[0].activityImage ?? ""))
        }
    }
}
