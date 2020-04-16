//
//  YDHomeRecommendCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDHomeRecommendCollectionViewCellDelegate:NSObjectProtocol {
    //    添加到购物车
    func addSelectYouLikeGoodsTableViewCell(selectBtn:UIButton,cell:YDHomeRecommendCollectionViewCell ,icon: UIImageView)
}
class YDHomeRecommendCollectionViewCell: YDGoodsCollectionCell {
    weak var delegate : YDHomeRecommendCollectionViewCellDelegate?
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
//    lazy var addGoods : UIButton = {
//        let button = UIButton ()
//        button.setImage(UIImage(named:"cartImage"), for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(addSelectGoodsCart(selectBtn:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect(x:((LBFMScreenWidth - 30)/2 - 115) * 0.5, y: 0, width:115, height: 115)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 10, y: self.imageView.frame.maxY+15, width:(LBFMScreenWidth - 30)/2 - 20 , height: 20)
        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 10, y: self.titleLabel.frame.maxY+5, width:(LBFMScreenWidth - 30)/2 - 20 , height: 20)
        
        self.addSubview(self.priceLabel)
        self.addSubview(self.originalPriceLabel)
        
        
        self.addSubview(self.addGoods)
        self.addGoods.frame = CGRect(x: (LBFMScreenWidth - 30)/2 - 40, y: self.nameLabel.frame.maxY+20, width: 30, height: 30)
        
        addSubview(amontCart)
        amontCart.frame = CGRect(
            x: addGoods.frame.maxX - 10,
            y: addGoods.frame.minY - 5,
            width: 15,
            height: 15
        )
    }
    var youLikeGoodsModel:YDHomeYouLikeListModel? {
        didSet {
            guard let model = youLikeGoodsModel else {return}
            
            self.imageView.kf.setImage(with: URL(string:model.goodsImg ?? ""))
            self.titleLabel.text = String(format:"%@ %@%@", model.goodsName ?? "",model.goodsWeight ?? "",model.unitName ?? "")
            self.nameLabel.text = String(model.goodsTitle ?? "")
            
            self.priceLabel.text = String(format: "￥%.2f", model.salePrice ?? "")
            self.priceLabel.frame = CGRect(x: 10, y:self.nameLabel.frame.maxY+15, width:widthForView(text: self.priceLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 20), height:20)
            
            self.originalPriceLabel.text = String(format: "￥%.2f", model.formalPrice ?? "")
            let attribtStr = NSAttributedString.init(string: self.originalPriceLabel.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalPriceLabel.attributedText = attribtStr
            self.originalPriceLabel.frame = CGRect(x:10, y:self.priceLabel.frame.maxY, width:widthForView(text: self.originalPriceLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), height: 20) , height:20)
            
            let goodsCartCount = YDShopCartTool.share().inCartCount(goodsId: model.goodsId ?? "")
            amontCart.text = "\(goodsCartCount)"
            amontCart.isHidden = goodsCartCount == 0
        }
    }
    @objc override func addSelectGoodsCart(selectBtn:UIButton){
        var count = Int(amontCart.text ?? "0") ?? 0
        count += 1
        amontCart.text = "\(count)"
        amontCart.isHidden = count == 0
        
        delegate?.addSelectYouLikeGoodsTableViewCell(selectBtn: selectBtn, cell:self, icon: self.imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
