//
//  YDTableView+RegiestCell.swift
//  超级市场
//
//  Created by 云达 on 2020/4/14.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

extension UITableView {
    func regiestCellsForNibs(cellIds: [String]) {
        for cellId in cellIds {
            register(
                UINib.init(nibName: cellId, bundle: nil),
                forCellReuseIdentifier: cellId
            )
        }
    }
}
