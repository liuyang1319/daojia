//
//  YDOrderCommentViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MJRefresh
class YDOrderCommentViewController: YDBasicViewController {
    let YDOrderListTableViewCellID = "YDOrderListTableViewCell"
    let YDMainFooterViewID = "YDMainFooterView"
    lazy var orderListViewModel: YDMainViewModel = {
        return YDMainViewModel()
    }()
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight-44-LBFMNavBarHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.mj_header = header
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.register(YDMainFooterView.self, forHeaderFooterViewReuseIdentifier: YDMainFooterViewID)
        tableView.register(YDOrderListTableViewCell.self, forCellReuseIdentifier: YDOrderListTableViewCellID)
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestClassifyGoodsDate() }
        return tableView
    }()
//    override func
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.mj_header.beginRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        header.setRefreshingTarget(self, refreshingAction: #selector(YDOrderCommentViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        requestClassifyGoodsDate()
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        self.view.addSubview(self.tableView)
        
    }
    //    下啦刷新
    @objc func headerRefresh(){
        requestClassifyGoodsDate()
    }
    func requestClassifyGoodsDate(){
        if  isUserLogin() != true{
            // 加载数据
            orderListViewModel.updateDataBlock = { [unowned self] in
                self.tableView.mj_header.endRefreshing()
                // 更新列表数据
                self.tableView.reloadData()
            }
            self.orderListViewModel.refreshDataSource(typeState:"estimate")
        }
    }
    
}
extension YDOrderCommentViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderListViewModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 275
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDOrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDOrderListTableViewCellID, for: indexPath) as! YDOrderListTableViewCell
        cell.orderGoodsListModel = self.orderListViewModel.orderListModel?[indexPath.row].list
        cell.delegate = self
        cell.commentButton.tag = indexPath.row
        cell.buyAgainButton.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.orderListViewModel.numberOfRowsInSection(section: section) <= 0{
            return LBFMScreenHeight
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDMainFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDMainFooterViewID) as! YDMainFooterView
        return footerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.orderListViewModel.orderListModel?[indexPath.row]
        let detailsVC = YDOrderDetailsViewController()
        detailsVC.orderNumber = model?.orderNum ?? ""
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
extension YDOrderCommentViewController : YDOrderListTableViewCellDelegate{
    func reconfirmGoodsPayCancelTableViewCell(cancel: UIButton) {
        
    }
    
    func reconfirmGoodsoPayMentTableViewCell(payBtn: UIButton) {
        
    }
    
    func reconfirmGoodsPayReimburseTableViewCell(Reimburse: UIButton) {
        
    }
    
    
    // MARK: --------------   评论
    func reconfirmGoodsCommentTableViewCell(commentBtn: UIButton) {
        let model = self.orderListViewModel.orderListModel?[commentBtn.tag]
        let comment =   YDGoodsCommentViewController()
        comment.orderNum =  model?.orderNum ?? ""
        self.navigationController?.pushViewController(comment, animated: true)
    }
    // MARK: --------------   再来一单
    func reconfirmGoodsBuyAgainTableViewCell(buyAgain: UIButton) {
        let modelNumber = self.orderListViewModel.orderListModel?[buyAgain.tag]
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        YDShopGoodsListProvider.request(.getOrderBuyAgainCartGoodsLikeList(orderNum: modelNumber?.orderNum ?? "", deviceNumber: uuid,token:(UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    let alertController = UIAlertController(title: "商品已加入购物车",
                                                            message: "", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "留在此页", style: .cancel, handler: {action in
                        //                        self.navigationController?.popViewController(animated: true)
                        
                    })
                    let okAction = UIAlertAction(title: "去购物车", style: .default,
                                                 handler: {action in
                                                    self.tabBarController?.selectedIndex = 2
                                                    self.navigationController?.popViewController(animated: true)
                                                    
                                                    
                    })
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    if #available(iOS 13.0, *) {
                        alertController.modalPresentationStyle = .fullScreen
                    } else {
                    }
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    func reconfirmGoodsoPayMentTableViewCell() {
        
    }
    
}
