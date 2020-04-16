//
//  YDGoodsCategoryViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//
private let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)

import UIKit
import LTScrollView
import SwiftyJSON
import HandyJSON

class YDGoodsCategoryViewController: UIViewController , LTTableViewProtocal{
    let YDGoodsOneTableViewCellID = "YDGoodsOneTableViewCell"
    let YDGoodsTwoTableViewCellID = "YDGoodsTwoTableViewCell"
    let YDGoodsThreeTableViewCellID = "YDGoodsThreeTableViewCell"
    var nameStr = String()
    var nameId = String()
    var goodsCount = Int()
    private lazy var tableView: UITableView = {
        let iPhoneXH = view.bounds.height - 166
        let otherH = view.bounds.height - 64 - 44
        let H: CGFloat = glt_iphoneX ? iPhoneXH : otherH
        let tableView = tableViewConfig(CGRect(x: 0, y:44, width: view.bounds.width, height: H), self, self, nil)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.register(YDGoodsOneTableViewCell.self, forCellReuseIdentifier: YDGoodsOneTableViewCellID)
        tableView.register(YDGoodsTwoTableViewCell.self, forCellReuseIdentifier: YDGoodsTwoTableViewCellID)
        tableView.register(YDGoodsThreeTableViewCell.self, forCellReuseIdentifier: YDGoodsThreeTableViewCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsCategoryListMain(nofit:)), name: NSNotification.Name(rawValue:"YDGoodsCategoryMainController"), object: nil)
        view.addSubview(tableView)
        glt_scrollView = tableView
        reftreshData()
        if #available(iOS 11.0, *) {
            glt_scrollView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    @objc func refreshGoodsCategoryListMain(nofit:Notification) {
        self.nameStr = nofit.userInfo!["nameStr"] as! String
        self.nameId = nofit.userInfo!["nameId"] as! String
        refreshDataSource()
       
    }
    var readCategoryListModel = [YDGoodsCategoryListModel]()
    var readCategoryModel = [YDGoodsCategoryListModel]()
    
    func refreshDataSource() {
        YDHomeProvider.request(.getReadCategoryGoodsActivityList(id:nameId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["data"]["categorylist"].count > 0{
                    if let mappedObject = JSONDeserializer<YDGoodsCategoryListModel>.deserializeModelArrayFrom(json: json["data"]["categorylist"].description) {
                        self.readCategoryListModel = (mappedObject as? [YDGoodsCategoryListModel])!
                        self.readCategoryModel = (mappedObject as? [YDGoodsCategoryListModel])!
                        self.tableView.reloadData()
                    }
                }
                }
            }
        }
    }
    
}

extension YDGoodsCategoryViewController {
    fileprivate func reftreshData()  {
//        self.tableView.mj_footer = MJRefreshBackNormalFooter {[weak self] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                print("上拉加载更多数据")
//                self?.tableView.mj_footer.endRefreshing()
//            })
//        }
    }
}


extension YDGoodsCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.readCategoryListModel.count == 0 {
            return 1
        }else if self.readCategoryListModel.count == 1{
            return 2
        }else {
            return 3
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:YDGoodsOneTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodsOneTableViewCellID, for: indexPath) as! YDGoodsOneTableViewCell
            cell.titleName = self.nameStr
            return cell
        }else if indexPath.row == 1{
            let cell:YDGoodsTwoTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodsTwoTableViewCellID, for: indexPath) as! YDGoodsTwoTableViewCell
            cell.goodsCategoryModel = self.readCategoryListModel[0]
            return cell
        }else {
            let cell:YDGoodsThreeTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodsThreeTableViewCellID, for: indexPath) as! YDGoodsThreeTableViewCell
            self.readCategoryListModel.remove(at: 0)
            cell.goodsCategoryModel = self.readCategoryListModel
            if (self.readCategoryListModel.count)%3 == 0 {
                self.goodsCount = (self.readCategoryListModel.count)/3
            }else{
                self.goodsCount = ((self.readCategoryListModel.count)/3) + 1
            }
            cell.delegate = self
            cell.heightFloat = CGFloat(210 * self.goodsCount)
            return cell

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let model = self.readCategoryModel[0]
            let goodsVC = YDShoppingViewController()
            goodsVC.goodsId = model.id ?? ""
            goodsVC.goodsCode = model.code ?? ""
            self.navigationController?.pushViewController(goodsVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
             return 60
        }else if indexPath.row == 1 {
            return 135
        }else{
            return CGFloat(210 * self.goodsCount)
        }
       
    }
}
//  进入详情页
extension YDGoodsCategoryViewController: YDGoodsThreeTableViewCellDelegate{
    func addSelectGoodsThreeTableViewCell(selectId: String, goodsCode: String) {
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = selectId
        goodsVC.goodsCode = goodsCode
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
}
