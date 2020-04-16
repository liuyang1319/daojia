//
//  YDNewUserGiftViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/19.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDNewUserGiftViewController: YDBasicViewController {
    lazy var newImage:UIImageView = {
        let new = UIImageView()
        new.image = UIImage(named:"newGift_bb_image")
        return new
    }()
    
    lazy var getBtn:UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(getUserGiftButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var closeBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"close_ii_image"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(newGiftCloseButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        self.view.addSubview(self.newImage)
        self.view.addSubview(self.getBtn)
       NotificationCenter.default.addObserver(self, selector: #selector(requestGetNewUserGiftView(nofit:)), name: NSNotification.Name(rawValue:"YDNewUserGiftViewController"), object: nil)
        if isIphoneX == true{
            self.newImage.frame = CGRect(x:(LBFMScreenWidth-245)*0.5, y: 230, width: 245, height: 330)
            self.getBtn.frame = CGRect(x:(LBFMScreenWidth-140)*0.5, y: 500, width: 140, height: 45)
        }else{
            self.newImage.frame = CGRect(x:(LBFMScreenWidth-245)*0.5, y: 130, width: 245, height: 330)
            self.getBtn.frame = CGRect(x:(LBFMScreenWidth-140)*0.5, y: 400, width: 140, height: 45)
        }
        
        self.view.addSubview(self.closeBtn)
        self.closeBtn.frame = CGRect(x:(LBFMScreenWidth-30)*0.5, y: self.newImage.frame.maxY+45, width: 30, height: 30)
        
        
    }
//    登录成功的通知
    @objc func requestGetNewUserGiftView(nofit:NSNotification) {
        print("--------------登录成功回调")
        self.dismiss(animated: true, completion: nil)
    }
//    领取礼包
    @objc func getUserGiftButtonClick(){
        let  login = YDUserLoginViewController()
        if #available(iOS 13.0, *) {
            login.modalPresentationStyle = .fullScreen
        } else {
                   // Fallback on earlier versions
        }
        self.present(login, animated: true, completion: nil)
    }
//    关闭
    @objc func newGiftCloseButtonClick(){
        self.dismiss(animated: true, completion: nil)
    }
}
