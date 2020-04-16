//
//  YDUserInvoiceHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDUserInvoiceHeaderViewDelegate:NSObjectProtocol {
    func addUserInvoiceListHeaderView()
}
class YDUserInvoiceHeaderView: UIView {
    weak var delegate : YDUserInvoiceHeaderViewDelegate?
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    lazy var addButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addInvoice_Image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addUserInvoiceButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.text = "添加发票抬头"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return title
    }()
    
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x:0, y: 10, width: LBFMScreenWidth, height: 50)
        
        self.backView.addSubview(self.addButton)
        self.addButton.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.addButton.frame.maxX+15, y: 15, width: 200, height: 20)
        
        self.backView.addSubview(self.line)
        self.line.frame = CGRect(x:15, y: 49, width: LBFMScreenWidth-15, height: 1)
    }
    
    @objc func addUserInvoiceButtonClick(){
        delegate?.addUserInvoiceListHeaderView()
    }
}
