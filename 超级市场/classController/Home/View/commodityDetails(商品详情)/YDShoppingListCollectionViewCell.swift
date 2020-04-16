//
//  YDShoppingListCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/2.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDShoppingListCollectionViewCell: UICollectionViewCell {
    private lazy var backView : UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    private lazy var linLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var lin1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var lin2Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var lin3Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var lin4Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return label
    }()
    private lazy var titlelabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()

    var goodSpecsModel:YDHomeGoodSpecsInfo? {
        didSet{
            guard let model = goodSpecsModel else { return }
            self.nameLabel.text = String(format: "%@", model.name ?? "")
            self.nameLabel.frame = CGRect(x: self.lin1Label.frame.maxX+15, y: self.linLabel.frame.maxY+10, width: 105, height: 20)
            self.titlelabel.text = String(format: "%@", model.aname ?? "")
            self.titlelabel.frame = CGRect(x: self.lin2Label.frame.maxX+15, y: self.linLabel.frame.maxY+10, width: LBFMScreenWidth-210, height: 20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth , height: 40)

        self.backView.addSubview(self.linLabel)
        self.linLabel.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 0.5)
        
        self.backView.addSubview(self.lin1Label)
        self.lin1Label.frame = CGRect(x: 15, y: 1, width:1, height: 38)
        
        self.backView.addSubview(self.nameLabel)
    
        
        self.backView.addSubview(self.lin2Label)
        self.lin2Label.frame = CGRect(x: 150, y: 1, width:1, height: 38)
        
        
        self.backView.addSubview(self.titlelabel)

        
        self.backView.addSubview(self.lin3Label)
        self.lin3Label.frame = CGRect(x:LBFMScreenWidth-15, y: 1, width: 1, height: 38)
        
        self.backView.addSubview(self.lin4Label)
        self.lin4Label.frame = CGRect(x:15, y: 39.5, width: LBFMScreenWidth-30, height: 0.5)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
