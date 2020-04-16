//
//  YDUserInvoiceViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUserInvoiceViewController: YDBasicViewController {
    // 懒加载顶部头视图
    private lazy var headerView:YDUserInvoiceHeaderView = {
        let view = YDUserInvoiceHeaderView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height: 60))
        view.delegate = self
        return view
    }()
    let YDUserInvoiceTableViewCellID = "YDUserInvoiceTableViewCell"
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.register(YDUserInvoiceTableViewCell.self, forCellReuseIdentifier: YDUserInvoiceTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我得发票抬头"
        self.view.addSubview(tableView)
    }
}
extension YDUserInvoiceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDUserInvoiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDUserInvoiceTableViewCellID, for: indexPath) as! YDUserInvoiceTableViewCell
        //        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lookVC = YDUserLookInvoiceViewController()
        self.navigationController?.pushViewController(lookVC, animated: true)
    }
}
extension YDUserInvoiceViewController :YDUserInvoiceHeaderViewDelegate{
    func addUserInvoiceListHeaderView() {
        let addInvoice = YDUserAddInvoiceViewController()
        self.navigationController?.pushViewController(addInvoice, animated: true)
    }
}
