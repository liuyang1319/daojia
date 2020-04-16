//
//  YDServerLinkmanHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/29.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDServerLinkmanHeaderView: UITableViewHeaderFooterView {
    var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()

    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "帮助中心"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        return label
    }()

    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    func setUpLayout(){
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 15, width: LBFMScreenWidth-30, height: 55)

        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:15, y: 15, width: 200, height: 20)

        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: 49, width: LBFMScreenWidth-30, height: 1)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
