//
//  YDOrderDetailsTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDOrderDetailsTableViewCell: UITableViewCell {
    
    lazy var backView : UIView = {
        let backView = UIView()
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    //    商品
    lazy var shopImage:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    // 昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    // 昵称
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    // 数量
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    
    lazy var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 105)
        
        
        self.backView.addSubview(self.shopImage)
        self.shopImage.frame = CGRect (x: 15, y: 15, width: 65, height: 60)
        
        self.backView.addSubview(self.nameLabel)
       
        
        self.backView.addSubview(self.priceLabel)
        
        self.priceLabel.frame = CGRect(x: self.shopImage.frame.maxX+15, y: self.shopImage.frame.maxY-20, width: LBFMScreenWidth-120, height: 20)
        
        self.backView.addSubview(self.countLabel)
        self.countLabel.frame = CGRect(x: LBFMScreenWidth-60, y:self.shopImage.frame.maxY-20, width: 30, height: 20)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 89, width: LBFMScreenWidth-60, height: 1)
        
    }

    
    var orderGoodsModel: YDorderDetailGoodsModel? {
        didSet{
            guard let orderModel = orderGoodsModel else {return}
            
            self.shopImage.kf.setImage(with: URL(string: orderModel.imageUrl ?? ""))
            
            self.nameLabel.text =  String(format:"%@ %@%@", orderModel.goodsName ?? "",orderModel.weight ?? "",orderModel.unitName ?? "")
            
            self.nameLabel.frame = CGRect(x: self.shopImage.frame.maxX+15, y: 15, width: LBFMScreenWidth-120, height: heightForView(text: self.nameLabel.text ?? "", font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-120))
            
            self.priceLabel.text = String(format: "¥%.2f", orderModel.salePrice ?? 0)
            
            self.countLabel.text = String(format: "x%d", orderModel.count ?? 0)
 
        }
    }
    
    
}
