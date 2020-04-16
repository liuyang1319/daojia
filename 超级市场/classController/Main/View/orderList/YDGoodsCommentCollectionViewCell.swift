//
//  YDGoodsCommentCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/18.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDGoodsCommentCollectionViewCellDelegate:NSObjectProtocol {
    func GoodsCommentListCollectionView(titleButton:UIButton)
}
class YDGoodsCommentCollectionViewCell: UICollectionViewCell {
     weak var delegate : YDGoodsCommentCollectionViewCellDelegate?
    lazy var titleBtn : UIButton = {
        let button = UIButton()
        button.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.sizeToFit()
        button.setTitle("", for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 0.5
        button.isSelected = true
        button.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
        button.addTarget(self, action: #selector(selectButtonClick(selectBtn:)), for: UIControl.Event.touchUpInside)
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
        
        self.titleBtn.frame = CGRect(x:0, y:0, width: (LBFMScreenWidth-80)*0.25, height: 30)
        self.addSubview(self.titleBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var selectTitleArray:String = ""{
        didSet {
          
        }
    }
    var nameArray:String = ""{
        didSet {
            print("selectTitleArray----------%d",selectTitleArray)
            print("self.nameArray----------%d",self.nameArray)

                print("selectTitleArray----------%d",selectTitleArray)
                if self.nameArray == selectTitleArray{
                    self.titleBtn.setTitle(self.nameArray, for: UIControl.State.normal)
                    self.titleBtn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
                    self.titleBtn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
                }else{
                    self.titleBtn.setTitle(self.nameArray, for: UIControl.State.normal)
                    self.titleBtn.layer.borderColor = YMColor(r: 153, g: 153, b: 153, a: 1).cgColor
                    self.titleBtn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
                }
//            }
            
//            for(index,title) in selectTitleArray.enumerated(){
//                if nameArray == title{
//                    self.titleBtn.setTitle(nameArray, for: UIControl.State.normal)
//                    self.titleBtn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
//                    self.titleBtn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
//                }else{
//                    self.titleBtn.setTitle(nameArray, for: UIControl.State.normal)
//                    self.titleBtn.layer.borderColor = YMColor(r: 153, g: 153, b: 153, a: 1).cgColor
//                    self.titleBtn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
//                }
//            }
//            if self.selectTitleArray != nameArray {
//                self.titleBtn.setTitle(nameArray, for: UIControl.State.normal)
//                self.titleBtn.layer.borderColor = YMColor(r: 153, g: 153, b: 153, a: 1).cgColor
//                self.titleBtn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
//            }else{
//                self.titleBtn.setTitle(nameArray, for: UIControl.State.normal)
//                self.titleBtn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
//                self.titleBtn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
//            }
            
        }
    }

    @objc func selectButtonClick(selectBtn:UIButton){
        
        if selectBtn.isSelected == true{
            selectBtn.isSelected = false
            selectBtn.layer.borderColor = YMColor(r: 153, g: 153, b: 153, a: 1).cgColor
            selectBtn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        }else{
            selectBtn.isSelected = true
            selectBtn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
            selectBtn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
        }
        delegate?.GoodsCommentListCollectionView(titleButton:selectBtn)
    }
}
