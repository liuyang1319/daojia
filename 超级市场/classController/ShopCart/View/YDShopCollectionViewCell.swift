//
//  YDShopCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDShopCollectionViewCellDelegate:NSObjectProtocol {
    //    单选
    func selectIndexGoodsListCollectionViewCell(selectBtn:UIButton)
    
    func selectGoodsListPlusCollectionViewCell(goodsCount:YDShopCollectionViewCell, countBtn:UIButton,minusBtn:UIButton,label: UILabel)
    func selectGoodsListMinusCollectionViewCell(minusCount:YDShopCollectionViewCell,minusBtn:UIButton,numberLabel:UILabel)
}
class YDShopCollectionViewCell: UITableViewCell {
    
//    var number = NSInteger()
    private static let kYDShopCollectionViewCell = "YDShopCollectionViewCell"
    
    weak var delegate : YDShopCollectionViewCellDelegate?
    
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selectIndexGoodsListButtonClick(indexGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var iconImage : UIImageView = {
        let iconImage = UIImageView()
        iconImage.backgroundColor = UIColor.white
        return iconImage
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    lazy var plusBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "selectPlusImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectGoodsListPlusButtonClick(plusGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var numberLabel : UILabel = {
        let label = UILabel ()
        label.textAlignment = .center
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var minusBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "selectMiusImage_h"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectGoodsListMinusButtonClick(minusGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var linLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    static func dequeueReusableCell(tableView: UITableView) -> YDShopCollectionViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kYDShopCollectionViewCell)
        if cell == nil {
            cell = YDShopCollectionViewCell.init(style: .default, reuseIdentifier: kYDShopCollectionViewCell)
            cell?.selectionStyle = .none
        }
        
        return cell as! YDShopCollectionViewCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
//        self.number = 1
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var shopCartGoodList:YDShopCartGoodsListModel? {
        didSet{
            guard let model = shopCartGoodList else { return }
            self.selectBtn.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
            self.selectBtn.isSelected = model.selected
            self.iconImage.frame = CGRect(x: self.selectBtn.frame.maxX+10, y: 15, width: 90, height: 90)
            self.iconImage.kf.setImage(with: URL(string: model.imageUrl ?? ""))
            
            self.nameLabel.text =  String(format:"%@ %@%@", model.name ?? "",model.weight ?? "",model.unitName ?? "")

            self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 15, width: LBFMScreenWidth-160, height: heightForView(text: self.nameLabel.text!, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), width: LBFMScreenWidth-170))
            
            self.priceLabel.text = String(format:"¥%.2f",model.salePrice ?? "")
            self.priceLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 85, width:150, height: 20)
            
            self.minusBtn.frame = CGRect(x: LBFMScreenWidth-100, y: 80, width: 30, height: 30)
            if model.count <= 1 {
                self.minusBtn.setImage(UIImage(named:"selectMiusImage"), for: UIControl.State.normal)
            }else{
                self.minusBtn.setImage(UIImage(named:"selectMiusImage_h"), for: UIControl.State.normal)
            }
            self.numberLabel.text = String(format: "%d", model.count)
            self.numberLabel.frame = CGRect(x: self.minusBtn.frame.maxX, y: 85, width: 30, height: 20)
            
            self.plusBtn.frame = CGRect(x: self.numberLabel.frame.maxX, y: 80, width: 30, height: 30)
            
            self.linLabel.frame = CGRect(x: 0, y: 119, width: LBFMScreenWidth, height: 1)
        }
    }
    func setUpLayout()  {
        self.addSubview(self.selectBtn)
        
        self.addSubview(self.iconImage)
        
        
        self.addSubview(self.nameLabel)
        
        
        self.addSubview(self.priceLabel)
        
        
        self.addSubview(self.minusBtn)
        
        
        self.addSubview(self.numberLabel)
      
        
        self.addSubview(self.plusBtn)
        
        
        self.addSubview(self.linLabel)
        
        
    }
    @objc func selectIndexGoodsListButtonClick(indexGoods:UIButton){
        delegate?.selectIndexGoodsListCollectionViewCell(selectBtn: indexGoods)
    }
    
    @objc func selectGoodsListPlusButtonClick(plusGoods:UIButton){
//        var model =  shopCartGoodList
//        model?.count += 1
//        self.numberLabel.text = String(format: "%d", model!.count)
        delegate?.selectGoodsListPlusCollectionViewCell(goodsCount: self, countBtn: plusGoods, minusBtn: minusBtn, label: self.numberLabel)
    }
    @objc func selectGoodsListMinusButtonClick(minusGoods:UIButton){
        delegate?.selectGoodsListMinusCollectionViewCell(minusCount: self, minusBtn:minusBtn, numberLabel: self.numberLabel)
    }
}
