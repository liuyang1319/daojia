//
//  YDShopHeaderReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
//protocol YDShopHeaderReusableViewDelegate:NSObjectProtocol {
//    //    选择地址
//    func selectAddersListShopHeaderView()
//}
class YDShopHeaderReusableView: UIView {
//    weak var delegate : YDShopHeaderReusableViewDelegate?
    
//    var shopName = String()
    
    private static let kYDShopHeaderReusableView = "YDShopHeaderReusableView"
    
    lazy var selectBtn : UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "shop_Icon")
//        button.addTarget(self, action: #selector(selectAllGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var namelabel :UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.text = ""
        return label
    }()
    
    lazy var backLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
//    static func dequeueReusableHeaderView(tableView: UITableView) -> YDShopHeaderReusableView {
//        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kYDShopHeaderReusableView)
//        if header == nil {
//            header = YDShopHeaderReusableView.init(reuseIdentifier: kYDShopHeaderReusableView) as! YDShopHeaderReusableView
//            header.backgroundColor = UIColor.white
//            header.setUpLayout()
//        }
//
//        return header as! YDShopHeaderReusableView
//    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setUpLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var shopName : String = ""{
        didSet {
            self.namelabel.text = shopName
        }
    }
    var shopImage : String = ""{
        didSet {
            self.selectBtn.kf.setImage(with: URL(string:shopImage))
        }
    }
    func setUpLayout()  {
        self.addSubview(self.selectBtn)
        self.selectBtn.frame = CGRect(x: 15, y: 8, width: 30, height: 30)
        
        self.addSubview(self.namelabel)
        self.namelabel.frame = CGRect(x: self.selectBtn.frame.maxX+10, y: 13, width: LBFMScreenWidth-60, height: 20)
        self.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 0, y: 46, width: LBFMScreenWidth, height: 4)
    }

//
//    @objc func selectAllGoodsListButtonClick(){
//
//        self.selectBtn.isSelected = !self.selectBtn.isSelected
//        delegate?.selectAddersListShopHeaderView()
//
//    }
}
