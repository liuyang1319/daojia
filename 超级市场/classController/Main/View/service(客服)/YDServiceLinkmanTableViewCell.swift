//
//  YDServiceLinkmanTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/29.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDServiceLinkmanTableViewCell: UITableViewCell {
    var countNum = Int()
    var backView : UIView = {
        let Image = UIView()
        Image.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return Image
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    var arrowsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"list_right_image")
        return imageView
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
//        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        setUpLayout()
    }
    func setUpLayout(){

        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 50)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:15, y: 15, width: 200, height: 20)
        
        self.backView.addSubview(self.arrowsImage)
        self.arrowsImage.frame = CGRect(x: LBFMScreenWidth-40, y: 20, width: 5, height: 10)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: 49, width: LBFMScreenWidth-30, height: 1)
    }
    var number : Int = 0 {
        didSet {
            self.countNum = number + 1
        }
    }
    var serviceHelpListModel:YDServiceHelplistInfoModel? {
        didSet {
            guard let model = serviceHelpListModel else {return}
            self.titleLabel.text = String(format: "%d.%@",self.countNum,model.problem ?? "")
        }
    }    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }


}
