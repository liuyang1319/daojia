//
//  YDUserLookInvoiceViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUserLookInvoiceViewController: YDBasicViewController {
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.text = "单位发票抬头"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    
    lazy var nameLabel:UILabel = {
        let title = UILabel()
        title.text = "名称"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    lazy var nameTitle:UILabel = {
        let title = UILabel()
        title.text = "云达在线(北京)科技发展有限公司"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    lazy var numberLabel:UILabel = {
        let title = UILabel()
        title.text = "税号"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    lazy var numberTitle:UILabel = {
        let title = UILabel()
        title.text = "91110105MA01CU2G99"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    lazy var line1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    
    lazy var iconImage:UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.red
        return icon
    }()
    lazy var hintTitle:UILabel = {
        let title = UILabel()
        title.text = "开票时候出示"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return title
    }()
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitle("编辑", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的发票抬头"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        setAddUserInvoiceView()
    }
//    编辑
    @objc func rightBarButtonClick(){
        let editVC = YDUserEditInvoiceViewController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    func setAddUserInvoiceView() {
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y:LBFMNavBarHeight + 10, width: LBFMScreenWidth, height: 355)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 15, width: 90, height: 20)
        
        self.backView.addSubview(self.line)
        self.line.frame = CGRect(x: 0, y:self.titleLabel.frame.maxY + 15, width: LBFMScreenWidth, height: 1)
        
        self.backView.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 15, y:self.line.frame.maxY + 15, width: 30, height: 20)
        
        self.backView.addSubview(self.nameTitle)
        self.nameTitle.frame = CGRect(x: 85, y:self.line.frame.maxY + 15, width:LBFMScreenWidth-110, height: 20)
        
        self.backView.addSubview(self.numberLabel)
        self.numberLabel.frame = CGRect(x: 15, y:self.nameLabel.frame.maxY + 15, width: 30, height: 20)
        
        self.backView.addSubview(self.numberTitle)
        self.numberTitle.frame = CGRect(x: 85, y:self.nameLabel.frame.maxY + 15, width:LBFMScreenWidth-110, height: 20)
        
        self.backView.addSubview(self.line1)
        self.line1.frame = CGRect(x: 0, y:self.numberLabel.frame.maxY + 15, width: LBFMScreenWidth, height: 1)
        
        self.backView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x:(LBFMScreenWidth-150)*0.5, y:self.line1.frame.maxY + 15, width: 150, height: 150)
        
        self.backView.addSubview(self.hintTitle)
        self.hintTitle.frame = CGRect(x:(LBFMScreenWidth-90)*0.5, y:self.iconImage.frame.maxY + 15, width: 90, height: 20)
        
        
    }
}
