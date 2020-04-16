//
//  YDHomeSearchBarFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/12.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDHomeSearchBarFooterView: UITableViewHeaderFooterView {

    lazy var iconImage : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "searhGoods_image")
        return icon
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.text = "非常抱歉！没有找到该商品\n 换个词试试吧~"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x:(LBFMScreenWidth-135)*0.5, y: 35, width: 135, height: 130)
        self.backgroundColor = UIColor.white
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:(LBFMScreenWidth-340)*0.5, y:self.iconImage.frame.maxY+30, width: 340, height: 40)
        
    }
    var goodsName : String = ""{
        didSet {
            self.titleLabel.text = String(format: "非常抱歉！没有找到“%@”商品\n 换个词试试吧~",goodsName.unicodeStr)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
