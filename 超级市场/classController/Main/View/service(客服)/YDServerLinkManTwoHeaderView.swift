//
//  YDServerLinkManTwoHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/29.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDServerLinkManTwoHeaderViewDelegate:NSObjectProtocol {
    //    编辑地址
    func serviceLinkmanLookListHeaderView(selectBtn:UIButton)
}
class YDServerLinkManTwoHeaderView: UITableViewHeaderFooterView {
    weak var delegate : YDServerLinkManTwoHeaderViewDelegate?
    var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
//        backView.layer.cornerRadius = 5
//        backView.clipsToBounds = true
        return backView
    }()
    var servarImage : UIImageView = {
        let Image = UIImageView()
        return Image
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    var arrowsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"list_down_image")
        return imageView
    }()
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
   lazy var listBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(issueListButtonClick(select:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 50)
        
        self.backView.addSubview(self.servarImage)
        self.servarImage.frame = CGRect(x: 10, y: 17.5, width: 15, height: 15)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.servarImage.frame.maxX+15, y: 15, width: 200, height: 20)
        
        self.backView.addSubview(self.arrowsImage)
        self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-55, y: 22.5, width: 10, height: 5)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: 49, width: LBFMScreenWidth-30, height: 1)
        
        self.addSubview(self.listBtn)
        self.listBtn.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 50)
    }
    
    var serviceHelpInfoModel:YDServiceHelpInfoModel? {
        didSet {
            guard let model = serviceHelpInfoModel else {return}
            self.titleLabel.text = model.Type ?? ""
            self.servarImage.kf.setImage(with:URL(string: model.icon ?? ""))
            if model.isShow == false {
                self.arrowsImage.image = UIImage(named: "list_down_image")
            }else{
                self.arrowsImage.image = UIImage(named: "list_ii_image")
            }
        }
    }
    
    var titleImage:String = ""{
        didSet{
            self.servarImage.image = UIImage(named:titleImage)
        }
    }
    
    @objc func issueListButtonClick(select:UIButton){

        delegate?.serviceLinkmanLookListHeaderView(selectBtn:select)
    }
    
}
