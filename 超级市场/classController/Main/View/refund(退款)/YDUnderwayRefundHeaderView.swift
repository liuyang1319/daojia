//
//  YDUnderwayRefundHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUnderwayRefundHeaderView: UITableViewHeaderFooterView {
    
    var hearView : UIView = {
        let view = UIView()
        view.backgroundColor = YMColor(r: 88, g: 202, b: 54, a: 1)
        return view
    }()
    
    var timerImage : UIImageView = {
        let timer = UIImageView()
        timer.image = UIImage(named: "audit_image")
        return timer
    }()

    var titleLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = UIColor.white
        return label
    }()
    var timerLabel:UILabel = {
        let label = UILabel()
        label.text = "预计1-3个工作日到账"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = UIColor.white
        return label
    }()
    
    var prickView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var prickLabel:UILabel = {
        let label = UILabel()
        label.text = "退款总金额"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    
    var prick:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        return label
    }()
    
    var prickTitle:UILabel = {
        let label = UILabel()
        label.text = "按实付金额计算，原路退回"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return label
    }()
    
    var typeView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var refundTitle:UILabel = {
        let label = UILabel()
        label.text = "退款流程"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    
    var numberImage:UIImageView = {
        let number = UIImageView()
        number.image = UIImage(named:"selectGoodsImage")
        return number
    }()
    var timerSub:UILabel = {
        let label = UILabel()
        label.text = "提交退款申请"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var timerDate:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    var lineLabel1:UILabel = {
        let label = UILabel()
        label.backgroundColor  = YMColor(r: 88, g: 202, b: 54, a: 1)
        return label
    }()
    
    var numberImage1:UIImageView = {
        let number = UIImageView()
        number.image = UIImage(named:"null_image_i")
        return number
    }()
    var timerSub1:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "退款申请已通过"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var timerDate1:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    var lineLabel2:UILabel = {
        let label = UILabel()
        label.backgroundColor  = YMColor(r: 88, g: 202, b: 54, a: 1)
        return label
    }()
    
    
    var numberImage2:UIImageView = {
        let number = UIImageView()
        number.image = UIImage(named:"null_image_i")
        return number
    }()
    var timerSub2:UILabel = {
        let label = UILabel()
        label.text = "退款成功"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    
    var timerDate2:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    
    var lineLabel3:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.backgroundColor  = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    
    var closeBtn:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("取消申请", for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return button
    }()
    
    
    var messageView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var messagelabel:UILabel = {
        let label = UILabel()
        label.text = "退款信息"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var lineLabel4:UILabel = {
        let label = UILabel()
        label.backgroundColor  = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.hearView)
        self.hearView.frame = CGRect(x: 0, y: 0, width:LBFMScreenWidth , height: 95)
        
        self.hearView.addSubview(self.timerImage)
        self.timerImage.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        
        
        self.hearView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.timerImage.frame.maxX+15, y: 15, width: 160, height: 25)
        
        self.hearView.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: 15, y: self.timerImage.frame.maxY+5, width: LBFMScreenWidth-30, height: 15)
        
        self.hearView.addSubview(self.prickView)
        self.prickView.frame = CGRect(x: 15, y: self.timerLabel.frame.maxY+10, width: LBFMScreenWidth-30, height: 65)
        
        self.prickView.addSubview(self.prickLabel)
        self.prickLabel.frame = CGRect(x: 15, y: 24, width: 75, height: 20)
        
        
        self.prickView.addSubview(self.prick)
        self.prick.frame = CGRect(x: LBFMScreenWidth-215, y: 15, width: 170, height: 20)
        
        self.prickView.addSubview(self.prickTitle)
        self.prickTitle.frame = CGRect(x: LBFMScreenWidth-215, y: self.prick.frame.maxY+2, width: 170, height: 15)
        
        
        
        self.addSubview(self.typeView)
        self.typeView.frame = CGRect(x: 15, y: self.prickView.frame.maxY+15, width: LBFMScreenWidth-30, height: 150)
        
        self.typeView.addSubview(self.refundTitle)
        self.refundTitle.frame = CGRect(x: 15, y: 15, width: 60, height: 20)
        
        self.typeView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.refundTitle.frame.maxY+15, width: LBFMScreenWidth-60, height: 0.5)
        
        
        self.typeView.addSubview(self.numberImage)
        self.numberImage.frame = CGRect(x: 60, y:self.lineLabel.frame.maxY+25, width: 15, height: 15)
        
        self.typeView.addSubview(self.timerSub)
        self.timerSub.frame = CGRect(x: 25, y: self.numberImage.frame.maxY+5, width: 90, height: 15)
        
        self.typeView.addSubview(self.timerDate)
        self.timerDate.frame = CGRect(x: 25, y: self.timerSub.frame.maxY, width: 90, height: 15)
        
        self.typeView.addSubview(self.lineLabel1)
        self.lineLabel1.frame = CGRect(x: self.numberImage.frame.maxX, y:self.lineLabel.frame.maxY+32, width:(LBFMScreenWidth-195)*0.5, height: 1)
        
        self.typeView.addSubview(self.numberImage1)
        self.numberImage1.frame = CGRect(x: self.lineLabel1.frame.maxX, y: self.lineLabel.frame.maxY+25, width: 15, height: 15)
        
        
        self.typeView.addSubview(self.timerSub1)
        self.timerSub1.frame = CGRect(x: self.timerDate.frame.maxX+5+(LBFMScreenWidth-360)*0.5, y: self.numberImage1.frame.maxY+5, width: 90, height: 15)
        
        
        self.typeView.addSubview(self.timerDate1)
        self.timerDate1.frame = CGRect(x:self.timerDate.frame.maxX+5+(LBFMScreenWidth-360)*0.5, y: self.timerSub1.frame.maxY, width: 90, height: 15)
        
        
        self.typeView.addSubview(self.lineLabel2)
        self.lineLabel2.frame = CGRect(x: self.numberImage1.frame.maxX, y: self.lineLabel.frame.maxY+32, width: (LBFMScreenWidth-195)*0.5, height: 1)
        
        
        self.typeView.addSubview(self.numberImage2)
        self.numberImage2.frame = CGRect(x: self.lineLabel2.frame.maxX, y: self.lineLabel.frame.maxY+25, width: 15, height: 15)
        
        self.typeView.addSubview(self.timerSub2)
        self.timerSub2.frame = CGRect(x: self.timerSub1.frame.maxX+5+(LBFMScreenWidth-360)*0.5, y: self.numberImage2.frame.maxY+5, width: 90, height: 15)
        
        self.typeView.addSubview(self.timerDate2)
        self.timerDate2.frame = CGRect(x:self.timerDate1.frame.maxX+5+(LBFMScreenWidth-360)*0.5, y: self.timerSub1.frame.maxY, width: 90, height: 15)
        
        
        self.typeView.addSubview(self.lineLabel3)
        self.lineLabel3.frame = CGRect(x: 0, y: self.timerDate2.frame.maxY+15, width: LBFMScreenWidth-30, height: 0.5)
        
        self.typeView.addSubview(self.closeBtn)
        self.closeBtn.frame = CGRect(x:(LBFMScreenWidth-105)*0.5, y: self.lineLabel3.frame.maxY+15, width: 75, height: 25)
        
        self.addSubview(self.messageView)
        self.messageView.frame = CGRect(x: 15, y: self.typeView.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
        
        
        self.messageView.addSubview(self.messagelabel)
        self.messagelabel.frame = CGRect(x: 15, y: 15, width: 60, height: 20)
        
        
        self.messageView.addSubview(self.lineLabel4)
        self.lineLabel4.frame = CGRect(x: 15, y: 49.5, width: LBFMScreenWidth-30, height: 0.5)
        
    }
    var goodsRefundRecordModel:YDGoodsPayRefundInfo? {
        didSet {
            guard let model = goodsRefundRecordModel else {return}
            let timer1 = model.ts?.prefix(16)
            let timer2 = model.creatAt?.prefix(16)
            let timer3 = model.completeTime?.prefix(16)
            self.timerDate.text = "\(timer1 ?? "")"
            self.timerDate1.text = "\(timer1 ?? "")"
            self.timerDate2.text = "\(timer1 ?? "")"
            if model.orderStatus == "10" {
                self.typeView.frame = CGRect(x: 15, y: self.prickView.frame.maxY+15, width: LBFMScreenWidth-30, height: 150)
                self.lineLabel3.isHidden = false
                self.titleLabel.text = "退款中"
                self.timerImage.image = UIImage(named: "audit_image")
                self.timerSub1.text = "退款申请已通过"
                self.timerSub2.text = "到账成功"
                self.numberImage.image = UIImage(named: "selectGoodsImage")
                self.numberImage1.image = UIImage(named: "null_image_i")
                self.numberImage2.image = UIImage(named: "null_image_i")
            }else if model.orderStatus == "11" {
                self.typeView.frame = CGRect(x: 15, y: self.prickView.frame.maxY+15, width: LBFMScreenWidth-30, height: 150)

                self.timerImage.image = UIImage(named: "Group_Finish")
                self.titleLabel.text = "退款成功"
                self.timerSub1.text = "退款申请已通过"
                self.timerSub2.text = "到账成功"
                self.numberImage.image = UIImage(named: "selectGoodsImage")
                self.numberImage1.image = UIImage(named: "selectGoodsImage")
                self.numberImage2.image = UIImage(named: "selectGoodsImage")
            }else if model.orderStatus == "12" {
                self.typeView.frame = CGRect(x: 15, y: self.prickView.frame.maxY+15, width: LBFMScreenWidth-30, height: 150)

                self.timerImage.image = UIImage(named: "error_icon_image")
                self.timerSub1.text = "退款申请未通过"
                self.timerSub2.text = "退款失败"
                self.titleLabel.text = "退款失败"
                self.numberImage.image = UIImage(named: "selectGoodsImage")
                self.numberImage1.image = UIImage(named: "error_ico_image")
                self.numberImage2.image = UIImage(named: "error_ico_image")
            }
            
            self.prick.text = String(format: "¥%.2f",model.refundPrice ?? 0)

        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
