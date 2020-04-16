//
//  YDGoShopPayFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDGoShopPayFooterViewDelegate:NSObjectProtocol {
//    备注
    func lookGoodsListFooterView(remark:String)
//    优惠劵
    func lookGoodsCouponFooterView()
//    商品折叠
    func selectGoodsListFoldFooterView(goodsliset:UIButton)
}
class YDGoShopPayFooterView: UITableViewHeaderFooterView,UITextViewDelegate{
    weak var delegate : YDGoShopPayFooterViewDelegate?
    var YDTextView = JHTextView()
    var sumPrice = Double()
    var saleSPrice = Float()
    var imageUrl = [String]()
    var goodsCount = Int()
    var cont = Int()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5;
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
    lazy var lineLabel :UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    // 减免运费
    lazy var distributionMinusLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "基础配送费"
        return label
    }()
    lazy var distributionMinusPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
    
    //  包装费
    lazy var packLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "包装费"
        return label
    }()
    lazy var packPricePage : UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
    
    //  包装费减免
    lazy var packMinusLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "超重费"
        return label
    }()
    lazy var packMinusPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = "¥0.00"
        return label
    }()
    // 分割线
    lazy var line1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a:0.1)
        return label
    }()
    lazy var couponsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "优惠劵"
        return label
    }()
    lazy var couponsPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
        label.textAlignment = .right
        label.text = "暂无可用"
        return label
    }()
    
    lazy var moreCoupon : UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named:"arrowsImage")
        return button
    }()
    
    lazy var couponBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(lookCouponGoodslistButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    // 分割线
    lazy var line2Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a:0.1)
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
    
    
    lazy var payTypeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "支付方式"
        return label
    }()
    lazy var payType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
        label.textAlignment = .right
        label.text = "在线支付"
        return label
    }()
    
//    lazy var invoiceLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
//        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        label.textAlignment = .left
//        label.text = "发票信息"
//        return label
//    }()
//    lazy var invoiceType: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
//        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
//        label.textAlignment = .right
//        label.text = "去发票中心开具发票"
//        return label
//    }()
//    private lazy var invoiceImage : UIImageView = {
//        let iamgeView = UIImageView()
//        iamgeView.image = UIImage(named: "arrowsImage")
//        return iamgeView
//    }()
    
    lazy var remarkLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "订单备注"
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.YDTextView.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(self.doneButtonClicked(textView:)))
        
        //        重新计算优惠
        NotificationCenter.default.addObserver(self, selector: #selector(selectGoodsOrderCoupon(nofit:)), name: NSNotification.Name(rawValue:"selectGoodsOrderCoupon"), object: nil)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y:0, width: LBFMScreenWidth-30, height: 250)
 
        self.backView.addSubview(self.distributionMinusLabel)
        
        self.backView.addSubview(self.listButton)
        self.listButton.frame = CGRect(x: (LBFMScreenWidth-80)*0.5, y: 10, width: 80, height: 30)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.listButton.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)
        
        self.distributionMinusLabel.frame = CGRect(x: 15, y:self.lineLabel.frame.maxY+10, width: 80, height: 20)
        
        self.backView.addSubview(self.distributionMinusPrice)
        self.distributionMinusPrice.frame = CGRect(x:110, y:self.lineLabel.frame.maxY+10, width:LBFMScreenWidth - 155, height: 20)
        
        self.backView.addSubview(self.packLabel)
        self.packLabel.frame = CGRect(x: 15, y: self.distributionMinusLabel.frame.maxY+13, width: 80, height: 20)
        
        
        self.backView.addSubview(self.packPricePage)
        self.packPricePage.frame = CGRect(x: 110, y: self.distributionMinusLabel.frame.maxY+13, width: LBFMScreenWidth - 155, height: 20)
        
        self.backView.addSubview(self.packMinusLabel)
        self.packMinusLabel.frame = CGRect(x: 15, y: self.packLabel.frame.maxY+13, width: 80, height: 20)
        
        self.backView.addSubview(self.packMinusPrice)
        self.packMinusPrice.frame = CGRect(x:110, y: self.packPricePage.frame.maxY+13, width: LBFMScreenWidth - 155, height: 20)
        
        self.backView.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 15, y: self.packMinusLabel.frame.maxY+15, width: LBFMScreenWidth-60, height: 1)
        
        
        self.backView.addSubview(self.couponsLabel)
        self.couponsLabel.frame = CGRect(x: 15, y: self.line1Label.frame.maxY+15, width:80, height: 23)
        
        self.backView.addSubview(self.couponsPrice)
        self.couponsPrice.frame = CGRect(x:110, y: self.line1Label.frame.maxY+15, width: LBFMScreenWidth - 165, height: 15)
        
        self.backView.addSubview(self.moreCoupon)
        self.moreCoupon.frame = CGRect(x: LBFMScreenWidth-50, y: self.line1Label.frame.maxY+15, width: 10, height: 15)
        
        self.backView.addSubview(self.couponBtn)
        self.couponBtn.frame = CGRect(x: 0, y: self.line1Label.frame.maxY, width: LBFMScreenWidth, height: 50)
        
        self.backView.addSubview(self.line2Label)
        self.line2Label.frame = CGRect(x: 15, y: self.couponsLabel.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)
        
        self.backView.addSubview(self.totalPrice)

        self.backView.addSubview(self.payPrice)
        

        self.addSubview(self.backView1)
        self.backView1.frame = CGRect(x: 15, y:self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 135)

        self.backView1.addSubview(self.payTypeLabel)
        self.payTypeLabel.frame = CGRect(x: 15, y:15, width: 60, height: 20)

        self.backView1.addSubview(self.payType)
        self.payType.frame = CGRect(x: LBFMScreenWidth-110, y: 17, width: 50, height: 15)


        self.backView1.addSubview(self.remarkLabel)
        self.remarkLabel.frame = CGRect(x: 15, y: self.payTypeLabel.frame.maxY+20, width: 60, height: 20)
        
        self.backView1.addSubview(self.YDTextView)
        self.YDTextView.frame = CGRect(x:self.remarkLabel.frame.maxX+10, y: self.payTypeLabel.frame.maxY+15, width: LBFMScreenWidth-130, height: 60)
        self.YDTextView.placeHolder = "请输入备注信息"
        self.YDTextView.delegate = self
        self.YDTextView.placeHolderColor = YMColor(r: 226, g: 226, b: 226, a: 1)
        self.YDTextView.font = UIFont.systemFont(ofSize: 13)
        self.YDTextView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        self.YDTextView.MaxCount = 50
//        self.YDTextView.tapTwiceDisapper = true

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if stringContainsEmoji(input: text) == true{
            return false
        }else{
            return true
        }
    }

    //    输入问题
    @objc func doneButtonClicked(textView:Any) {
        self.YDTextView = textView as! JHTextView
        delegate?.lookGoodsListFooterView(remark:YDTextView.text)
//        self.refundAbleStr = self.YDTextView.text
    }
    var goodListCount:[YDOrderGoodListModel]?{
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
    @objc func selectGoodsOrderCoupon(nofit:Notification) {
        let str = String(format:"%@",nofit.object as! CVarArg)
        let commCount = String(format: "%d张可用", nofit.userInfo?["couponCount"] as! CVarArg)
        let dou = Double(str) ?? 0
        if dou > 0 {
            self.couponsPrice.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
            self.couponsPrice.text = String(format: "优惠¥%.1f元",dou as CVarArg)
        }else{
            
            self.couponsPrice.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
            self.couponsPrice.text = commCount
        }
        let couponPrice =  self.sumPrice - dou

        self.payPrice.text = String(format:"应付总金额¥%.2f",couponPrice as! CVarArg)
        let attributeTextPay = NSMutableAttributedString.init(string: self.payPrice.text!)
        let countPay = self.payPrice.text!.count
        attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(5, countPay-5))
        attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(5, countPay-5))
        self.payPrice.attributedText = attributeTextPay
        self.payPrice.frame = CGRect(x: LBFMScreenWidth - 45 - widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), y: self.line2Label.frame.maxY + 10, width:  widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), height: 20)
        
        self.totalPrice.text = String(format:"已优惠¥%.2f",dou as! CVarArg)
        let attributeText = NSMutableAttributedString.init(string: self.totalPrice.text!)
        let count = self.totalPrice.text!.count
        attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
        self.totalPrice.attributedText = attributeText
        self.totalPrice.frame = CGRect(x: LBFMScreenWidth - self.payPrice.frame.width - 55 - widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), y: self.line2Label.frame.maxY + 10, width: widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), height: 20)
        
    }
    var couponListCount:Int = 0 {
        didSet{
            if couponListCount > 0{
                self.couponsPrice.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
                self.couponsPrice.text = String(couponListCount) + "张可用"
            }else{
                self.couponsPrice.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
                self.couponsPrice.text = "暂无可用"
            }
        }
    }

    
    var goodListModel:YDGoodsOrderordersModel? {
        didSet{
            guard let model = goodListModel else { return }
            
            self.distributionMinusPrice.text = String(format: "¥%.2f", model.sendPrice ?? 0)
            self.packPricePage.text = String(format: "¥%.2f", model.packPrice ?? 0)
            self.packMinusPrice.text = String(format: "¥%.2f", model.weightPrice ?? 0)
    
            sumPrice = Double(model.countSum ?? 0.0) + Double(model.sendPrice ?? 0.0) + Double(model.packPrice ?? 0.0) + Double(model.weightPrice ?? 0.0)
            self.payPrice.text = String(format: "应付总金额¥%.2f",sumPrice ?? 0.00)
            let attributeTextPay = NSMutableAttributedString.init(string: self.payPrice.text!)
            let countPay = self.payPrice.text!.count
            attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(5, countPay-5))
            attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(5, countPay-5))
            self.payPrice.attributedText = attributeTextPay
            self.payPrice.frame = CGRect(x: LBFMScreenWidth - 45 - widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), y: self.line2Label.frame.maxY + 10, width:  widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), height: 20)
            
            self.totalPrice.text = "已优惠¥0.00"
            let attributeText = NSMutableAttributedString.init(string: self.totalPrice.text!)
            let count = self.totalPrice.text!.count
            attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
            self.totalPrice.attributedText = attributeText
            self.totalPrice.frame = CGRect(x: LBFMScreenWidth - self.payPrice.frame.width - 55 - widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), y: self.line2Label.frame.maxY + 10, width: widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), height: 20)
            
            
        }
    }
    

    @objc func lookCouponGoodslistButtonClick(){
        delegate?.lookGoodsCouponFooterView()
    }
//    折叠商品
    @objc func lookSelectGoodslistButtonClick(GoodsList:UIButton){
        delegate?.selectGoodsListFoldFooterView(goodsliset:GoodsList)

    }
}
