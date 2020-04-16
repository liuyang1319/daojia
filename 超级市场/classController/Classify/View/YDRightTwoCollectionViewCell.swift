//
//  YDRightTwoCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDRightTwoCollectionViewCell: UICollectionViewCell {

    lazy var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var GoodsImage : UIImageView = {
        let goods = UIImageView()
        goods.backgroundColor = UIColor.white
        return goods
    }()
    
    lazy var goodsName : UILabel = {
        let label = UILabel()
        label.textColor  = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       setUpLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpLayout(){
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width:(LBFMScreenWidth-110)/3, height: 120)
        
        self.backView.addSubview(self.GoodsImage)
        self.GoodsImage.frame = CGRect (x: ((LBFMScreenWidth-110)/3 - 80)*0.5, y: 10, width:80, height: 80)
        
        self.backView.addSubview(self.goodsName)

    }
    
    var seearchGoodsModel:YDClassfiyTwoListModel? {
        didSet {
            guard let model = seearchGoodsModel else {return}
            
            self.GoodsImage.kf.setImage(with: URL(string:model.imageUrl ?? "") ,placeholder:UIImage(named:"shop_image"))
            
            self.goodsName.text = model.name ?? ""
            self.goodsName.frame = CGRect(x:0, y: self.GoodsImage.frame.maxY+5, width: (LBFMScreenWidth-110)/3, height:20)
        }
    }
}
