//
//  YDLocationAddersTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/25.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

protocol YDLocationAddersTableViewCellDelegate:NSObjectProtocol {
        //    编辑地址
        func editSelectAddersTableViewCell(index:NSInteger)
        //    登录
        func loginSelectAddersTableViewCell()
    }
class YDLocationAddersTableViewCell: UITableViewCell {
        
        weak var delegate : YDLocationAddersTableViewCellDelegate?

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
        lazy var defaultLabel : UILabel = {
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
        lazy var sexLabel : UILabel = {
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
        //
        //    lazy var editBtn : UIButton = {
        //        let button = UIButton()
        //        button.setImage(UIImage(named: "editImage"), for: UIControl.State.normal)
        //        button.addTarget(self, action: #selector(selectEditAddersButtonClick(tagButton:)), for: UIControl.Event.touchUpInside)
        //        return button
        //    }()
        //
        //
        lazy var lgoinBtn : UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "login_btn"), for: UIControl.State.normal)
            button.addTarget(self, action: #selector(selectLgoinAddersButtonClick), for: UIControl.Event.touchUpInside)
            return button
        }()
        lazy var hintTitle : UILabel = {
            let label = UILabel()
            label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            return label
        }()
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
            setUpLayout()
        }
        func setUpLayout(){
            
            
            if isUserLogin() != true{
                self.addSubview(self.addersLabel)
                self.addersLabel.frame = CGRect(x: 15, y: 30, width: LBFMScreenWidth-100, height: 30)
                
                self.addSubview(self.titleLabel)
                self.titleLabel.frame = CGRect(x: self.addersLabel.frame.maxX+5, y: 15, width: 30, height: 15)
                
                self.addSubview(self.defaultLabel)
                self.defaultLabel.frame = CGRect(x: self.titleLabel.frame.maxX+5, y: 15, width: 30, height: 15)

                
                self.addSubview(self.nameLabel)
                self.addSubview(self.sexLabel)
                self.addSubview(self.iphoneLabel)
                
                
            }else{
                self.addSubview(self.hintTitle)
                self.hintTitle.text = "登录后使用常用地址"
                self.hintTitle.frame = CGRect(x: 15, y: 40, width: 130, height: 20)
                self.addSubview(self.lgoinBtn)
                self.lgoinBtn.frame = CGRect(x: LBFMScreenWidth-100, y: 30, width: 80, height: 30)
            }
        }
        
        var categoryContentsModel:YDAddAddersModel? {
            didSet {
                guard let model = categoryContentsModel else {return}
                
                self.addersLabel.text =  String(format: "%@%@", model.addressRegion ?? "",model.street ?? "").unicodeStr
                
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
                if (model.isDefault?.isEqual("1"))! {
                    self.defaultLabel.isHidden = false
                }
                self.nameLabel.text = String(format:"%@", model.name?.unicodeStr ?? "")
                self.nameLabel.frame = CGRect(x: 15, y: 65, width:widthForView(text: self.nameLabel.text ?? "", font: UIFont.systemFont(ofSize: 11), height: 15), height: 15)
                
                if (model.sex?.isEqual("1"))! {
                    self.sexLabel.text = String(format:"男士")
                }else if (model.sex?.isEqual("2"))!{
                    self.sexLabel.text = String(format:"女士")
                }
                self.sexLabel.frame = CGRect(x: self.nameLabel.frame.maxX + 15, y: 65, width:widthForView(text: self.sexLabel.text ?? "", font: UIFont.systemFont(ofSize: 11), height: 15), height: 15)
                
                self.iphoneLabel.text = model.phone as String?
                
                self.iphoneLabel.frame = CGRect(x: self.sexLabel.frame.maxX+15, y: 65, width: 100, height: 15)
                
            }
        }
        @objc func selectLgoinAddersButtonClick(){
            delegate?.loginSelectAddersTableViewCell()
        }
        //  编辑i地址
        @objc func selectEditAddersButtonClick(tagButton:UIButton){
            delegate?.editSelectAddersTableViewCell(index:tagButton.tag)
        }
        
        
}
