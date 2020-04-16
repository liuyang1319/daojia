//
//  YDUserInvoiceTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUserInvoiceTableViewCell: UITableViewCell {

    lazy var nameLabel:UILabel = {
        let title = UILabel()
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.text = "云达在线(北京)科技发展有限公司"
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return title
    }()
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        title.text = "单位"
        title.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return title
    }()
    lazy var moreBtn:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowsImage"), for: UIControl.State.normal)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: 15, y: 10, width: LBFMScreenWidth-45, height: 20)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: self.nameLabel.frame.maxY+5, width: 200, height: 15)
        
        self.addSubview(self.moreBtn)
        self.moreBtn.frame = CGRect(x: LBFMScreenWidth-25, y: 22, width: 10, height: 15)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
