//
//  YDGoodsOneTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDGoodsOneTableViewCell: UITableViewCell {
    var backView:UIView = {
        let view = UIView()
        view.backgroundColor = YMColor(r: 229, g: 238, b: 178, a: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = YMColor(r: 104, g: 148, b: 48, a: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        return label
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
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-30, height: 35)
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 2.5, width: LBFMScreenWidth-60, height: 30)
    }
    var titleName : String = ""{
        didSet {
            self.titleLabel.text = titleName
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
