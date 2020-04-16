//
//  YDGoodsTableViewCell.swift
//  超级市场
//
//  Created by mac on 2020/4/16.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDGoodsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 购物车按钮
    lazy var addGoods : UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(named:"cartImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addSelectGoodsCart(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // 购物车数量
    lazy var amontCart : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 11)
        //画一个圆圈
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 7.5
        label.layer.masksToBounds = true
        //        label.isHidden = true
        return label
    }()
    
    /*
     添加到购物车
     */
    @objc func addSelectGoodsCart(selectBtn: UIButton) {
        
    }
}
