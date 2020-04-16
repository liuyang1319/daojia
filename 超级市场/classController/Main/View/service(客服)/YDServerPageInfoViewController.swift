//
//  YDServerPageInfoViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDServerPageInfoViewController: YDBasicViewController {
    var iamgeCodel = String()
    var iphoneCell = String()
    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var titleLabel :UILabel = {
        let title = UILabel()
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return title
    }()
    var contentLabel : UILabel = {
        let title = UILabel()
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        title.numberOfLines = 0
        return title
    }()
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    var answerLabel : UILabel = {
        let label = UILabel()
        label.text = "以上回答是否解决您的问题？"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var giveBtn : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(giveSelectButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "give_i_image"), for: UIControl.State.normal)
        button.setTitle("已解决", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "give_B_image"), for: UIControl.State.normal)
        return button
    }()
    var giveNBtn : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(giveNoSelectButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "give_N_image"), for: UIControl.State.normal)
        button.setTitle("未解决", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "give_B_image"), for: UIControl.State.normal)
        return button
    }()
    
    var backView1 : UIView = {
        let back = UIView()
        back.backgroundColor = UIColor.white
        return back
    }()
    var serverBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(telpromptServerButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "list_cell_iamge"), for: UIControl.State.normal)
        return button
    }()
    var weChatBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(weChatServerButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "WeChat_ii_image"), for: UIControl.State.normal)
        return button
    }()
    var titleTimer : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "温馨提示：客服工作时间（9:00-23:00)"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "问题详情"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.view.addSubview(self.backView)
        
        
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.contentLabel)
        self.backView.addSubview(self.lineLabel)
        self.backView.addSubview(self.answerLabel)
        self.backView.addSubview(self.giveBtn)
        self.backView.addSubview(self.giveNBtn)
        
        
        self.view.addSubview(self.backView1)
        self.backView1.frame = CGRect(x: 0, y: LBFMScreenHeight-100, width: LBFMScreenWidth, height: 100)
        
        self.backView1.addSubview(self.serverBtn)
        self.serverBtn.frame = CGRect(x: 15, y: 10, width: 170, height: 35)
        
        self.backView1.addSubview(self.weChatBtn)
        self.weChatBtn.frame = CGRect(x: LBFMScreenWidth-185, y: 10, width: 170, height: 35)
        
        self.backView1.addSubview(self.titleTimer)
        self.titleTimer.frame = CGRect(x: (LBFMScreenWidth-210)*0.5, y: self.serverBtn.frame.maxY+10, width: 210, height: 15)
        
    }
    var serviceHelplistInfo:YDServiceHelplistInfoModel? {
        didSet {
            guard let model = serviceHelplistInfo else {return}
          
            self.titleLabel.text = model.problem
            self.titleLabel.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-60, height: 25)
            
            self.contentLabel.text = model.answer
            self.contentLabel.frame = CGRect(x: 15, y: self.titleLabel.frame.maxY+15, width: LBFMScreenWidth-60, height: heightForView(text: self.contentLabel.text ?? "", font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-60))
            
            self.lineLabel.frame = CGRect(x: 15, y: self.contentLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
            
            self.answerLabel.frame = CGRect(x: (LBFMScreenWidth-160)*0.5, y: self.lineLabel.frame.maxY+15, width: 160, height: 15)
            
            self.giveBtn.frame = CGRect(x: 45, y: self.answerLabel.frame.maxY+15, width: 80, height: 25)
            self.giveNBtn.frame = CGRect(x:LBFMScreenWidth-155, y: self.answerLabel.frame.maxY+15, width: 80, height: 25)
            
            self.backView.frame = CGRect(x: 15, y: LBFMNavBarHeight+15, width: LBFMScreenWidth-30, height: self.giveNBtn.frame.maxY+15)
        }
    }
    var imageCode : String = ""{
        didSet {
            self.iamgeCodel = imageCode
        }
    }
    var iphoneNum : String = ""{
        didSet {
            self.iphoneCell = iphoneNum
        }
    }
//    已解决
    @objc func giveSelectButtonClick(){
        
    }
//    未解决
    @objc func giveNoSelectButtonClick(){
        
    }
    //打电话
    @objc func telpromptServerButtonClick(){
        let phone = "telprompt://" + self.iphoneCell
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.openURL(URL(string: phone)!)
        }
    }
    //    微信聊天
    @objc func weChatServerButtonClick(){
        let weChatVc = YDWeChatCodeViewController()
        weChatVc.imageCode = self.iamgeCodel
        weChatVc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        weChatVc.modalTransitionStyle = .crossDissolve
//        if #available(iOS 13.0, *) {
//            weChatVc.modalPresentationStyle = .fullScreen
//        } else {
//            // Fallback on earlier versions
//        }
        self.present(weChatVc,animated:true,completion:nil)
    }
}
