//
//  YDEditAddersTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDEditAddersTableViewCellDelegate:NSObjectProtocol {
    //    编辑地址
    func editSelectAddersTableViewCell(index:NSInteger)
}
class YDEditAddersTableViewCell: UITableViewCell {

     weak var delegate : YDEditAddersTableViewCellDelegate?

    lazy var addersLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = ""
        label.isHidden = true
        label.backgroundColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        return label
    }()
     var defaultLabel : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "默认"
        label.isHidden = true
        label.backgroundColor = YDLabelColor
        return label
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = ""
        return label
    }()
    lazy var iphoneLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.text = ""
        return label
    }()
    
    lazy var editBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectEditAddersButtonClick(tagButton:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.addersLabel)
        self.addersLabel.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-100, height: 30)

        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.addersLabel.frame.maxX+5, y: 15, width: 30, height: 15)
        
        self.addSubview(self.defaultLabel)
        self.defaultLabel.frame = CGRect(x: self.titleLabel.frame.maxX+5, y: 15, width: 30, height: 15)
        
        self.addSubview(self.editBtn)
        self.editBtn.frame = CGRect(x: LBFMScreenWidth-50, y: 35, width: 30, height: 30)
        
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 15, y: self.addersLabel.frame.maxY+10, width: 120, height: 15)
        self.addSubview(self.iphoneLabel)
        self.iphoneLabel.frame = CGRect(x: self.nameLabel.frame.maxX+20, y: self.addersLabel.frame.maxY+10, width: 100, height: 15)
    }
    
    var categoryContentsModel:YDAddAddersModel? {
        didSet {
            guard let model = categoryContentsModel else {return}
            
            self.addersLabel.text = (model.street as String?)! + (model.doorNumber?.unicodeStr ?? "")
            self.addersLabel.frame = CGRect(x: 15, y: 16, width: LBFMScreenWidth-100, height: heightForView(text: self.addersLabel.text!, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-100))
            
            if (model.type?.isEqual("1"))! {
                self.titleLabel.text = "公司"
                self.titleLabel.isHidden = false
            }else if (model.type?.isEqual("2"))! {
                self.titleLabel.text = "家"
                self.titleLabel.isHidden = false
            }else if (model.type?.isEqual("3"))! {
                self.titleLabel.text = "学校"
                self.titleLabel.isHidden = false
            }
            if model.isDefault == "1" {
                self.defaultLabel.isHidden = false
            }else{
                self.defaultLabel.isHidden = true
            }
            if (model.sex?.isEqual("1"))! {
                self.nameLabel.text = String(format: "%@  先生", model.name?.unicodeStr ?? "")
            }else if (model.sex?.isEqual("2"))!{
                self.nameLabel.text = String(format: "%@  女士", model.name?.unicodeStr ?? "")
            }
            self.iphoneLabel.text = model.phone as String?

        }
    }
//  编辑i地址
    @objc func selectEditAddersButtonClick(tagButton:UIButton){
        delegate?.editSelectAddersTableViewCell(index:tagButton.tag)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
