//
//  YDShopCartHeaderReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDShopCartHeaderReusableViewDelegate:NSObjectProtocol {
    //    选择地址
    func selectAddersListHeaderView()
}
class YDShopCartHeaderReusableView: UICollectionReusableView {
    weak var delegate : YDShopCartHeaderReusableViewDelegate?
    lazy var greenLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var adderImage : UIImageView = {
        let addIamge = UIImageView()
        addIamge.image = UIImage(named: "selectAddersImage")
        return addIamge
    }()
    
    lazy var addersLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var sexLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var arrowsImage : UIImageView = {
        let arrows = UIImageView()
        arrows.image = UIImage(named: "popImage")
        return arrows
    }()
    lazy var addersButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectAddersListButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpudeatAddersValue(nofit:)), name: NSNotification.Name(rawValue:updeatAdders), object: nil)
        backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
         NotificationCenter.default.addObserver(self, selector: #selector(noficationLocationAddersViewControllerAdders(nofit:)), name: NSNotification.Name(rawValue:"YDLocationAddersViewControllerAdders"), object: nil)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func noficationLocationAddersViewControllerAdders(nofit:Notification) {
          self.nameLabel.isHidden = true
          self.sexLabel.isHidden = true
          self.phoneLabel.isHidden = true
          self.addSubview(self.greenLabel)
          self.greenLabel.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 30)
          self.addSubview(self.backView)
          self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)

          self.backView.addSubview(self.adderImage)
          self.adderImage.frame = CGRect(x: 20, y: 20, width: 20, height: 20)

          self.backView.addSubview(self.addersLabel)
          self.addersLabel.text = UserDefaults.AccountInfo.string(forKey: .addersName) ?? ""
          self.addersLabel.frame = CGRect(x: self.adderImage.frame.maxX+20, y: 20, width: LBFMScreenWidth-125, height: 20)

          self.backView.addSubview(self.arrowsImage)
          self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-55, y: 25, width: 10, height: 15)

          self.backView.addSubview(self.addersButton)
          self.addersButton.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)
    }
    @objc func notificationUpudeatAddersValue(nofit:Notification) {
        setUpLayout()
    }
    func setUpLayout()  {
        
        let userDefault = UserDefaults.standard
        let adders = userDefault.dictionary(forKey: "AddersDictionary") ?? nil
        if adders?.isEmpty ?? true {
            self.nameLabel.isHidden = true
            self.sexLabel.isHidden = true
            self.phoneLabel.isHidden = true
            self.addSubview(self.greenLabel)
            self.greenLabel.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 30)
            self.addSubview(self.backView)
            self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)
            
            self.backView.addSubview(self.adderImage)
            self.adderImage.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
            
            self.backView.addSubview(self.addersLabel)
            self.addersLabel.text = UserDefaults.AccountInfo.string(forKey: .addersName) ?? ""
            self.addersLabel.frame = CGRect(x: self.adderImage.frame.maxX+20, y: 20, width: LBFMScreenWidth-125, height: 20)
            
            self.backView.addSubview(self.arrowsImage)
            self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-55, y: 25, width: 10, height: 15)
            
            self.backView.addSubview(self.addersButton)
            self.addersButton.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)
        } else {
            self.nameLabel.isHidden = false
            self.sexLabel.isHidden = false
            self.phoneLabel.isHidden = false
            self.addSubview(self.greenLabel)
            self.greenLabel.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 30)
            self.addSubview(self.backView)
            self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)
            
            self.backView.addSubview(self.adderImage)
            self.adderImage.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
            
            self.backView.addSubview(self.addersLabel)
            self.addersLabel.text = String(format:"%@%@",adders!["addressRegion"] as! String ,adders!["street"] as! String).unicodeStr
            self.addersLabel.frame = CGRect(x: self.adderImage.frame.maxX+20, y:10, width: LBFMScreenWidth-125, height:20)
            
            self.backView.addSubview(self.nameLabel)
            self.nameLabel.text = (adders!["name"] as? String)?.unicodeStr
            self.nameLabel.frame = CGRect(x: self.adderImage.frame.maxX+20, y: self.addersLabel.frame.maxY+5, width: widthForView(text: self.nameLabel.text ?? "", font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium), height: 20), height: 20)
            
            self.backView.addSubview(self.sexLabel)
            self.sexLabel.frame = CGRect(x: self.nameLabel.frame.maxX+10, y: self.addersLabel.frame.maxY+5, width: 30, height: 20)
            var sex = String()
            sex = adders!["sex"] as! String
            if sex == "1"{
                self.sexLabel.text = "男士"
            }else if sex == "2"{
                self.sexLabel.text = "女士"
            }
            self.backView.addSubview(self.phoneLabel)
            self.phoneLabel.text = adders!["addressPhone"] as? String
            self.phoneLabel.frame = CGRect(x: self.sexLabel.frame.maxX+10, y: self.addersLabel.frame.maxY+5, width: 100, height: 20)
            
            self.backView.addSubview(self.arrowsImage)
            self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-55, y:25, width: 10, height: 15)
            
            self.backView.addSubview(self.addersButton)
            self.addersButton.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 60)
        }
        
       
        
    }
//    选择地址
    @objc func selectAddersListButtonClick(){
        delegate?.selectAddersListHeaderView()
    }
    
}
