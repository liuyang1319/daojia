//
//  YDGoodsTwoCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDGoodsTwoCollectionViewCellDelegate:NSObjectProtocol {
    //    添加到购物车
    func addSelectGoodsCartTableViewCell(selectBtn:UIButton,cell:YDGoodsTwoCollectionViewCell ,icon: UIImageView)
}
class YDGoodsTwoCollectionViewCell: UICollectionViewCell {
    weak var delegate : YDGoodsTwoCollectionViewCellDelegate?
    
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    lazy var priceLabel : UILabel = {
        let label = UILabel ()
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var originalPriceLabel : UILabel = {
        let label = UILabel ()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var addGoods : UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(named:"cartImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addSelectGoodsCart(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x:0, y:0, width: (LBFMScreenWidth - 45)/3 , height: 210)
        
        self.backView.addSubview(self.imageView)
        self.imageView.frame = CGRect(x:10, y:15, width:85, height: 85)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 10, y: self.imageView.frame.maxY+10, width:(LBFMScreenWidth - 40)/3 - 10 , height: 20)
        
//        self.backView.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 10, y: self.titleLabel.frame.maxY+5, width:(LBFMScreenWidth - 40)/3 - 10 , height: 20)
        
        self.backView.addSubview(self.priceLabel)
        self.backView.addSubview(self.originalPriceLabel)
        
//        self.backView.addSubview(self.addGoods)
        self.addGoods.frame = CGRect(x: (LBFMScreenWidth - 30)/3 - 40, y: self.nameLabel.frame.maxY+20, width: 30, height: 30)
        
        
    }
    var youLikeGoodsModel:YDGoodsCategoryListModel? {
        didSet {
            guard let model = youLikeGoodsModel else {return}
            
            self.imageView.kf.setImage(with: URL(string:model.imageUrl ?? ""))
            self.titleLabel.text =  String(format:"%@ %@%@", model.name ?? "",model.weight ?? "",model.unitName ?? "")
            self.nameLabel.text = String(model.title ?? "")
            
            self.priceLabel.text = String(format: "￥%.2f", model.salePrice ?? "")
            self.priceLabel.frame = CGRect(x: 10, y:self.titleLabel.frame.maxY+30, width:widthForView(text: self.priceLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 20), height:20)
            
            self.originalPriceLabel.text = String(format: "￥%.2f", model.formalPrice ?? "")
            let attribtStr = NSAttributedString.init(string: self.originalPriceLabel.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalPriceLabel.attributedText = attribtStr
            self.originalPriceLabel.frame = CGRect(x:10, y:self.priceLabel.frame.maxY, width:widthForView(text: self.originalPriceLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), height: 20) , height:20)
        }
    }
    @objc func addSelectGoodsCart(selectBtn:UIButton){
        delegate?.addSelectGoodsCartTableViewCell(selectBtn: selectBtn, cell:self, icon: self.imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
