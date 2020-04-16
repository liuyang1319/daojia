//
//  YDMainViewTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/24.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDMainViewTableViewCell: UITableViewCell {
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
    
    var numberButton:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setBackgroundImage(UIImage(named: "number_i_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        return button
    }()
    
    var integralLabel : UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 253, g: 167, b: 22, a: 1)
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
        self.orderView.frame = CGRect(x: 15, y:0, width: LBFMScreenWidth-30, height: 45)

        self.orderView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 15, height: 15)
        
        self.orderView.addSubview(self.orderName)
        self.orderName.frame = CGRect(x:self.iconImage.frame.maxX + 10, y: 15, width: 200, height: 15)
        
        self.orderView.addSubview(self.numberButton)
        self.numberButton.frame = CGRect(x: LBFMScreenWidth-85, y: 15, width: 20, height: 15)
        
        self.orderView.addSubview(self.integralLabel)
        self.integralLabel.frame = CGRect(x: LBFMScreenWidth-200, y: 15, width: 137, height: 15)
        
        self.orderView.addSubview(self.arrowsImage)
        self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-53, y: 17, width: 8, height: 12.5)

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
    var number : Int  = 0 {
        didSet {
            if number != 0 {
                if isUserLogin() != true{
                    self.numberButton.isHidden = false
                    self.numberButton.setTitle(String(number), for: UIControl.State.normal)
                }
            }
        }
    }
    var integral : String = "" {
        didSet {
            if integral != "" {
                if isUserLogin() != true{
                    self.integralLabel.isHidden = false
                    self.integralLabel.text = "\(integral)积分"
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
}
