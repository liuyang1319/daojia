//
//  YDInvitationFriendTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDInvitationFriendTableViewCell: UITableViewCell {
    
    var iconImage : UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 20
        icon.clipsToBounds = true
        return icon
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var iphoneLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "158****8888"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    var timerLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = "2019-10-10"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var invitaLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = "受邀"
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    
    var undoneLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "尚未下单"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    func setUpUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 40, height: 40)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 15, width: 250, height: 15)
        
        self.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: LBFMScreenWidth-110, y: 15, width: 70, height: 15)
        
        self.addSubview(self.invitaLabel)
        self.invitaLabel.frame = CGRect(x: self.timerLabel.frame.maxX+5, y: 17, width: 25, height: 15)
        
        self.addSubview(self.iphoneLabel)
        self.iphoneLabel.frame = CGRect(x:  self.iconImage.frame.maxX+10, y: self.titleLabel.frame.maxY+10, width: 200, height: 15)
        
        self.addSubview(self.undoneLabel)
        self.undoneLabel.frame = CGRect(x: LBFMScreenWidth-65, y: self.titleLabel.frame.maxY+10, width: 50, height: 15)
    }
    var invitePresentModel:YDInviteLoglistInfoModel? {
        didSet {
            guard let model = invitePresentModel else {return}
            self.iconImage.kf.setImage(with:URL(string:model.headImg ?? ""), placeholder:UIImage(named: "headerImage"))
            self.titleLabel.text = model.name ?? ""
            let sub1 = model.inviteTime?.prefix(10)
            self.timerLabel.text = String(format:"%@",sub1 as CVarArg? ?? "")
            let iphone1 = model.phone?.prefix(3)
            let iphone2 = model.phone?.suffix(4)
            self.iphoneLabel.text = String(format:"%@****%@",iphone1 as CVarArg? ?? "",iphone2 as CVarArg? ?? "")
            
            if model.status == "0" {
                self.undoneLabel.text = "尚未下单"
            }else if model.status == "1"{
                 self.undoneLabel.text = "已经下单"
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
