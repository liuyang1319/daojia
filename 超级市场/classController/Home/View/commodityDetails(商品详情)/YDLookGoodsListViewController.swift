//
//  YDLookGoodsListViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDLookGoodsListViewController: YDBasicViewController {
    var goodListModel:[YDOrderGoodListModel]?
    let YDLookGoodsListTableViewCellID = "YDLookGoodsListTableViewCell"
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(YDLookGoodsListTableViewCell.self, forCellReuseIdentifier: YDLookGoodsListTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商品列表"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.view.addSubview(self.tableView)

    }
//    var goodListModel:[YDOrderGoodListModel]? {
//        didSet{
//            guard let model = goodListModel else { return }
//        }
//    }
}
extension YDLookGoodsListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.goodListModel!.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDLookGoodsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDLookGoodsListTableViewCellID, for: indexPath) as! YDLookGoodsListTableViewCell
        //        cell.delegate = self
        cell.goodListModel = self.goodListModel![indexPath.row]
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
}
