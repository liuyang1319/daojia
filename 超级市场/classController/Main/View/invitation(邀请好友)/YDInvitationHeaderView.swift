//
//  YDInvitationHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import JXMarqueeView
protocol YDInvitationHeaderViewDelegate:NSObjectProtocol {
//    邀请好友
    func selectInvitationFriendHeaderView()
//    分享朋友圈
    func selectInvitationCircleFriendHeaderView()
//  扫码邀请
    func selectInvitationFriendCodeHeaderView()
}
class YDInvitationHeaderView: UIView {
    var marqueeType: JXMarqueeType?
    private let marqueeView = JXMarqueeView()
    weak var delegate : YDInvitationHeaderViewDelegate?
    var backImage : UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named:"invitation_B_image")
        return backImage
    }()

    var activityImage: UIImageView = {
        let activity = UIImageView()
        activity.image = UIImage(named: "activity_i_iamge")
        return activity
    }()

    var activitTitle :UILabel = {
        let label = UILabel()
        label.text = "曹***小邀请李璐璐大胖子下单,获得邀请有礼50减10抵用劵  曹***小邀请李璐璐大胖子下单,获得邀请有礼50减10抵用劵"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)

        return label
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "邀好友 得红包"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 94, g: 25, b: 23, a: 1)
        return label
    }()
    var prickLabel:UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 240, g: 48, b: 59, a: 1)
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.semibold)
        return label
    }()
    var typeLabel:UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 149, g: 81, b: 51, a: 1)
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.semibold)
        return label
    }()
    
    var stepImage :UIImageView = {
        let step = UIImageView()
        step.image = UIImage(named:"invite_I_image")
        return step
    }()
    var weChatBtn :UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "wecha_back_iamge"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectInvitationFriend), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "weat_i_iamge"), for: UIControl.State.normal)
        button.setTitle("立即邀请好友", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return button
    }()
    
    
    var shareBtn :UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share_i_iamge"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectInvitationCircleFriend), for: UIControl.Event.touchUpInside)
        button.setTitle("分享到朋友圈", for: UIControl.State.normal)
        button.imageEdgeInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right:10)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return button
    }()
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    var inviteBtn :UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "code_code_iamge"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectInvitationFriendCode), for: UIControl.Event.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right:10)
        button.setTitle("面对面邀请", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return button
    }()
    var lineLabel1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        marqueeView.contentView = self.activitTitle
        marqueeView.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.5)
        marqueeView.contentMargin = 50
        marqueeView.marqueeType = .left
        setUpUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        marqueeView.bounds = CGRect(x:0, y:0, width: LBFMScreenWidth, height: 25)
        marqueeView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 25)
//        marqueeView.center = self.center
    }
    func setUpUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 355)
        
        self.addSubview(marqueeView)
//        self.addSubview(self.activitTitle)
//        self.activitTitle.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 25)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: (LBFMScreenWidth-85)*0.5, y: 64, width: 85, height: 15)
        
        self.addSubview(self.activityImage)
        self.activityImage.frame = CGRect(x: LBFMScreenWidth-70, y: 50, width: 70, height: 25)
        
        self.addSubview(self.stepImage)
        self.stepImage.frame = CGRect(x: 0, y: 330, width: LBFMScreenWidth, height: 25)
        
        self.addSubview(self.prickLabel)
        self.prickLabel.frame = CGRect(x: 0, y:75, width: LBFMScreenWidth, height: 50)
        
        self.addSubview(self.typeLabel)
        self.typeLabel.frame = CGRect(x: 0, y: self.prickLabel.frame.maxY, width: LBFMScreenWidth, height: 30)
        
        self.addSubview(self.weChatBtn)
        self.weChatBtn.frame = CGRect(x:65, y: self.backImage.frame .maxY+15, width: LBFMScreenWidth-130, height: 45)
        
        
        
        self.addSubview(self.shareBtn)
        self.shareBtn.frame = CGRect(x: 60, y: self.weChatBtn.frame.maxY+10, width:( LBFMScreenWidth-120)*0.5, height: 30)
        
        self.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: self.shareBtn.frame.maxX, y:  self.weChatBtn.frame.maxY+15, width: 1, height: 20)
        
        
        
        self.addSubview(self.inviteBtn)
        self.inviteBtn.frame = CGRect(x: self.lineLabel.frame.maxX , y: self.weChatBtn.frame.maxY+10, width:( LBFMScreenWidth-120)*0.5, height: 30)
        
        
        self.addSubview(self.lineLabel1)
        self.lineLabel1.frame = CGRect(x: 0, y: self.shareBtn.frame.maxY+5, width: LBFMScreenWidth, height: 10)
    }
    var invitePresentModel:YDInvitePresentInfoModel? {
        didSet {
            guard let model = invitePresentModel else {return}
            self.backImage.kf.setImage(with:URL(string:model.uiUrl ?? ""))
            if model.type == "1"{
                self.prickLabel.text = String(format: "满%.0f减%.0f",model.minOrderPrice ?? 0,model.price ?? 0)
                self.typeLabel.text = "满减券"
            }else if model.type == "2"{
                self.prickLabel.text = String(format: "满%.0f减%.0f",model.minOrderPrice ?? 0,model.price ?? 0)
                self.typeLabel.text = "代金券"
            }else if model.type == "3"{
                self.prickLabel.text = String(format: "满%.0f减%.0f",model.minOrderPrice ?? 0,model.price ?? 0)
                self.typeLabel.text = "免邮券"
            }
            
        }
    }
//    邀请好友
    @objc func selectInvitationFriend(){
        delegate?.selectInvitationFriendHeaderView()
    }
//    分享朋友圈
    @objc func selectInvitationCircleFriend(){
        delegate?.selectInvitationCircleFriendHeaderView()
    }
//    扫码邀请
    @objc func selectInvitationFriendCode(){
        delegate?.selectInvitationFriendCodeHeaderView()
    }
}
