//
//  YDUserInfoTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol YDUserInfoTableViewCellDelegate:NSObjectProtocol {
    func userphoneUpdateClick()
}
class YDUserInfoTableViewCell: UITableViewCell {
    
    weak var delegate : YDUserInfoTableViewCellDelegate?
    lazy var backView:UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    // 头像
    lazy var picView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 头像
    lazy var boultView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowsImage")
        return imageView
    }()
    // 昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    lazy var iamgeBtn:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectUserImageUpudet), for: UIControl.Event.touchUpInside)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){

        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 10, width: LBFMScreenWidth, height: 65)
        
        // 头像
        self.backView.addSubview(self.picView)
        self.picView.image = UIImage(named: "headerImage")
        self.picView.layer.masksToBounds = true
        self.picView.layer.cornerRadius = 23
        self.picView.frame = CGRect(x: LBFMScreenWidth-80, y: 5, width: 46, height: 46)
        
        self.backView.addSubview(self.boultView)
        self.boultView.frame = CGRect(x: LBFMScreenWidth-25, y: 20, width: 10, height: 15)
        
        self.backView.addSubview(self.nameLabel)
        self.nameLabel.text = "头像"
        self.nameLabel.frame = CGRect(x: 15, y: 23, width: 30, height: 20)
        
        self.backView.addSubview(self.iamgeBtn)
        self.iamgeBtn.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 65)
        
    }
    var imageName : String = ""{
        didSet {
            self.picView.kf.setImage(with: URL(string:imageName), placeholder:UIImage(named:"headerImage"))
        }
    }
    @objc func selectUserImageUpudet(){
         delegate?.userphoneUpdateClick()
    }
}
