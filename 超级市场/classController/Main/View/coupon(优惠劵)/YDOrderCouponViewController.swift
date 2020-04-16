//
//  YDOrderCouponViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class YDOrderCouponViewController: YDBasicViewController {
    let YDPastCouponTableViewCellID = "YDPastCouponTableViewCell"
    var couponListModel = [YDCouponDetailGoodsModel]()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+10, width:LBFMScreenWidth, height:LBFMScreenHeight-10), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.register(YDPastCouponTableViewCell.self, forCellReuseIdentifier: YDPastCouponTableViewCellID)
        return tableView
    }()
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitleColor(YDLabelColor, for: UIControl.State.normal)
        button.setTitle("不使用", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的优惠劵"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.view.addSubview(self.tableView)
       
    }
//    不使用
    @objc func rightBarButtonClick(selectBtn:UIButton){
        //        选择优惠劵
        
        NotificationCenter.default.post(name: NSNotification.Name.init("selectGoodsOrderCoupon"), object:"",userInfo: ["couponId":"","couponCount":couponListModel.count])
        self.navigationController?.popViewController(animated: true)
    }
}
extension YDOrderCouponViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return couponListModel.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDPastCouponTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDPastCouponTableViewCellID, for: indexPath) as! YDPastCouponTableViewCell
        //        cell.delegate = self
        cell.couponContentsModel = couponListModel[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = couponListModel[indexPath.row]
//        选择优惠劵
        NotificationCenter.default.post(name: NSNotification.Name.init("selectGoodsOrderCoupon"), object:listModel.price ,userInfo:["couponId":listModel.couponId,"couponCount":0])
        self.navigationController?.popViewController(animated: true)
    }
}


