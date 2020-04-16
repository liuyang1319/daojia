//
//  YDOrderDetailsHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDOrderDetailsHeaderViewDelegate:NSObjectProtocol {
//    物流信息
    func goodsOrderInfoMessageHeaderView()
//    联系配送员
    func cellIphoneMessageHeaderView()
//    申请退款
    func goodsOrderInfoPaymentHeaderView()
}

class YDOrderDetailsHeaderView: UITableViewHeaderFooterView {
    weak var delegate : YDOrderDetailsHeaderViewDelegate?
    var typeLook = String()
    lazy var backImage : UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named: "header_back_image")
        return backImage
    }()
    
    lazy var backView :UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()

    private lazy var orderButton : UIButton = {
        let button = UIButton()
        button.setTitle("", for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "status_Image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(orderDemoButtonClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        return button
    }()
    
//    订单状态
    lazy var statusLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "本人已签收"
        statusLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return statusLabel
    }()
    
    //    配送员
    lazy var personLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.isHidden  = true
        statusLabel.text = "送货人：王默默"
        statusLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        statusLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return statusLabel
    }()
    
    //    配送员联系方式
    private lazy var phoneButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("联系配送员", for: UIControl.State.normal)
        button.setImage(UIImage(named: "cell_Image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(cellIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        button.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
        return button
    }()
    
    
    // 昵称
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = YMColor(r: 151, g: 151, b: 151, a: 1)
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private lazy var refundButton : UIButton = {
        let button = UIButton()
        button.isHidden = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsoPayMentButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("申请退款", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "deletButtonImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        return button
    }()
    lazy var backView1 :UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var shopImage : UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named: "shop_image")
        return backImage
    }()
    //    配送员
    lazy var shopName : UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "店铺"
        statusLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        statusLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        return statusLabel
    }()
    
    lazy var lineLabel:UILabel = {
        let line = UILabel()
        line.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return line
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.addSubview(self.backImage)
        if  isIphoneX == true{
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 230)
        }else{
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 205)
        }
//        点击查看状态
        self.addSubview(self.orderButton)
        self.orderButton.frame = CGRect(x:15 , y: LBFMNavBarHeight + 5, width: 120, height: 20)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
        
        self.backView.addSubview(self.statusLabel)
        self.statusLabel.frame = CGRect(x: 15, y: 10, width: LBFMScreenWidth-60, height: 20)
        
        self.backView.addSubview(self.personLabel)
        self.personLabel.frame = CGRect(x: 15, y: self.statusLabel.frame.maxY+5, width: 200, height: 15)
        
        self.backView.addSubview(self.phoneButton)
        self.phoneButton.frame = CGRect(x: LBFMScreenWidth-150, y: self.statusLabel.frame.maxY+5, width: 90, height: 15)
        
        
        
//        self.addSubview(self.backView1)
        self.backView1.frame = CGRect(x: 15, y: self.backImage.frame.maxY, width: LBFMScreenWidth-30, height: 60)
        
        self.backView1.addSubview(self.shopImage)
        self.shopImage.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
        
        self.backView1.addSubview(self.shopName)
        self.shopName.frame = CGRect(x: self.shopImage.frame.maxX+15, y: 18, width: LBFMScreenWidth-110, height: 25)
        
        self.backView1.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 59, width: LBFMScreenWidth-60, height: 1)
        
       
    }
    var lookRefund:String = ""{
        didSet {
            self.typeLook = lookRefund
        }
    }
    var orderInfoModel: YDOrderorderDetailsModel? {
        didSet{
            guard let orderModel = orderInfoModel else {return}
            
            if orderModel.status == "1" {
                self.orderButton.setTitle("订单待支付", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "2" {
                self.orderButton.setTitle("商品准备中", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                 self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "3" {
                self.orderButton.setTitle("商品准备中", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                 self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "4" {
                self.orderButton.setTitle("商品准备中", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                 self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "5" {
                self.orderButton.setTitle("配送中", for: UIControl.State.normal)
                self.phoneButton.isHidden = false
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                self.personLabel.isHidden = false
                self.personLabel.text = "配送员:\(orderModel.deliveryName ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
            }else if orderModel.status == "6" {
                self.orderButton.setTitle("订单已完成", for: UIControl.State.normal)
                self.phoneButton.isHidden = false
                self.personLabel.isHidden = false
                self.statusLabel.text = "签收方式：\(orderModel.completeReason ?? "")"
                self.personLabel.text = "配送员:\(orderModel.deliveryName ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
            }else if orderModel.status == "7" {
                self.phoneButton.isHidden = false
                self.personLabel.isHidden = false
                self.orderButton.setTitle("订单已完成", for: UIControl.State.normal)
                self.statusLabel.text = "签收方式：\(orderModel.completeReason ?? "")"
                self.personLabel.text = "配送员:\(orderModel.deliveryName ?? "")"
        
                self.backView.addSubview(self.refundButton)
                self.refundButton.frame = CGRect(x: 15, y: self.personLabel.frame.maxY+8, width: 70, height: 20)
                if self.typeLook == "11" {
                    self.refundButton.setTitle("查看退款", for: UIControl.State.normal)
                }else{
                    self.refundButton.setTitle("申请退款", for: UIControl.State.normal)
                }
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
            }else if orderModel.status == "8"{
                self.personLabel.isHidden = false
                self.orderButton.setTitle("订单已取消", for: UIControl.State.normal)
                self.statusLabel.text = "取消原因："
                self.personLabel.text = "\(orderModel.cancelReason ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
               
            }else if orderModel.status == "9"{
                self.personLabel.isHidden = false
                self.phoneButton.isHidden = false
                self.orderButton.setTitle("评价已完成", for: UIControl.State.normal)
                self.statusLabel.text = "签收方式:\(orderModel.completeReason ?? "")"
                self.personLabel.text = "配送员:\(orderModel.deliveryName ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 85)
            }else if orderModel.status == "10"{
//                self.personLabel.isHidden = false
//                self.phoneButton.isHidden = false
                self.orderButton.setTitle("订单已完成", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "11"{
//                self.personLabel.isHidden = false
                self.orderButton.setTitle("订单已完成", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }else if orderModel.status == "12"{
//                self.personLabel.isHidden = false
//                self.phoneButton.isHidden = false
                self.orderButton.setTitle("订单已完成", for: UIControl.State.normal)
                self.statusLabel.text = "订单号：\(orderModel.orderNum ?? "")"
                self.backView.frame = CGRect(x: 15, y:self.orderButton.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
            }

            self.shopImage.kf.setImage(with: URL(string: orderModel.supplierImg ?? ""))
            self.shopName.text = "\(orderModel.supplierName ?? "")"
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//    订单物流消息
    @objc func orderDemoButtonClick(){
        delegate?.goodsOrderInfoMessageHeaderView()
    }
    
//    联系配送员
    @objc func cellIphoneButtonClick(){
        delegate?.cellIphoneMessageHeaderView()
    }
//    申请退款
    @objc func reconfirmGoodsoPayMentButtonClick(){
        delegate?.goodsOrderInfoPaymentHeaderView()
    }

}
