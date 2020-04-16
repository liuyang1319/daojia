//
//  YDGoShopPayTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDGoShopPayTableViewCellDelegate:NSObjectProtocol {
    func lookGoodsListHeaderView()
    func lookGoodsCouponHeaderView()
}
class YDGoShopPayTableViewCell: UITableViewCell {
  
    
    var sumPrice: Float = 0.00
    var saleSPrice = Float()
    weak var delegate : YDGoShopPayTableViewCellDelegate?
    var imageUrl = [String]()
    var cont = Int()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5;
        backView.clipsToBounds = true
        return backView
    }()
    lazy var shopImage : UIImageView = {
        let shop = UIImageView()
        shop.image = UIImage(named: "shop_Icon")
        return shop
    }()
    lazy var shopName : UILabel = {
        let name = UILabel()
        name.text = ""
        name.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        name.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        return name
    }()
    // 分割线
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    
    
    //    商品
    lazy var goodsImage:UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    lazy var goodsImage1:UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    lazy var goodsImage2:UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    // 数量
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    
    lazy var moreBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowsImage"), for: UIControl.State.normal)
        return button
    }()
    
    lazy var shopBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goGoodslistButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    

    // 分割线
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a:0.1)
        return label
    }()

    // 基础配送费
    lazy var distributionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "基础配送费"
        return label
    }()
    lazy var distributionPrice : UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
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
        label.text = "减免运费"
        return label
    }()
    lazy var distributionMinusPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.textAlignment = .right
        label.text = "-¥0.00"
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
        label.text = "包装费减免"
        return label
    }()
    lazy var packMinusPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.textAlignment = .right
        label.text = "-¥0.00"
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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
//        重新计算优惠
        NotificationCenter.default.addObserver(self, selector: #selector(selectGoodsOrderCoupon(nofit:)), name: NSNotification.Name(rawValue:"selectGoodsOrderCoupon"), object: nil)
        setUpLayout()
    }
    func setUpLayout(){
        
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-30, height: 400)
    
        self.backView.addSubview(self.shopImage)
        self.shopImage.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
        
        self.backView.addSubview(self.shopName)
        self.shopName.frame = CGRect(x: self.shopImage.frame.maxX + 10, y: 18, width: LBFMScreenWidth-70, height: 25)
        
        self.backView.addSubview(self.line)
        self.line.frame = CGRect(x: 15, y: self.shopImage.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)
        
        self.backView.addSubview(self.goodsImage)
        self.goodsImage.frame = CGRect(x: 15, y: self.line.frame.maxY+15, width: 60, height: 60)
        
        self.backView.addSubview(self.goodsImage1)
        self.goodsImage1.frame = CGRect(x: self.goodsImage.frame.maxX+10, y: self.line.frame.maxY+15, width: 60, height: 60)
        
        self.backView.addSubview(self.goodsImage2)
        self.goodsImage2.frame = CGRect(x: self.goodsImage1.frame.maxX+10, y: self.line.frame.maxY+15, width: 60, height: 60)
        
        self.backView.addSubview(self.countLabel)
        self.countLabel.frame = CGRect(x: LBFMScreenWidth-110, y:self.line.frame.maxY+37, width: 60, height: 15)
        
        self.backView.addSubview(self.moreBtn)
        self.moreBtn.frame = CGRect(x:LBFMScreenWidth - 50, y:self.line.frame.maxY+37, width: 10, height: 15)
        
        self.backView.addSubview(self.shopBtn)
        self.shopBtn.frame = CGRect(x: 0, y: self.line.frame.maxY, width: LBFMScreenWidth, height: 90)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.goodsImage.frame.maxY+15, width: LBFMScreenWidth-60, height: 1)
        
        self.backView.addSubview(self.distributionLabel)
        self.distributionLabel.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+20, width: 80, height:20)
        
        self.backView.addSubview(self.distributionPrice)
        self.distributionPrice.frame = CGRect(x: 110, y:  self.lineLabel.frame.maxY+20, width: LBFMScreenWidth - 155, height: 15)
        
        self.backView.addSubview(self.distributionMinusLabel)
        self.distributionMinusLabel.frame = CGRect(x: 15, y: self.distributionLabel.frame.maxY+13, width: 80, height: 20)
        
        self.backView.addSubview(self.distributionMinusPrice)
        self.distributionMinusPrice.frame = CGRect(x:110, y: self.distributionLabel.frame.maxY+13, width:LBFMScreenWidth - 155, height: 20)
        
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
       

    }

    @objc func selectGoodsOrderCoupon(nofit:Notification) {
        let str = String(format:"%@",nofit.object as! CVarArg)
        let dou = Double(str) ?? 0.0
        let couponPrice =  self.sumPrice - Float(dou)

        self.payPrice.text = "应付总金额¥\(couponPrice ?? 0.00)"
        let attributeTextPay = NSMutableAttributedString.init(string: self.payPrice.text!)
        let countPay = self.payPrice.text!.count
        attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(5, countPay-5))
        attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(5, countPay-5))
        self.payPrice.attributedText = attributeTextPay
        self.payPrice.frame = CGRect(x: LBFMScreenWidth - 45 - widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), y: self.line2Label.frame.maxY + 10, width:  widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), height: 20)
     
        self.totalPrice.text = "已优惠¥\(String(format:"%@",str as! CVarArg))"
        let attributeText = NSMutableAttributedString.init(string: self.totalPrice.text!)
        let count = self.totalPrice.text!.count
        attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
        self.totalPrice.attributedText = attributeText
        self.totalPrice.frame = CGRect(x: LBFMScreenWidth - self.payPrice.frame.width - 55 - widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), y: self.line2Label.frame.maxY + 10, width: widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), height: 20)

    }
    var couponListCount:Int = 0 {
        didSet{
            if couponListCount > 0{
                self.couponsPrice.textColor = YDLabelColor
                self.couponsPrice.text = String(couponListCount) + "张可用"
            }
        }
    }
    var goodOrderListModel:[YDOrderGoodListModel]? {
        didSet{
            guard let model = goodOrderListModel else { return }
            cont = 0
            for model in goodOrderListModel!{
                imageUrl.append(model.imageUrl!)
                cont = cont + model.count!
            }
            
            countLabel.text = "共\(cont)件"
            
            if imageUrl.count == 1{
                self.goodsImage.isHidden = false
                self.goodsImage.kf.setImage(with: URL(string:imageUrl[0]))
            }else if imageUrl.count == 2{
                self.goodsImage.isHidden = false
                self.goodsImage.kf.setImage(with: URL(string:imageUrl[0]))
                
                self.goodsImage1.isHidden = false
                self.goodsImage1.kf.setImage(with: URL(string:imageUrl[1]))
            }else if imageUrl.count == 3{
                self.goodsImage.isHidden = false
                self.goodsImage.kf.setImage(with: URL(string:imageUrl[0]))
                
                self.goodsImage1.isHidden = false
                self.goodsImage1.kf.setImage(with: URL(string:imageUrl[1]))
                
                self.goodsImage2.isHidden = false
                self.goodsImage2.kf.setImage(with: URL(string:imageUrl[2]))
            }
            
            
        }
    }
    
    var goodListModel:YDGoodsOrderordersModel? {
        didSet{
            guard let model = goodListModel else { return }
            sumPrice = 0.00
            self.shopImage.kf.setImage(with: URL(string:model.supplierImg ?? ""))
            self.shopName.text = "\(model.supplierName ?? "" )"
            
            self.distributionPrice.text = "¥\(model.sendPrice ?? 0.00)"
            
            self.distributionMinusPrice.text = "¥\(model.sendPrice ?? 0.00 )"
            
            self.packPricePage.text = "¥\(model.packPrice ?? 0.00 )"
            self.packMinusPrice.text = "¥\(model.packPrice ?? 0.00 )"
            
            
//            sumPrice = model.countSum ?? 0 + model.sendPrice! ?? 0 + model.packPrice! ?? 0
            
//            self.payPrice.text = "应付总金额¥\(sumPrice ?? 0.00)"
            
            let attributeTextPay = NSMutableAttributedString.init(string: self.payPrice.text!)
            let countPay = self.payPrice.text!.count
            attributeTextPay.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], range: NSMakeRange(5, countPay-5))
            attributeTextPay.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(5, countPay-5))
            self.payPrice.attributedText = attributeTextPay
            self.payPrice.frame = CGRect(x: LBFMScreenWidth - 45 - widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), y: self.line2Label.frame.maxY + 10, width:  widthForView(text: self.payPrice.text!, font:UIFont.systemFont(ofSize: 15), height: 20), height: 20)
            
            
            self.totalPrice.text = "已优惠¥\(model.packPrice ?? 0.00)"
            let attributeText = NSMutableAttributedString.init(string: self.totalPrice.text!)
            let count = self.totalPrice.text!.count
            attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
            self.totalPrice.attributedText = attributeText
            self.totalPrice.frame = CGRect(x: LBFMScreenWidth - self.payPrice.frame.width - 55 - widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), y: self.line2Label.frame.maxY + 10, width: widthForView(text: self.totalPrice.text!, font:UIFont.systemFont(ofSize: 14), height: 20), height: 20)
           
            
        }
    }
    
    @objc func goGoodslistButtonClick(){
        delegate?.lookGoodsListHeaderView()
    }
    @objc func lookCouponGoodslistButtonClick(){
        delegate?.lookGoodsCouponHeaderView()
    }
}
