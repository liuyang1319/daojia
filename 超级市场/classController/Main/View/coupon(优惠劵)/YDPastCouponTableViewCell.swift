//
//  YDPastCouponTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/13.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDPastCouponTableViewCell: UITableViewCell {
    //    低图
        lazy var iconImage : UIImageView = {
            let iconImage = UIImageView()
            return iconImage
        }()
        lazy var backImage : UIImageView = {
            let image = UIImageView()
            return image
        }()
        //    价格
        lazy var priceLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight.bold)
            return label
        }()
        
        //    最低价格
        lazy var minPriceLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
            return label
        }()
        
        //    类型
        lazy var typeLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
            return label
        }()
        //    有效时间
        lazy var timerLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)
            return label
        }()
        
    //        立即使用
        lazy var employLabel : UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    //        button.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
    //        button.semanticContentAttribute = .forceRightToLeft
    //        button.addTarget(self, action: #selector(reconPriceGoodsListButtonClick(rankButton:)), for: UIControl.Event.touchUpInside)
            button.setTitle("立即使用", for: UIControl.State.normal)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(UIColor.white, for: UIControl.State.normal)
            return button
        }()
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
            setUpLayout()
        }
        
        func setUpLayout(){
            self.addSubview(self.iconImage)
            self.iconImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 140)
            
            self.addSubview(self.backImage)
            self.backImage.frame = CGRect(x: LBFMScreenWidth-115, y: 0, width: 100, height: 100)
            
            self.addSubview(self.priceLabel)
            self.priceLabel.frame = CGRect(x: 70, y: 25, width: 150, height: 60)
            
            self.addSubview(self.typeLabel)
            self.typeLabel.frame = CGRect(x: LBFMScreenWidth-200, y: 30, width: 160, height: 20)
            
            
            self.addSubview(self.timerLabel)
            self.timerLabel.frame = CGRect(x: LBFMScreenWidth-200, y: self.typeLabel.frame.maxY, width: 200, height: 15)
            
            self.addSubview(self.minPriceLabel)
            self.minPriceLabel.frame = CGRect(x: 75, y: self.priceLabel.frame.maxY, width: 100, height: 15)
            
    //        self.addSubview(self.employLabel)
            self.employLabel.frame = CGRect(x: LBFMScreenWidth-200, y: self.priceLabel.frame.maxY, width: 70, height: 20)
            
        }
        var couponContentsModel:YDCouponDetailGoodsModel? {
            didSet {
                guard let model = couponContentsModel else {return}
                self.iconImage.kf.setImage(with: URL(string: model.imageUrl ?? ""),placeholder:UIImage(named: "coupon_not_use"))
                self.priceLabel.text = model.price ?? ""
                if model.type == "1"{
                    self.typeLabel.text = "满减劵"
                } else  if model.type == "2"{
                    self.typeLabel.text = "代金券"
                } else  if model.type == "3"{
                    self.typeLabel.text = "免邮券 "
                }
                let sub1 = model.startTime?.prefix(10)
                let sub2 = model.endTime?.prefix(10)
                self.timerLabel.text = String(format: "%@ 至 %@", sub1 as CVarArg? ?? "", sub2 as CVarArg? ?? "")
                let price = "满" + String(model.minOrderPrice ?? "") + "元使用"
                self.minPriceLabel.text = String(describing:price)

            }
        }
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
