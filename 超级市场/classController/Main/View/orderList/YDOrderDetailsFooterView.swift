//
//  YDOrderDetailsFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDOrderDetailsFooterViewDelegate:NSObjectProtocol {
    //    商品折叠
    func selectGoodsListFoldFooterView(goodsliset:UIButton)
}
class YDOrderDetailsFooterView: UITableViewHeaderFooterView {
    weak var delegate : YDOrderDetailsFooterViewDelegate?
    var goodsCount = Int()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var listButton :UIButton = {
        let button = UIButton()
        button.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(lookSelectGoodslistButtonClick(GoodsList:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 15
        button.isSelected = false
        button.clipsToBounds = true
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "message_down"), for: UIControl.State.normal)
        button.setTitle("共0件", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        return button
    }()

    
    // 分割线
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    // 商品总额
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "基础配送费"
        return label
    }()
    lazy var shopPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
    // 基础配送费
    lazy var distributionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "包装费"
        return label
    }()
    lazy var distributionPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
    // 减免运费
    lazy var distributionMinusLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "超重费"
        return label
    }()
    lazy var distributionMinusPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
 
    // 分割线
    lazy var line1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    lazy var couponsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "优惠劵"
        return label
    }()
    lazy var couponsPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.textColor = YDLabelColor
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    // 分割线
    lazy var line2Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    lazy var totalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "已优惠 ¥0.00"
        return label
    }()
    
    lazy var payPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "应付总金额 ¥0.00"
        return label
    }()
    
    
    lazy var backView1 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
//    订单信息
    lazy var orderInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "订单信息"
        return label
    }()
    // 分割线
    lazy var line3Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    
    //    订单编号
    lazy var orderNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "订单编号"
        return label
    }()
    //    订单编号
    lazy var number: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    //    收货人
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "收货人"
        return label
    }()
    //    收货人
    lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    //    联系人
    lazy var iPhoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "手机号码"
        return label
    }()
    //
    lazy var cellIphone: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    //    收货地址
    lazy var addersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "收货地址"
        return label
    }()
    //
    lazy var adders: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    //    预计送达时间
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "预计送达时间"
        return label
    }()
    //
    lazy var timer: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    //    配送方式
    lazy var methodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "配送方式"
        return label
    }()
    //
    lazy var method: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "配送"
        return label
    }()
    //    支付方式
    lazy var payLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "支付方式"
        return label
    }()
    //
    lazy var payment: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "在线支付"
        return label
    }()
    //    支付方式
    lazy var orderTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "下单时间"
        return label
    }()
    //
    lazy var orderTimer: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    //    发票
    lazy var invoiceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "是否开具发票"
        return label
    }()
    //
    lazy var orderInvoice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "无"
        return label
    }()
    //    备注
    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = "备注"
        return label
    }()
    //
    lazy var orderRemark: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 275)
        
        self.backView.addSubview(self.listButton)
        self.listButton.frame = CGRect(x: (LBFMScreenWidth-80)*0.5, y: 10, width: 80, height: 30)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.listButton.frame.maxY + 10, width: LBFMScreenWidth-30, height: 1)
        
        self.backView.addSubview(self.priceLabel)
        self.priceLabel.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+15, width: 100, height: 20)
        
        self.backView.addSubview(self.shopPrice)
        self.shopPrice.frame = CGRect(x: LBFMScreenWidth-150, y: self.lineLabel.frame.maxY+15, width: 105, height: 20)
        
        self.backView.addSubview(self.distributionLabel)
        self.distributionLabel.frame = CGRect(x: 15, y: self.priceLabel.frame.maxY+15, width: 120, height: 20)
        
        self.backView.addSubview(self.distributionPrice)
        self.distributionPrice.frame = CGRect(x: LBFMScreenWidth-150, y: self.priceLabel.frame.maxY+15, width: 105, height: 20)
        
        self.backView.addSubview(self.distributionMinusLabel)
        self.distributionMinusLabel.frame = CGRect(x: 15, y: self.distributionLabel.frame.maxY+15, width: 120, height: 20)
        
        self.backView.addSubview(self.distributionMinusPrice)
        self.distributionMinusPrice.frame = CGRect(x: LBFMScreenWidth-150, y: self.distributionLabel.frame.maxY+15, width: 105, height: 20)
        
//        self.backView.addSubview(self.packMinusLabel)
//        self.packMinusLabel.frame = CGRect(x: 15, y: self.distributionMinusLabel.frame.maxY+15, width: 120, height: 20)
//
//        self.backView.addSubview(self.packMinusPrice)
//        self.packMinusPrice.frame = CGRect(x:LBFMScreenWidth-150 , y: self.distributionMinusLabel.frame.maxY+15, width: 105, height: 20)
//
//
        self.backView.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 15, y: self.distributionMinusLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        self.backView.addSubview(self.couponsLabel)
        self.couponsLabel.frame = CGRect(x: 15, y: self.line1Label.frame.maxY+15, width: 80, height: 20)
        
        self.backView.addSubview(self.couponsPrice)
        self.couponsPrice.frame = CGRect(x: LBFMScreenWidth-150, y: self.line1Label.frame.maxY+15, width: 100, height: 20)
        
        self.backView.addSubview(self.line2Label)
        self.line2Label.frame = CGRect(x: 15, y: self.couponsPrice.frame.maxY+15, width: LBFMScreenWidth-30, height: 1)
        
        self.backView.addSubview(self.totalPrice)
        
        
        self.backView.addSubview(self.payPrice)
     
        
        
        self.addSubview(self.backView1)
        self.backView1.frame = CGRect(x: 15, y: self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 420)
 
        self.backView1.addSubview(self.orderInfo)
        self.orderInfo.frame = CGRect(x: 15, y:15, width: 100, height: 20)
        self.backView1.addSubview(self.line3Label)
        self.line3Label.frame = CGRect(x: 15, y: self.orderInfo.frame.maxY+15, width: LBFMScreenWidth-60, height: 1)
        
        self.backView1.addSubview(self.orderNumber)
        self.orderNumber.frame = CGRect(x: 15, y: self.line3Label.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.number)
        self.number.frame = CGRect(x: LBFMScreenWidth-250, y: self.line3Label.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 15, y: self.orderNumber.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.name)
        self.name.frame = CGRect(x: LBFMScreenWidth-250, y: self.orderNumber.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.iPhoneLabel)
        self.iPhoneLabel.frame = CGRect(x: 15, y: self.nameLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.cellIphone)
        self.cellIphone.frame = CGRect(x: LBFMScreenWidth-250, y: self.nameLabel.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.addersLabel)
        self.addersLabel.frame = CGRect(x: 15, y: self.iPhoneLabel.frame.maxY+15, width: 130, height: 20)
        
        self.backView1.addSubview( self.adders)
        self.adders.frame = CGRect(x: LBFMScreenWidth-250, y: self.iPhoneLabel.frame.maxY+15, width: 200, height: 20)

        self.backView1.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: 15, y: self.addersLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.timer)
        self.timer.frame = CGRect(x: LBFMScreenWidth-250, y: self.addersLabel.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.methodLabel)
        self.methodLabel.frame = CGRect(x: 15, y: self.timerLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.method)
        self.method.frame = CGRect(x: LBFMScreenWidth-250, y: self.timerLabel.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.payLabel)
        self.payLabel.frame = CGRect(x: 15, y: self.methodLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.payment)
        self.payment.frame = CGRect(x: LBFMScreenWidth-250, y: self.methodLabel.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.orderTimerLabel)
        self.orderTimerLabel.frame = CGRect(x: 15, y: self.payLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.orderTimer)
        self.orderTimer.frame = CGRect(x: LBFMScreenWidth-250, y: self.payLabel.frame.maxY+15, width: 200, height: 20)
        
        
        self.backView1.addSubview(self.invoiceLabel)
        self.invoiceLabel.frame = CGRect(x: 15, y: self.orderTimerLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.orderInvoice)
        self.orderInvoice.frame = CGRect(x: LBFMScreenWidth-250, y: self.orderTimerLabel.frame.maxY+15, width: 200, height: 20)
        
        self.backView1.addSubview(self.remarkLabel)
        self.remarkLabel.frame = CGRect(x: 15, y: self.invoiceLabel.frame.maxY+15, width: 130, height: 20)
        self.backView1.addSubview( self.orderRemark)
        self.orderRemark.frame = CGRect(x: LBFMScreenWidth-250, y: self.invoiceLabel.frame.maxY+15, width: 200, height: 30)
        

    }
    var orderInfoModel: YDOrderorderDetailsModel? {
        didSet{
            guard let orderModel = orderInfoModel else {return}
            
            self.number.text = orderModel.orderNum ?? ""
            self.name.text = orderModel.addressName ?? ""
            self.cellIphone.text = orderModel.addressPhone ?? ""
            
            self.adders.text = orderModel.street ?? ""
            
            self.timer.text = orderModel.expectedTime ?? ""
            
            self.orderTimer.text = orderModel.creatAt ?? ""
            if orderModel.invoicePayable == "1" {
                self.orderInvoice.text = "是"
            }else if orderModel.invoicePayable == "1"{
                self.orderInvoice.text = "否"
            }else{
                self.orderInvoice.text = "否"
            }
            self.orderRemark.text = orderModel.userContent ?? ""
            
            self.shopPrice.text = String(format: "¥%.2f",orderModel.sendPrice ?? 0.00 as! CVarArg)
            self.distributionPrice.text = String(format: "¥%.2f",orderModel.packPrice ?? 0.00 as! CVarArg)
            self.distributionMinusPrice.text = String(format: "¥%.2f",orderModel.weightPrice ?? 0.00 as! CVarArg)
            self.couponsPrice.text = String(format: "减%.2f元",orderModel.couponPrice ?? 0.00 as! CVarArg)
            let sumPrice = Double(orderModel.countSum ?? 0.0) +  Double(orderModel.sendPrice ?? 0.0) + Double(orderModel.packPrice ?? 0.0) + Double(orderModel.weightPrice ?? 0.0) - Double(orderModel.couponPrice ?? 0.0)
            self.payPrice.text = String(format:"应付总金额¥%.2f",sumPrice ?? 0.00 as! CVarArg)
            let attributeTextPay = NSMutableAttributedString.init(string: self.payPrice.text!)
            let countPay = self.payPrice.text!.count
            attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(5, countPay-5))
            attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(5, countPay-5))
            self.payPrice.attributedText = attributeTextPay
            self.payPrice.frame = CGRect(x: LBFMScreenWidth - 45 - widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), y: self.line2Label.frame.maxY + 10, width:  widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), height: 20)
            
            self.totalPrice.text = String(format:"已优惠¥%.2f",orderModel.cheapPrice ?? 0.00 as! CVarArg)
            let attributeText = NSMutableAttributedString.init(string: self.totalPrice.text!)
            let count = self.totalPrice.text!.count
            attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
            self.totalPrice.attributedText = attributeText
            self.totalPrice.frame = CGRect(x: LBFMScreenWidth - self.payPrice.frame.width - 55 - widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), y: self.line2Label.frame.maxY + 10, width: widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), height: 20)

        }
    }
    var goodListCount:[YDorderDetailGoodsModel]?{
        didSet{
            guard let model = goodListCount else { return }
            goodsCount = 0
            for countNumber in model{
                goodsCount += countNumber.count!
            }
            self.listButton.setTitle(String(format: "共%d件",goodsCount), for: UIControl.State.normal)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //    折叠商品
    @objc func lookSelectGoodslistButtonClick(GoodsList:UIButton){
        delegate?.selectGoodsListFoldFooterView(goodsliset:GoodsList)
    }
}
