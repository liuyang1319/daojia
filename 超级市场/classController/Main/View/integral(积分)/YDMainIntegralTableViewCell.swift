//
//  YDMainIntegralTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/10.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDMainIntegralTableViewCell: UITableViewCell {
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    private lazy var integralLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 231, g: 55, b: 43, a: 1)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var timerLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 30, y: 15, width: 110, height: 20)
        
        self.addSubview(self.integralLabel)
        self.integralLabel.frame = CGRect(x: LBFMScreenWidth-130, y: 25, width: 100, height: 20)
        
        self.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: 30, y: self.integralLabel.frame.maxY, width: 140, height: 20)
    
    }
    var integralListModel:YDIntegralGoodsModel? {
        didSet {
            guard let model = integralListModel else {return}
            
            if model.status == "1" {
                self.titleLabel.text = String(format: "成功消费 +%@ 元", model.score ?? "0")
                self.integralLabel.text = String(format: "+%@",model.score ?? "" )
            }else if model.status == "2" {
                self.titleLabel.text =  String(format: "成功使用积分 +%@ 元", model.score ?? "0")
                self.integralLabel.textColor = YDLabelColor
                self.integralLabel.text = String(format: "-%@",model.score ?? "" )
            }
            
            
            
            
            
            self.timerLabel.text = model.creatTime

        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
