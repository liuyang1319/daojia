//
//  YDGoodsTwoTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDGoodsTwoTableViewCell: UITableViewCell {
    var backView:UIView = {
        let back = UIView()
        back.backgroundColor = UIColor.white
        back.layer.cornerRadius = 5
        back.clipsToBounds = true
        return back
    }()
    var iconImage : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    var nameTitle:UILabel = {
       let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var titleLabel :UILabel = {
        let label = UILabel()
        label.text = "精品"
        label.textAlignment = .center
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor;
        label.layer.borderWidth = 1;
        label.clipsToBounds = true;
        label.layer.cornerRadius = 5;
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
    
    lazy var goBtn :UIButton = {
        let button = UIButton()
        button.setTitle("去抢购", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = YMColor(r: 77, g: 195, b: 45, a: 1)
        button.clipsToBounds = true;
        button.layer.cornerRadius = 12.5;
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setUpLayout()
    }
    func setUpLayout(){
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-30, height: 105)
        
        self.backView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 10, width: 85, height: 85)
        
        self.backView.addSubview(self.nameTitle)
        self.nameTitle.frame = CGRect(x: self.iconImage.frame.maxX+15, y: 10, width: LBFMScreenWidth-200, height: 20)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:  self.iconImage.frame.maxX+15, y: self.nameTitle.frame.maxY+5, width: 30, height: 15)
        
        self.addSubview(self.priceLabel)
        self.addSubview(self.originalPriceLabel)
        
        
        self.backView.addSubview(self.goBtn)
        self.goBtn.frame = CGRect(x: LBFMScreenWidth-110, y: 68, width: 65, height: 25)
        

    }
    var goodsCategoryModel:YDGoodsCategoryListModel? {
        didSet {
            guard let model = goodsCategoryModel else {return}
            self.iconImage.kf.setImage(with: URL(string:model.imageUrl ?? ""))
            self.nameTitle.text = String(format:"%@ %@%@", model.name ?? "",model.weight ?? "",model.unitName ?? "")
            self.priceLabel.text = String(format: "￥%.2f", model.salePrice ?? 0)
            self.priceLabel.frame = CGRect(x:self.iconImage.frame.maxX+15, y:90, width:widthForView(text: self.priceLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 20), height:20)
            
            self.originalPriceLabel.text = String(format: "￥%.2f", model.formalPrice ?? 0)
            let attribtStr = NSAttributedString.init(string: self.originalPriceLabel.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalPriceLabel.attributedText = attribtStr
            self.originalPriceLabel.frame = CGRect(x:self.priceLabel.frame.maxX+10, y:90, width:widthForView(text: self.originalPriceLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), height: 20) , height:20)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
