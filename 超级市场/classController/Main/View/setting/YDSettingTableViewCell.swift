//
//  YDSettingTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSettingTableViewCell: UITableViewCell {
     lazy var stateLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.text  = ""
        return title
    }()
    lazy var cartImage : UIImageView = {
        let cartIamge = UIImageView()
        return cartIamge
    }()
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
       
        self.stateLabel.frame = CGRect(x: 15, y: 20, width: 200, height: 20)
        self.addSubview(self.stateLabel)
        
        self.cartImage.frame = CGRect(x: LBFMScreenWidth-45, y: 15, width: 30, height: 30)
        self.addSubview(self.cartImage)
        
        
        self.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 59, width: LBFMScreenWidth-15, height: 1)
    }
}
