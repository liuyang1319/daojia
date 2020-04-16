//
//  YDTableView.swift
//  超级市场
//
//  Created by 云达 on 2020/4/14.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        tableFooterView = UIView.init(frame: .zero)
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
