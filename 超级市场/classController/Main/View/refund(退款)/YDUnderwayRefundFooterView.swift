//
//  YDUnderwayRefundFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUnderwayRefundFooterView: UITableViewHeaderFooterView {
    
    var backView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()

    var causeLabel:UILabel = {
        let label = UILabel()
        label.text = "退款原因"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b:51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    var orderLabel:UILabel = {
        let label = UILabel()
        label.text = "下单编号"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    var orderNumber:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-30, height: 100)
        
        self.backView.addSubview(self.causeLabel)
        self.causeLabel.frame = CGRect(x: 15, y: 15, width: 60, height: 20)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.causeLabel.frame.maxX+30, y: 15, width: LBFMScreenWidth-150, height: 20)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.causeLabel.frame.maxY+15, width: LBFMScreenWidth-30, height: 0.5)
        
        
        self.backView.addSubview(self.orderLabel)
        self.orderLabel.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+15, width: 60, height: 20)
        
        self.backView.addSubview(self.orderNumber)
        self.orderNumber.frame = CGRect(x: self.orderLabel.frame.maxX+30, y: self.lineLabel.frame.maxY+15, width: LBFMScreenWidth-150, height: 20)

    }
    var goodsRefundRecordModel:YDGoodsPayRefundInfo? {
        didSet {
            guard let model = goodsRefundRecordModel else {return}
            self.titleLabel.text = model.refundReason ?? ""
            self.orderNumber.text = model.orderNum ?? ""
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
