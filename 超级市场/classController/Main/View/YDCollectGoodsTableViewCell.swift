//
//  YDCollectGoodsTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDCollectGoodsTableViewCellDelegate:NSObjectProtocol {
    func isSecctGoodsCollectTableViewCell(isSelect:UIButton)
}
class YDCollectGoodsTableViewCell: UITableViewCell {
     weak var delegate:YDCollectGoodsTableViewCellDelegate?
    private lazy var iconImage:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    private lazy var titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.numberOfLines  = 2
        title.text  = ""
        return title
    }()
    private lazy var prickLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        title.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        title.text  = ""
        return title
    }()
    private lazy var originalPrick : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        title.text  = ""
        return title
    }()
    lazy var isSelectButton:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named:"noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named:"selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(isSelectGoodsListImage(isSelect:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var stateLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12)
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        title.text  = "已告罄"
        return title
    }()
    private lazy var cartImage : UIImageView = {
        let cartIamge = UIImageView()
        cartIamge.image = UIImage(named: "cartImage")
        return cartIamge
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout() {
        
        self.contentView.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height:110)
        self.isSelectButton.frame = CGRect(x: 15, y: 40, width: 30, height: 30)
        self.backView.addSubview(self.isSelectButton)
        
        self.backView.addSubview(self.iconImage)
        
        
        self.backView.addSubview(self.titleLabel)
        
        
        self.backView.addSubview(self.prickLabel)

        
        self.backView.addSubview(self.originalPrick)
        
        self.backView.addSubview(self.stateLabel)
        
        self.backView.addSubview(self.cartImage)
        
    }
    var collectGoodsListModel:YDCollectGoodsListModel? {
        didSet {
            guard let model = collectGoodsListModel else {return}
            self.iconImage.kf.setImage(with: URL(string: model.imageUrl ?? ""))
            self.iconImage.frame = CGRect(x: self.isSelectButton.frame.maxX + 5, y: 15, width: 80, height: 80)
            
            self.titleLabel.text = model.name ?? ""
            self.titleLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 15, width: LBFMScreenWidth-120, height: heightForView(text: self.titleLabel.text!, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-120))
            
            self.prickLabel.text = String(format: "￥%.2f", model.salePrice ?? 0)
            self.prickLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y:80, width:widthForView(text: self.prickLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), height: 20), height:20)
            
            self.originalPrick.text = String(format: "￥%.2f", model.formalPrice ?? 0)
            let attribtStr = NSAttributedString.init(string: self.originalPrick.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalPrick.attributedText = attribtStr
            self.originalPrick.frame = CGRect(x: self.prickLabel.frame.maxX+15, y:80, width:widthForView(text: self.originalPrick.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), height: 20) , height:20)
            if model.status == "1" {
                self.cartImage.frame = CGRect(x: LBFMScreenWidth-35, y: 80, width: 20, height: 20)
            }else if model.status == "2"{
                self.stateLabel.frame = CGRect(x: LBFMScreenWidth-50, y:80, width: 50, height: 15)
            }
            if model.isShow == true{
                self.isSelectButton.isHidden = false
            }else{
                self.isSelectButton.isHidden = true
            }
            if model.isSelect == true{
                self.isSelectButton.isSelected = true
            }else{
                self.isSelectButton.isSelected = false
            }
        }
    }
//    选中
    @objc func isSelectGoodsListImage(isSelect:UIButton){
        delegate?.isSecctGoodsCollectTableViewCell(isSelect: isSelect)
    }
}
