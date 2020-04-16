//
//  YDYDApplicationRefundListTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/26.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol YDYDApplicationRefundListTableViewCellDelegate:NSObjectProtocol {
    //    用户资料
    func isSelectGoodsRefundListTableViewCell(isSelect:UIButton)
}
class YDYDApplicationRefundListTableViewCell: UITableViewCell {
    weak var delegate : YDYDApplicationRefundListTableViewCellDelegate?
    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named:"selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(isGoodsSelectButtonClick(select:)), for: UIControl.Event.touchUpInside)
        button.isHidden = true
        return button
    }()
    
    var iconImage:UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.white
        return icon
    }()
    
    var nameTitle : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.numberOfLines = 2
        return label
    }()
    
    var prickTitle : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    
    var numberTitle : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        return label
    }()
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        setUpLayout()
    }
    func setUpLayout(){

        self.addSubview(self.backView)
        self.backView.frame = CGRect(x:0, y:0, width: LBFMScreenWidth, height: 120)
        
        
        self.backView.addSubview(self.selectBtn)
        self.selectBtn.frame = CGRect(x: 15, y:50, width: 20, height: 20)
        
        self.backView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x:self.selectBtn.frame.maxX + 15, y: 15, width: 80, height: 80)
        
        self.backView.addSubview(self.nameTitle)
        self.nameTitle.frame = CGRect(x: self.iconImage.frame.maxX + 10, y: 15, width: LBFMScreenWidth-160, height: 30)
        
        self.backView.addSubview(self.prickTitle)
        self.prickTitle.frame = CGRect(x: self.iconImage.frame.maxX + 15, y: 80, width: LBFMScreenWidth-180, height: 20)

        self.backView.addSubview(self.numberTitle)
        self.numberTitle.frame = CGRect(x: LBFMScreenWidth-165, y:80, width: 150, height: 20)
   
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: 119, width:LBFMScreenWidth-30, height: 1)
    }
    var goodRefundModel:YDorderDetailGoodsModel? {
        didSet {
            guard let model = goodRefundModel else {return}
            self.selectBtn.isHidden = model.isShow ?? true
            self.selectBtn.isSelected = model.isSelectGoods ?? false
            self.iconImage.kf.setImage(with:  URL(string: model.imageUrl ?? ""), placeholder: UIImage(named: ""))
            self.nameTitle.text =  String(format:"%@ %@%@", model.goodsName ?? "",model.weight ?? "",model.unitName ?? "")
            self.prickTitle.text = String(format: "¥%.2f",model.salePrice ?? 0)
            self.numberTitle.text = String(format: "x%d", model.count ?? 0)
            
        }
    }

    @objc func isGoodsSelectButtonClick(select:UIButton){
        delegate?.isSelectGoodsRefundListTableViewCell(isSelect:select)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
