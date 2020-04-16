//
//  YDUnusedCouponViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MJRefresh
class YDUnusedCouponViewController: YDBasicViewController {
    let YDGoodCouponTableViewCellID = "YDGoodCouponTableViewCell"
    var youLikeModel = [YDHomeYouLikeListModel]()
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    var cartCount = Int()
    // 懒加载顶部头视图
    private lazy var footerView:YDHomeRecommendView = {
        let height = 60+(self.youLikeModel.count*135)
        let view = YDHomeRecommendView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height: CGFloat(height)))
        view.delegate = self
        view.heightFloat = CGFloat(height)
        view.youLikeGoodsModel = self.youLikeModel
        return view
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight-44-LBFMNavBarHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
         tableView.mj_header = header
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = footerView
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        tableView.register(YDGoodCouponTableViewCell.self, forCellReuseIdentifier: YDGoodCouponTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的优惠劵"
        header.setRefreshingTarget(self, refreshingAction: #selector(YDUnusedCouponViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        requestrecommendGoodsDate()
        requestSearchGoodsDate()
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
    }
    //    下啦刷新
    @objc func headerRefresh(){
        requestSearchGoodsDate()
    }
    lazy var couponListModel: YDGoodCouponViewMdeol = {
        return YDGoodCouponViewMdeol()
    }()
    func requestSearchGoodsDate(){
        // 加载数据
        couponListModel.updateDataBlock = { [unowned self] in
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
        couponListModel.refreshCouponDataSource(status: "1",token:(UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)
    }
    //    为你推荐
    func requestrecommendGoodsDate(){
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        YDHomeProvider.request(.getHomeGoodsRecommendList(deviceNumber:uuid)){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        if let mappedObject = JSONDeserializer<YDHomeYouLikeListModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.youLikeModel = mappedObject as! [YDHomeYouLikeListModel]
                            self.view.addSubview(self.tableView)
                            self.tableView.reloadData()
                        }
                    }
                }
                }
            }
        }
    }
    
}
extension YDUnusedCouponViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return couponListModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDGoodCouponTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodCouponTableViewCellID, for: indexPath) as! YDGoodCouponTableViewCell
        //        cell.delegate = self
        cell.couponContentsModel = couponListModel.couponListModel![indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
extension YDUnusedCouponViewController : YDHomeRecommendViewDelegate{
    func addSelectYouLikeGoodsTableViewCell(goodListModel: YDHomeYouLikeListModel) {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let userDeviceNumber = uuid ?? ""
        let userMemberId = UserDefaults.LoginInfo.string(forKey:.id) ?? ""
        
        YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: goodListModel.goodsCode ?? "", count:1,deviceNumber: userDeviceNumber,memberId:userMemberId,status:1)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    self.view.makeToast("已加入购物车", duration: 1.0, position: .center)
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount += 1
                    
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                }
            }else{
                self.view.makeToast("加入购物车失败", duration: 1.0, position: .center)
            }
        }
    }
    
     func addSelectYouLikeIndexTableViewCell(selectModel: YDHomeYouLikeListModel) {
          
          let goodsVC = YDShoppingViewController()
          goodsVC.goodsId = selectModel.id ?? ""
          goodsVC.goodsCode = selectModel.goodsCode ?? ""
          self.navigationController?.pushViewController(goodsVC, animated: true)
      }
}
