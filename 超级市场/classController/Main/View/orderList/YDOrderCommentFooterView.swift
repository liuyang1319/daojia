//
//  YDOrderCommentFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/16.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDOrderCommentFooterViewDelegate:NSObjectProtocol {
    //    商品折叠
    func selectGoodsListFoldFooterView(goodsliset:UIButton)
}
class YDOrderCommentFooterView: UITableViewHeaderFooterView ,JNStarReteViewDelegate{
    
     weak var delegate : YDOrderCommentFooterViewDelegate?
    lazy var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var lineLabel :UILabel = {
        let backView = UILabel()
        backView.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return backView
    }()
    lazy var listButton :UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(lookSelectGoodslistButtonClick(GoodsList:)), for: UIControl.Event.touchUpInside)
        button.isSelected = false
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "message_down"), for: UIControl.State.normal)
        button.setTitle("共0件商品可评价", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        return button
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 40)
        
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x:0, y: 1, width: LBFMScreenWidth-30, height: 1)
        
        self.backView.addSubview(self.listButton)
        self.listButton.frame = CGRect(x: (LBFMScreenWidth-230)*0.5, y: 5, width: 200, height: 30)
        
    }
    var goodsCount : Int = 0 {
        didSet {
            self.listButton.setTitle("共\(goodsCount)件商品可评价", for: UIControl.State.normal)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //    折叠商品
    @objc func lookSelectGoodslistButtonClick(GoodsList:UIButton){
        delegate?.selectGoodsListFoldFooterView(goodsliset:GoodsList)
    }
}
