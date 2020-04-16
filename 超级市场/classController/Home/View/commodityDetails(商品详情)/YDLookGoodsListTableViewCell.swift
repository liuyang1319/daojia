//
//  YDLookGoodsListTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDLookGoodsListTableViewCell: UITableViewCell {
    lazy var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
//        let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25, height: 25))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = view.bounds
//        maskLayer.path = maskPath.cgPath
//        view.layer.mask = maskLayer
//
//        view.layer.cornerRadius = 5
//        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var iconImage : UIImageView = {
        let iconImage = UIImageView()
        iconImage.backgroundColor = UIColor.white
        return iconImage
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var numberLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153,g:153, b:153, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    lazy var lineLabel:UILabel = {
        let label = UILabel()
        
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 100)
        
        
        self.backView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 65, height: 65)
        
        self.backView.addSubview(self.nameLabel)
       
        
        self.backView.addSubview(self.priceLabel)
        self.priceLabel.frame = CGRect(x: self.iconImage.frame.maxX+20, y: 60, width: 200, height: 20)
        
        self.backView.addSubview(self.numberLabel)
        self.numberLabel.frame = CGRect(x: LBFMScreenWidth-175, y: 63, width: 130, height: 15)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 99, width: LBFMScreenWidth-60, height: 1)
        
    }
        var goodListModel:YDOrderGoodListModel? {
            didSet{
                guard let model = goodListModel else { return }
                self.iconImage.kf.setImage(with: URL(string:model.imageUrl ?? ""))
                
                self.nameLabel.text =  String(format:"%@ %@%@", model.goodsName ?? "",model.weight ?? "",model.unitName ?? "")
                self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+20, y: 15, width: LBFMScreenWidth-115, height: heightForView(text: self.nameLabel.text!, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-115))
                
                self.priceLabel.text = "¥\(model.salePrice ?? 0.0 )"
                self.numberLabel.text = String(format:"%@%@x%d",model.weight ?? "",model.unitName ?? "",model.count ?? 0)
            }
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
