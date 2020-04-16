//
//  YDSelectShopMenuTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/12.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSelectShopMenuTableViewCell: UITableViewCell {
    
    lazy var iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"menu_icon")
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var typeLabel:UILabel = {
        let label = UILabel()
        label.text = "提"
        label.textAlignment = .center
        label.backgroundColor = YMColor(r: 255, g: 146, b: 54, a: 1)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 8, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var typeTitle:UILabel = {
        let label = UILabel()
        label.text = "支持自提"
        label.textColor = YMColor(r: 255, g: 146, b: 54, a: 1)
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var selectImage : UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.isHidden = true
        iamgeView.image = UIImage(named: "select_menu")
        return iamgeView
    }()
    
    lazy var backImage : UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.isHidden = true
        iamgeView.image = UIImage(named: "select_menu_Image")
        return iamgeView
    }()
    
    lazy var distanceTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var addersTitle:UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 84, g: 85, b: 84, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.backImage)
        self.backImage.isHidden = false
        self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth-60, height: 60)
        
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 10, y: 25, width: 25, height: 25)
        
   
        self.addSubview(self.titleLabel)
        
//        self.addSubview(self.selectImage)

        self.addSubview(self.typeLabel)
        self.addSubview(self.typeTitle)
        
        self.addSubview(self.distanceTitle)
        
        self.addSubview(self.addersTitle)
        
    }
    
    var shopMenuListModel :YDShopMenuList? {
        didSet {
            guard let model = shopMenuListModel else {return}
            self.iconImage.kf.setImage(with:URL(string:model.siteImg ?? ""), placeholder: UIImage(named:"menu_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            
            self.titleLabel.text = model.siteName ?? ""
            self.titleLabel.frame = CGRect(x:self.iconImage.frame.maxX+10, y:15, width: widthForView(text: self.titleLabel.text ?? "", font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 25), height: 25)
            
            self.typeLabel.frame = CGRect(x: self.titleLabel.frame.maxX+3, y: 20, width: 10, height: 10)
            
            self.typeTitle.frame = CGRect(x:  self.typeLabel.frame.maxX+5, y:18, width: 40, height: 15)
            
            self.selectImage.isHidden = false
            self.selectImage.frame = CGRect(x: LBFMScreenWidth-90, y: 15, width: 15, height: 15)
            
            
            self.addersTitle.text = model.address ?? ""
            self.addersTitle.frame = CGRect(x: self.iconImage.frame.maxX+10, y: self.titleLabel.frame.maxY, width: widthForView(text: self.addersTitle.text ?? "", font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular), height: 15), height: 15)
            let distanceKm = (model.distance ?? 0)*1000
            
            if distanceKm < 1000{
                self.distanceTitle.text = String(distanceKm) + "m"
                self.distanceTitle.frame = CGRect(x: LBFMScreenWidth - 110, y: self.selectImage.frame.maxY+5, width: 45, height: 15)
            }else{
                self.distanceTitle.text = String(model.distance ?? 0) + "km"
                self.distanceTitle.frame = CGRect(x: LBFMScreenWidth - 110, y: self.selectImage.frame.maxY+5, width: 45, height: 15)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
