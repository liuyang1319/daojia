//
//  YDMainHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol YDMainHeaderViewDelegate:NSObjectProtocol {
//    用户资料
    func userDataHeaderBannerClickHeaderView()
//    全部订单
    func allOrderListHeaderView()
//    待支付订单
    func awaitPayOrderButtonClickHeaderView()
//    待收货订单
    func awaitTakeOrderButtonClickHeaderView()
//    待评论订单
    func awaitCommentOrderButtonClickHeaderView()
//    登录注册
    func userLoginRegisterButtonClickHeaderView()
}
class YDMainHeaderView: UITableViewHeaderFooterView {
    weak var delegate : YDMainHeaderViewDelegate?
//    订单号
    var orderNumber = String()
    lazy var backImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "headerBack")
        return imageView
    }()
    
    var loginBtn : UIButton = {
        let button = UIButton()
        button.setTitle("登录/注册", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(userLoginButtonClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.backgroundColor = YMColor(r: 145, g: 213, b: 127, a: 1)
        return button
    }()
    
    
    // 昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var iconImage : UIImageView = {
        let button = UIImageView()
        button.layer.cornerRadius = 30
        button.image = UIImage(named: "headerImage")
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var iconButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(userBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var menuView : UIView = {
        let  menuView =  UIView()
        menuView.backgroundColor = UIColor.white
        menuView.layer.cornerRadius = 5
        menuView.clipsToBounds = true
        return menuView
    }()
    
    var orderButton : UIButton = {
        let button = UIButton()
        button.setTitle("待付款", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(awaitPayButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.setImage(UIImage(named:"pay_icon_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 12.5, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left:-25, bottom: -20, right:0)
        return button
    }()
    
    var takeButton : UIButton = {
        let button = UIButton()
        button.setTitle("待收货", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(awaitTakeButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.setImage(UIImage(named:"harvest_icon_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 12.5, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left:-25, bottom: -20, right:0)
        return button
    }()
    
    var commentButton : UIButton = {
        let button = UIButton()
        button.setTitle("待评价", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(awaitCommentButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.setImage(UIImage(named:"comment_icon_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 12.5, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left:-25, bottom: -20, right:0)
        return button
    }()
    
    var allButton : UIButton = {
        let button = UIButton()
        button.setTitle("全部订单", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(allOrderListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.setImage(UIImage(named:"all_icon_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 12.5, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left:-25, bottom: -20, right:0)
        return button
    }()
    
    
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
//        退出刷新
         NotificationCenter.default.addObserver(self, selector: #selector(notificationUpudeaRefresh(nofit:)), name: NSNotification.Name(rawValue:"refreshMain"), object: nil)
//        登录刷新
        NotificationCenter.default.addObserver(self, selector: #selector(notificationLoginRefresh(nofit:)), name: NSNotification.Name(rawValue:"refreshLoginMain"), object: nil)
        
        //        退出刷新
        NotificationCenter.default.addObserver(self, selector: #selector(mainHeaderViewImageNameUpudeImageName(nofit:)), name: NSNotification.Name(rawValue:"YDMainHeaderViewImageName"), object: nil)
        
        
        
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backImage)
        if isIphoneX == true{
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 200)
        }else{
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 180)
        }
        
        
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y:LBFMNavBarHeight+5, width: 60, height: 60)
        
        self.addSubview(self.loginBtn)
        self.loginBtn.frame = CGRect(x: self.iconImage.frame.maxX+15, y: LBFMNavBarHeight+22, width: 110, height: 28)
        
        
        
        self.addSubview(self.iconButton)
        self.iconButton.frame = CGRect(x: 15, y:LBFMNavBarHeight+5, width: 60, height: 60)
        
        self.addSubview(self.menuView)
        self.menuView.frame = CGRect(x: 15, y: self.iconImage.frame.maxY+17.5, width: LBFMScreenWidth-30, height: 75)

        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconButton.frame.maxX+10, y:LBFMNavBarHeight+22, width: LBFMScreenWidth-110, height: 25)
        
        self.menuView.addSubview(self.orderButton)
        self.orderButton.frame = CGRect(x: (LBFMScreenWidth-230)*0.2, y: 15, width: 50, height:45)
        
        self.menuView.addSubview(self.takeButton)
        self.takeButton.frame = CGRect(x: 2*((LBFMScreenWidth-230)*0.2)+50, y: 15, width: 50, height:45)
        
        self.menuView.addSubview(self.commentButton)
        self.commentButton.frame = CGRect(x: 3*((LBFMScreenWidth-230)*0.2)+100, y: 15, width: 50, height:45)
        
        
        self.menuView.addSubview(self.allButton)
        self.allButton.frame = CGRect(x: 4*((LBFMScreenWidth-230)*0.2)+150, y: 15, width: 50, height:45)

        if isUserLogin() != true{
            self.loginBtn.isHidden = true
            self.nameLabel.isHidden = false
        }else{
           self.nameLabel.isHidden = true
            self.loginBtn.isHidden = false
        }
  
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    登录刷新
    @objc func notificationLoginRefresh(nofit:Notification) {
        self.loginBtn.isHidden = true
    
    }
    //    退出刷新
    @objc func notificationUpudeaRefresh(nofit:Notification) {
        self.nameLabel.text = ""
        self.nameLabel.isHidden = true
        self.loginBtn.isHidden = false
        self.iconImage.image = UIImage(named:"headerImage")
      
    }
    
    @objc func mainHeaderViewImageNameUpudeImageName(nofit:Notification){
        self.nameLabel.isHidden = false
        self.iconImage.kf.setImage(with:URL(string:(nofit.userInfo!["headerImage"] as? String) ?? ""),placeholder: UIImage(named:"headerImage"))
        self.nameLabel.text =  (nofit.userInfo!["name"] as? String)?.unicodeStr ?? ""
    }


//    个人中心
    @objc func userBarButtonClick(){
        delegate?.userDataHeaderBannerClickHeaderView()
    }
//    全部订单
    @objc func allOrderListButtonClick(){
        delegate?.allOrderListHeaderView()
    }
//    等待付款
    @objc func awaitPayButtonClick(){
        delegate?.awaitPayOrderButtonClickHeaderView()
    }
//    等待收货
    @objc func awaitTakeButtonClick(){
        delegate?.awaitTakeOrderButtonClickHeaderView()
    }
//    等待评论
    @objc func awaitCommentButtonClick(){
        delegate?.awaitCommentOrderButtonClickHeaderView()
    }
//    登录注册
    @objc func userLoginButtonClick(){
        delegate?.userLoginRegisterButtonClickHeaderView()
    }
}
