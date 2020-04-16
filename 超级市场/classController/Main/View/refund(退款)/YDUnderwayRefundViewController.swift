//
//  YDUnderwayRefundViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDUnderwayRefundViewController: YDBasicViewController {
    let YDUnderwayRefundHeaderViewID = "YDUnderwayRefundHeaderView"
    let YDUnderwayRefundTableViewCellID = "YDUnderwayRefundTableViewCell"
    let YDUnderwayRefundFooterViewID = "YDUnderwayRefundFooterView"
    lazy var underwayRefundViewModel: YDUnderwayRefundViewModel = {
        return YDUnderwayRefundViewModel()
    }()
    var orderNum = String()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(YDUnderwayRefundHeaderView.self, forHeaderFooterViewReuseIdentifier: YDUnderwayRefundHeaderViewID)
        tableView.register(YDUnderwayRefundFooterView.self, forHeaderFooterViewReuseIdentifier: YDUnderwayRefundFooterViewID)
        tableView.register(YDUnderwayRefundTableViewCell.self, forCellReuseIdentifier: YDUnderwayRefundTableViewCellID)
        return tableView
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "server_i_image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "退款详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.view.addSubview(self.tableView)
        requestIntegralGoodsDate()
        
    }
    func requestIntegralGoodsDate(){

            // 加载数据
            underwayRefundViewModel.updateDataBlock = { [unowned self] in
                self.tableView.reloadData()
            }
        underwayRefundViewModel.refreshOrderGoodsPayLookRefundList(orderNum:self.orderNum, token:  UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as String)

    }
    // - 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
       hw_callPhone("13482814061")
    }
  
}
extension YDUnderwayRefundViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return underwayRefundViewModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDUnderwayRefundTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDUnderwayRefundTableViewCellID, for: indexPath) as! YDUnderwayRefundTableViewCell
        cell.goodsAliRefundRecordModel = underwayRefundViewModel.goodsRefundModel?[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let model = underwayRefundViewModel.goodsPayRefundModel
//        if model?.orderStatus == "10" {
//            return 405
//        }else{
            return 360
//        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:YDUnderwayRefundHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDUnderwayRefundHeaderViewID) as! YDUnderwayRefundHeaderView
        headerView.goodsRefundRecordModel = underwayRefundViewModel.goodsPayRefundModel
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDUnderwayRefundFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDUnderwayRefundFooterViewID) as! YDUnderwayRefundFooterView
        footerView.goodsRefundRecordModel = underwayRefundViewModel.goodsPayRefundModel
        return footerView
    }
}
