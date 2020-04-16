//
//  YDRecruitPersonnelTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDRecruitPersonnelTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 0, g: 0, b: 0, a: 1)
        label.text = "配送员"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    
    var iphoneLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "上海门店 | 5800-6000"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()

    var undoneLabel : UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named:"share_BB_image")
        return label
    }()
    
    var lineLabel :UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    func setUpUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 15, width: 45, height: 20)
        
        self.addSubview(self.iphoneLabel)
        self.iphoneLabel.frame = CGRect(x: 15, y: self.titleLabel.frame.maxY+10, width: 300, height: 15)
        
        self.addSubview(self.undoneLabel)
        self.undoneLabel.frame = CGRect(x: LBFMScreenWidth-25, y:30, width: 10, height: 15)
        
        self.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 74, width: LBFMScreenWidth-30, height: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
