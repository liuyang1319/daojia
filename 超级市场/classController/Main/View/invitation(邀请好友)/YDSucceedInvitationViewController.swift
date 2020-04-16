//
//  YDSucceedInvitationViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
class YDSucceedInvitationViewController: YDBasicViewController ,LTTableViewProtocal{
    private var playDetailAlbum:YDIntegralListGoodsModel?
    private let YDSucceedInvitationTableViewCellID = "YDSucceedInvitationTableViewCell"
    let YDPublicTitleFooterViewID = "YDPublicTitleFooterView"
    private let headerView = YDMainIntegralHeaderView()
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight), self, self, nil)
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        tableView.register(YDSucceedInvitationTableViewCell.self, forCellReuseIdentifier: YDSucceedInvitationTableViewCellID)
        tableView.register(YDPublicTitleFooterView.self, forHeaderFooterViewReuseIdentifier: YDPublicTitleFooterViewID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        requestSearchGoodsDate()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    lazy var invitationFriendModel: YDInvitationFriendViewModel = {
        return YDInvitationFriendViewModel()
    }()
    func requestSearchGoodsDate(){
        // 加载数据
        invitationFriendModel.updateDataBlock = { [unowned self] in
            self.tableView.reloadData()
        }
        invitationFriendModel.refreshInvitationFriendList(token: UserDefaults.LoginInfo.string(forKey: .token)!, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)!)
    }
}
extension YDSucceedInvitationViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitationFriendModel.inviteLogsModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDSucceedInvitationTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDSucceedInvitationTableViewCellID, for: indexPath) as! YDSucceedInvitationTableViewCell
        cell.inviteSPresentModel = invitationFriendModel.inviteLogsModel?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if invitationFriendModel.inviteLogsModel?.count ?? 0 > 0{
            return 0
        }else{
            return LBFMScreenHeight
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView:YDPublicTitleFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDPublicTitleFooterViewID) as! YDPublicTitleFooterView
        headerView.IntegralGoods = "您还未有成功邀请记录"
        headerView.headImg = "invitation_Image"
        return headerView
    }
}
