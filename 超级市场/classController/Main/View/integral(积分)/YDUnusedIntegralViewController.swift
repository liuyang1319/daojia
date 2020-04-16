//
//  YDUnusedIntegralViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
import MJRefresh
class YDUnusedIntegralViewController: YDBasicViewController,LTTableViewProtocal{
    private var playDetailAlbum:YDIntegralListGoodsModel?
    private let YDMainIntegralTableViewCellID = "YDMainIntegralTableViewCell"
    let YDPublicTitleFooterViewID = "YDPublicTitleFooterView"
    private let headerView = YDMainIntegralHeaderView()
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight), self, self, nil)
        tableView.mj_header = header
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        tableView.register(YDMainIntegralTableViewCell.self, forCellReuseIdentifier: YDMainIntegralTableViewCellID)
        tableView.register(YDPublicTitleFooterView.self, forHeaderFooterViewReuseIdentifier: YDPublicTitleFooterViewID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        header.setRefreshingTarget(self, refreshingAction: #selector(YDUnusedIntegralViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        requestSearchGoodsDate()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    lazy var integralListModel: YDMainIntegralViewModel = {
        return YDMainIntegralViewModel()
    }()
    //    下啦刷新
    @objc func headerRefresh(){
        requestSearchGoodsDate()
    }
    func requestSearchGoodsDate(){
        // 加载数据
        integralListModel.updateDataBlock = { [unowned self] in
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
        integralListModel.refreshCouponDataSource(status: "1", token:  (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)
    }
}
extension YDUnusedIntegralViewController : UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return integralListModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell:YDMainIntegralTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDMainIntegralTableViewCellID, for: indexPath) as! YDMainIntegralTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.integralListModel = integralListModel.integralListModel?.integralList![indexPath.row]
            return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if integralListModel.numberOfRowsInSection(section: section) > 0{
            return 0
        }else{
            return LBFMScreenHeight
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView:YDPublicTitleFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDPublicTitleFooterViewID) as! YDPublicTitleFooterView
        headerView.IntegralGoods = "您还未有积分收入"
         headerView.headImg = "invitation_Image"
        return headerView
    }
}
