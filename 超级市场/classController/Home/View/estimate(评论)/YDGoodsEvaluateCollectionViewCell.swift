//
//  YDGoodsEvaluateCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDGoodsEvaluateCollectionViewCell: UICollectionViewCell {
    weak var delegate : YDGoodsCommentCollectionViewCellDelegate?
    lazy var titleBtn : UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        button.titleLabel?.sizeToFit()
        button.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 布局
        setupLayout()
    }
    // 布局
    func setupLayout() {
        
        self.backgroundColor = UIColor.white
        
        self.titleBtn.frame = CGRect(x:0, y:0, width: (LBFMScreenWidth-80)*0.25, height: 20)
        self.addSubview(self.titleBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var nameArray:String = ""{
        didSet {
            self.titleBtn.setTitle(nameArray, for: UIControl.State.normal)
        }
    }
  
}
