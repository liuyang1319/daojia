//
//  YDClassGoodsTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/16.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit
protocol YDClassGoodsTableViewCellDelegate:NSObjectProtocol {
    //    商品加
    func plusSelctTableViewCell(button:UIButton,cell:YDClassGoodsTableViewCell ,icon: UIImageView)
}
class YDClassGoodsTableViewCell: YDGoodsTableViewCell {
     weak var delegate : YDClassGoodsTableViewCellDelegate?
    lazy var GoodsImage : UIImageView = {
        let goods = UIImageView()
        goods.image = UIImage(named:"")
        return goods
    }()
    
    lazy var goodsName : UILabel = {
        let label = UILabel()
        label.textColor  = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.numberOfLines = 2
        return label
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var vipLabel : UILabel = {
        let label = UILabel ()
        label.backgroundColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.layer.cornerRadius = 3
        label.text = "会员价8折"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
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
    lazy var volumeLabel : UILabel = {
        let label = UILabel ()
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        label.layer.borderWidth = 1
        label.text = "月销量"
        label.textAlignment = .center
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var volumeSum : UILabel = {
        let label = UILabel ()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
//    lazy var cartButon : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "cartImage"), for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(plusSelctButtonClick(plusButton:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
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
        self.addSubview(self.GoodsImage)
        self.GoodsImage.frame = CGRect (x: 15, y: 40, width: 80, height: 80)
        self.addSubview(self.goodsName)
//        self.addSubview(self.vipLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.originalPriceLabel)
        self.addSubview(self.volumeLabel)
        self.addSubview(self.volumeSum)
        self.addSubview(self.addGoods)
        self.addSubview(self.amontCart)
        self.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y: 139, width: LBFMScreenWidth-self.GoodsImage.frame.maxX-10, height: 1)
    }
    
    var seearchGoodsModel:YDSearchcategorylistModel? {
        didSet {
            guard let model = seearchGoodsModel else {return}
            self.GoodsImage.kf.setImage(with: URL(string: model.imageUrl ?? ""))
            self.goodsName.text =  String(format:"%@ %@%@", model.name ?? "",model.weight ?? "",model.unitName ?? "")
            self.goodsName.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y: 15, width: LBFMScreenWidth-125, height: heightForView(text:self.goodsName.text!, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-125))
            self.vipLabel.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y: self.goodsName.frame.maxY+5, width: 60, height: 15)
            self.titleLabel.text = model.title ?? ""
            self.titleLabel.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y: self.goodsName.frame.maxY+10, width: LBFMScreenWidth-125, height: heightForView(text:self.titleLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular), width: LBFMScreenWidth-125))
            
            
            self.priceLabel.text = String(format: "￥%.2f", model.salePrice ?? 0.00)
            self.priceLabel.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y:self.vipLabel.frame.maxY+30, width:widthForView(text: self.priceLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 20), height:20)

            self.originalPriceLabel.text = String(format:"￥%.2f", model.formalPrice ?? 0.00)
            
            let attribtStr = NSAttributedString.init(string: self.originalPriceLabel.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalPriceLabel.attributedText = attribtStr
            
            self.originalPriceLabel.frame = CGRect(x: self.priceLabel.frame.maxX+15, y:self.vipLabel.frame.maxY+30, width:widthForView(text: self.originalPriceLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), height: 20) , height:20)
            
            self.volumeLabel.frame = CGRect(x: self.GoodsImage.frame.maxX+10, y: self.priceLabel.frame.maxY+10, width: 50, height: 15)
            
            self.volumeSum.text = String(format: "%@件", model.saleNums ?? "0")
            self.volumeSum.frame = CGRect(x: self.volumeLabel.frame.maxX+5, y: self.priceLabel.frame.maxY+10, width: widthForView(text: self.volumeSum.text!, font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 15), height: 15)
            
            self.addGoods.frame = CGRect(x: LBFMScreenWidth-40, y: self.priceLabel.frame.maxY+5, width: 25, height: 25)
            self.amontCart.frame = CGRect(
                x: addGoods.frame.maxX - 10,
                y: addGoods.frame.minY - 5,
                width: 15,
                height: 15
            )
            
            let goodsCartCount = YDShopCartTool.share().inCartCount(goodsId: model.id ?? "")
            amontCart.text = "\(goodsCartCount)"
            amontCart.isHidden = goodsCartCount == 0
        }
    }
    
    override func addSelectGoodsCart(selectBtn: UIButton) {
        var count = Int(amontCart.text ?? "0") ?? 0
        count += 1
        amontCart.text = "\(count)"
        amontCart.isHidden = count == 0
        
        delegate?.plusSelctTableViewCell(button: selectBtn, cell: self, icon: self.GoodsImage)
    }
    
}
