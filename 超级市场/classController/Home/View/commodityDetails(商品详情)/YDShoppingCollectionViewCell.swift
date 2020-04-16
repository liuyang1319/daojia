//
//  YDShoppingCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDShoppingCollectionViewCell: UICollectionViewCell {
     var titleArray = [String]()

    fileprivate var lastX: CGFloat = 0
    fileprivate var lastY: CGFloat = 35
    private lazy var backView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "comment_b_image")
        return imageView
    }()
    private lazy var iconImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "headerImage")
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()

    private lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 2
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    
    private lazy var titleLbel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.5
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        return label
    }()
    
    private lazy var titleLbel1:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.5
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        return label
    }()
    private lazy var titleLbel2:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.5
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        return label
    }()
    private lazy var titleLbel3:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.5
        label.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        return label
    }()
    lazy var backWhite:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    var goodsEstimate:YDHomeGoodsEstimateInfo? {
        didSet{
            guard let model = goodsEstimate else { return }
            if model.headImg?.isEmpty == false {
                self.iconImage.kf.setImage(with: URL(string:(model.headImg ?? "")))
            }
            self.nameLabel.text = String(format:"%@", model.name ?? "")
            
            self.titleArray.removeAll()
            self.titleArray = model.able!.components(separatedBy: ",")
            
            if self.titleArray.count == 1 {
                self.titleLbel.text = self.titleArray[0]
                self.titleLbel.frame = CGRect(x:15, y:self.iconImage.frame.maxY+5, width:widthForView(text: self.titleLbel.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
            } else if self.titleArray.count == 2{
                self.titleLbel.text = self.titleArray[0]
                self.titleLbel.frame = CGRect(x: 15, y:self.iconImage.frame.maxY+5, width:widthForView(text: self.titleLbel.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel1.text = self.titleArray[1]
               self.titleLbel1.frame = CGRect(x: self.titleLbel.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel1.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
            } else if self.titleArray.count == 3{
                self.titleLbel.text = self.titleArray[0]
                self.titleLbel.frame = CGRect(x: 15, y:self.iconImage.frame.maxY+5, width:widthForView(text: self.titleLbel.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel1.text = self.titleArray[1]
                 self.titleLbel1.frame = CGRect(x: self.titleLbel.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel1.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel2.text = self.titleArray[2]
                self.titleLbel2.frame = CGRect(x: self.titleLbel1.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel2.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
            } else if self.titleArray.count == 4{
                self.titleLbel.text = self.titleArray[0]
                self.titleLbel.frame = CGRect(x: 15, y:self.iconImage.frame.maxY+5, width:widthForView(text: self.titleLbel.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel1.text = self.titleArray[1]
                self.titleLbel1.frame = CGRect(x: self.titleLbel.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel1.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel2.text = self.titleArray[2]
                self.titleLbel2.frame = CGRect(x: self.titleLbel1.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel2.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
                self.titleLbel3.text = self.titleArray[3]
                self.titleLbel3.frame = CGRect(x: self.titleLbel2.frame.maxX+15, y: self.iconImage.frame.maxY+5, width: widthForView(text: self.titleLbel3.text ?? "", font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular), height: 20)+15, height: 20)
            }
            
            
//            if model.able?.isEmpty == false{
//
//                var btnW: CGFloat = 0
//                let btnH: CGFloat = 20
//                let addW: CGFloat = 30
//                let marginX: CGFloat = 5
//                let marginY: CGFloat = 10
//
//                for (index,model) in self.titleArray.enumerated() {
//                    if index > 4{
//                        break
//                    }
//                    let btn = UIButton()
//                    btn.setTitle(model, for: UIControl.State())
//                    btn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State())
//                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
//                    btn.titleLabel?.sizeToFit()
//                    btn.backgroundColor = UIColor.white
//                    btn.layer.masksToBounds = true
//                    btn.layer.cornerRadius = 5
//                    btn.layer.borderWidth = 0.5
//                    btn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
//                    btnW = btn.titleLabel!.width + addW
//                    btn.frame = CGRect(x: lastX, y:5, width: btnW, height: btnH)
//                    lastX = btn.frame.maxX + marginX
//                    lastY = btn.y
//                    self.backWhite.addSubview(btn)
//                }
//
//            }
            
            self.contentLabel.text = String(format:"评论内容:%@", model.content ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y:0, width: 280, height: 130)
        
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 10, y: 10, width: 36, height: 36)
        
//        self.addSubview(self.backWhite)
        self.backWhite.backgroundColor = UIColor.red
        self.backWhite.frame = CGRect(x: 10, y: self.iconImage.frame.maxY+2, width: 280, height: 25)
        
        self.addSubview(self.titleLbel)
        self.addSubview(self.titleLbel1)
        self.addSubview(self.titleLbel2)
        self.addSubview(self.titleLbel3)

        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 10, width: 214, height: 20)
        
        
        self.addSubview(self.contentLabel)
        self.contentLabel.frame = CGRect(x: 10, y: self.backWhite.frame.maxY+10, width: 260, height: 30)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
