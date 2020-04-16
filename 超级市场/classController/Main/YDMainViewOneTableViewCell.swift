//
//  YDMainViewOneTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/24.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDMainViewOneTableViewCellDelegate:NSObjectProtocol {
    func goSelectInviteFriendTableViewCell()
}
class YDMainViewOneTableViewCell: UITableViewCell {
    weak var delegate : YDMainViewOneTableViewCellDelegate?
    lazy var orderView : UIView = {
        let  menuView =  UIView()
        menuView.backgroundColor = UIColor.white
        menuView.layer.cornerRadius = 5
        menuView.clipsToBounds = true
        return menuView
    }()
    
    var iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"")
        return imageView
    }()
    
    lazy var orderName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r:43, g:43, b:43, a: 1)
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    var arrowsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowsImage")
        return imageView
    }()
    
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    var inviteBtn : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.5, weight: UIFont.Weight.regular)
        button.setBackgroundImage(UIImage(named:"orange_back_image"), for: UIControl.State.normal)
        button.setTitle("前去邀请 >", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goSelectInviteFriendView), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.orderView)
        self.orderView.frame = CGRect(x: 15, y:15, width: LBFMScreenWidth-30, height: 45)
        
        self.orderView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 15, height: 15)
        
        self.orderView.addSubview(self.orderName)
        self.orderName.frame = CGRect(x:self.iconImage.frame.maxX + 10, y: 15, width: 200, height: 15)
        
        self.orderView.addSubview(self.inviteBtn)
        self.inviteBtn.frame = CGRect(x: LBFMScreenWidth-125, y: 12.5, width:80, height: 20)
        
        self.orderView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 44.5, width: LBFMScreenWidth-60, height: 0.5)
    }
    var titleName : String = ""{
        didSet {
            self.orderName.text = titleName
        }
    }
    var titleImage : String = ""{
        didSet {
            self.iconImage.image = UIImage(named:titleImage)
        }
    }
//    邀请好友
    @objc func goSelectInviteFriendView(){
        delegate?.goSelectInviteFriendTableViewCell()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
