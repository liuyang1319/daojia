//
//  YDShopFooterReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDShopFooterReusableViewDelegate:NSObjectProtocol {
    //    去支付
    func payAllGoodsListFooterReusableView()
    
    func selectAllGoodsListFooterReusableView(sumCount:YDShopFooterReusableView,selectAll:UIButton,sumPrice:UILabel,originalPrice:UILabel,sunButton:UIButton)
}
class YDShopFooterReusableView: UIView {
    
    private static let kYDShopFooterReusableView = "YDShopFooterReusableView"
    
    weak var delegate : YDShopFooterReusableViewDelegate?

    
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selectAllGoodsListButtonClick(indexGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var allLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.text = "全选"
        return label
    }()
    lazy var sumLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.text = "总计："
        return label
    }()
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.text = "￥0.00"
        return label
    }()
    lazy var sumPrice : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.text = "总额:￥0.00"
        return label
    }()
    lazy var discountsPrice : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        label.text = "优惠:￥0.00"
        return label
    }()
    
    lazy var sunButton : UIButton = {
        let button = UIButton()
        button.setTitle("结算", for: UIControl.State.normal)
        button.backgroundColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(payAllGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var linLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
//    static func dequeueReusableFooterView(tableView: UITableView) -> YDShopFooterReusableView {
//        var footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: kYDShopFooterReusableView)
//        if footer == nil {
////            footer = YDShopFooterReusableView.init(reuseIdentifier: kYDShopFooterReusableView) as! YDShopFooterReusableView
////            footer.setUpLayout()
//        }
//
//        return footer as! YDShopFooterReusableView
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout()  {

        self.addSubview(self.selectBtn)
        self.selectBtn.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
        
        self.addSubview(self.allLabel)
        self.allLabel.frame = CGRect(x: self.selectBtn.frame.maxX+10, y: 25, width: 25, height: 20)
        
        self.addSubview(self.sumLabel)
        self.sumLabel.frame = CGRect(x: self.allLabel.frame.maxX+10, y: 15, width: 43, height: 20)
        
        self.addSubview(self.priceLabel)
        self.priceLabel.frame = CGRect(x: self.sumLabel.frame.maxX, y: 15, width: 150, height: 20)
        
        self.addSubview(self.sumPrice)
        self.sumPrice.frame = CGRect(x: self.allLabel.frame.maxX+10, y: self.priceLabel.frame.maxY+5, width: widthForView(text: self.sumPrice.text!, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular), height: 20), height: 20)
        
        self.addSubview(self.discountsPrice)
        self.discountsPrice.frame = CGRect(x: self.sumPrice.frame.maxX, y: self.priceLabel.frame.maxY+5, width: 150, height: 20)
        
        self.addSubview(self.sunButton)
        self.sunButton.frame = CGRect(x: LBFMScreenWidth-100, y: 25, width: 85, height: 30)
        
        self.addSubview(self.linLabel)
        self.linLabel.frame = CGRect(x: 0, y: 66, width: LBFMScreenWidth, height: 4)
    }
    var priceSum : Float = 0.00{
        didSet {
            self.priceLabel.text = "￥\(priceSum)"
            self.sumPrice.text = "总额:￥\(priceSum)"
        }
    }
    var sumNumber : NSInteger = 0{
        didSet {
            if sumNumber > 0{
                self.sunButton.setTitle("结算(\(sumNumber))", for: UIControl.State.normal)
            }else{
                self.sunButton.setTitle("结算", for: UIControl.State.normal)
            }
        }
    }
    var allSelect : Bool?{
        didSet {
            selectBtn.isSelected = allSelect!
        }
    }
    @objc func selectAllGoodsListButtonClick(indexGoods:UIButton){
         delegate?.selectAllGoodsListFooterReusableView(sumCount: self, selectAll: self.selectBtn, sumPrice: self.priceLabel, originalPrice: self.sumPrice, sunButton: self.sunButton)
    }
    @objc func payAllGoodsListButtonClick(){
        delegate?.payAllGoodsListFooterReusableView()
    }
}
