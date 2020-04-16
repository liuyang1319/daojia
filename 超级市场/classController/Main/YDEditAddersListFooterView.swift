//
//  YDEditAddersListFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/18.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDEditAddersListFooterViewDelegate:NSObjectProtocol {
    func newAddersListFooterView()
}
class YDEditAddersListFooterView: UITableViewHeaderFooterView {
    weak var delegate : YDEditAddersListFooterViewDelegate?
    lazy var backLabel:UILabel = {
        let label = UILabel()
//        label.isHidden = true
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    var addersImage:UIImageView = {
        let Aimage = UIImageView()
//        Aimage.isHidden = true
        Aimage.image = UIImage(named:"nullAdders_image")
        return Aimage
    }()
    
    var titleLabel : UILabel = {
        let title = UILabel()
//        title.isHidden = true
        title.text = "还没有收获地址，快去新建吧"
        title.textAlignment = .center
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return title
    }()
    
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
//        button.isHidden = true
        button.setTitle("新建地址", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 10)
        
        self.contentView.addSubview(self.addersImage)
        self.addersImage.frame = CGRect(x:(LBFMScreenWidth-200)*0.5, y:125, width: 300, height: 200)

        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:(LBFMScreenWidth-190)*0.5, y: self.addersImage.frame.maxY+70, width: 190, height: 20)
        
        self.contentView.addSubview(self.finishLabel)
        self.finishLabel.frame = CGRect(x:(LBFMScreenWidth-240)*0.5, y:self.titleLabel.frame.maxY+40, width: 240, height: 40)
    }
//    var isShow : String = ""{
//          didSet {
//            if isShow == "1"{
//                self.backLabel.isHidden = false
//                self.addersImage.isHidden = false
//                self.titleLabel.isHidden = false
//                self.finishLabel.isHidden = false
//            }
//          }
//      }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//  新建地址
    @objc func finishIphoneButtonClick(){
        delegate?.newAddersListFooterView()
    }
}
