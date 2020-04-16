//
//  YDPastDueViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
class YDPastDueViewController: YDBasicViewController ,LTTableViewProtocal{
    private var playDetailAlbum:YDIntegralListGoodsModel?
    private let YDMainIntegralTableViewCellID = "YDMainIntegralTableViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight), self, self, nil)
        tableView.tableFooterView =  UIView.init(frame: CGRect.zero)
        tableView.register(YDMainIntegralTableViewCell.self, forCellReuseIdentifier: YDMainIntegralTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
}
extension YDPastDueViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDMainIntegralTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDMainIntegralTableViewCellID, for: indexPath) as! YDMainIntegralTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        //            cell.playDetailAlbumModel = self.playDetailAlbum
        return cell
        
    }
}
