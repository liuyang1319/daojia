//
//  YDClassifyHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/4.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDClassifyHeaderViewDelegate:NSObjectProtocol {
    //    全部商品
    func reconAllGoodsListHeaderView()
    //    全部价格排序
    func reconPriceGoodsListHeaderView(rankButton:UIButton)
//    全部销量排序
    func reconVolumeGoodsListHeaderView()
}
class YDClassifyHeaderView: UICollectionReusableView {
    weak var delegate : YDClassifyHeaderViewDelegate?
    private lazy var allButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(reconAllGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("综合", for: UIControl.State.normal)
        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    private lazy var priceButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(reconPriceGoodsListButtonClick(rankButton:)), for: UIControl.Event.touchUpInside)
        button.setTitle("价格", for: UIControl.State.normal)
        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    private lazy var volumeButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)

        button.addTarget(self, action: #selector(reconVolumeGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("销量", for: UIControl.State.normal)
        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    lazy var imageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(self.imageView)
        if isIphoneX == true{
            self.imageView.frame = CGRect(x:15, y: 15, width: LBFMScreenWidth-130, height: 85)
        }else{
            self.imageView.frame = CGRect(x:15, y: 15, width: LBFMScreenWidth-110, height: 85)
        }
    }
    var bannersImage : String = ""{
        didSet {
            self.imageView.kf.setImage(with: URL(string:bannersImage))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
//  全部商品
    @objc func reconAllGoodsListButtonClick(){
        if self.allButton.isSelected == true {
            self.allButton.isSelected = false
            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
        }else{
            self.priceButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
            self.allButton.layer.borderColor = YDLabelColor.cgColor
            self.priceButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.isSelected = true
            self.priceButton.isSelected = false
            self.volumeButton.isSelected  = false
        }
        delegate?.reconAllGoodsListHeaderView()
    }
//  全部商品价格
    @objc func reconPriceGoodsListButtonClick(rankButton:UIButton){
        if self.priceButton.isSelected == true {
            self.priceButton.isSelected = false
            self.priceButton.setTitleColor(YDLabelColor, for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "orde_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YDLabelColor.cgColor
        }else{
            self.volumeButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "order_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YDLabelColor.cgColor
            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.isSelected = false
            self.priceButton.isSelected = true
            self.volumeButton.isSelected  = false
        }
        delegate?.reconPriceGoodsListHeaderView(rankButton:rankButton)
    }
//  全部商品销量
    @objc func reconVolumeGoodsListButtonClick(){
        if self.volumeButton.isSelected == true {
          self.volumeButton.isSelected = false
          self.volumeButton.setTitleColor(YDLabelColor, for: UIControl.State.normal)
        }else{
            self.priceButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YDLabelColor.cgColor
            self.allButton.isSelected = false
            self.priceButton.isSelected = false
            self.volumeButton.isSelected  = true
        }
        delegate?.reconVolumeGoodsListHeaderView()
    }
}
