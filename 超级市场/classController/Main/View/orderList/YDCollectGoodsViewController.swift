//
//  YDCollectGoodsViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import MJRefresh
class YDCollectGoodsViewController: YDBasicViewController {
    
    let YDCollectGoodsTableViewCellID = "YDCollectGoodsTableViewCell"
    let YDPublicTitleFooterViewID = "YDPublicTitleFooterView"
    var selectGoods = [String]()
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+10, width:LBFMScreenWidth, height:LBFMScreenHeight-LBFMNavBarHeight-10), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_header = header
//        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        tableView.register(YDCollectGoodsTableViewCell.self, forCellReuseIdentifier: YDCollectGoodsTableViewCellID)
        tableView.register(YDPublicTitleFooterView.self, forHeaderFooterViewReuseIdentifier: YDPublicTitleFooterViewID)
        return tableView
    }()
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitle("编辑", for: UIControl.State.normal)
        button.setTitle("完成", for: UIControl.State.selected)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.isHidden = true
        return backView
    }()
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selectAllGoodsListButtonClick(selectGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var allLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.text = "全选"
        return label
    }()

    
    lazy var selectDelete : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "delete_iamge"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("删除", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectDeleteAllGoodsListButtonClick(selectDelete:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    lazy var collectGoodsListModel: YDCollectGoodsViewModel = {
        return YDCollectGoodsViewModel()
    }()
    
    lazy var backLabel :UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        header.setRefreshingTarget(self, refreshingAction: #selector(YDCollectGoodsViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        setupLoadData()
        
        self.view.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 10)
        
        self.view.addSubview(self.backView)
        if isIphoneX == true{
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-84, width: LBFMScreenWidth, height: 84)
        }else{
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-50, width: LBFMScreenWidth, height: 50)
        }

        self.backView.addSubview(self.selectBtn)
        self.selectBtn.frame = CGRect(x:15, y: 10, width: 30, height: 30)
        
        self.backView.addSubview(self.allLabel)
        self.allLabel.frame = CGRect(x: self.selectBtn.frame.maxX+15, y:10, width: 25, height: 30)

        self.backView.addSubview(self.selectDelete)
        self.selectDelete.frame = CGRect(x:LBFMScreenWidth - 110, y:10, width:95, height: 30)
    }
    //    下啦刷新
    @objc func headerRefresh(){
        setupLoadData()
    }
    func setupLoadData() {
        // 加载数据
        collectGoodsListModel.updateDataBlock = { [unowned self] in
            self.tableView.mj_header.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        collectGoodsListModel.refreshCollectGoodsListDataSource(deviceNumber: uuid ?? "")
    }
    
    //  编辑
    @objc func rightBarButtonClick(selectBtn:UIButton){
        selectBtn.isSelected = !selectBtn.isSelected
        if selectBtn.isSelected != true {
            if collectGoodsListModel.goodsListModel?.count ?? 0 > 0{
                for (index,var model) in (collectGoodsListModel.goodsListModel?.enumerated())! {
                    model.isShow = false
                    collectGoodsListModel.goodsListModel?.remove(at:index)
                    collectGoodsListModel.goodsListModel?.insert(model, at: index)
                }
                self.tableView.reloadData()
            }
            self.selectBtn.isSelected = false
            if isIphoneX == true{
                self.tableView.frame = CGRect(x: 0, y: LBFMNavBarHeight+10, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-10)
            }else{
                self.tableView.frame = CGRect(x: 0, y: LBFMNavBarHeight+10, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-10)
            }
            self.backView.isHidden = true
        }else{
            if collectGoodsListModel.goodsListModel?.count ?? 0 > 0{
                for (index,var model) in (collectGoodsListModel.goodsListModel?.enumerated())! {
                    model.isShow = true
                    collectGoodsListModel.goodsListModel?.remove(at:index)
                    collectGoodsListModel.goodsListModel?.insert(model, at: index)
                }
                self.tableView.reloadData()
            }
            if isIphoneX == true{
                self.tableView.frame = CGRect(x: 0, y: LBFMNavBarHeight+10, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-94)
            }else{
                self.tableView.frame = CGRect(x: 0, y: LBFMNavBarHeight+10, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-60)
            }
            self.backView.isHidden = false
        }
      
    }
    
//    删除全选
    @objc func selectAllGoodsListButtonClick(selectGoods:UIButton){
        selectGoods.isSelected = !selectGoods.isSelected
        if selectGoods.isSelected == true{
            if collectGoodsListModel.goodsListModel?.count ?? 0 > 0{
                self.selectGoods.removeAll()
                for (index,var model) in (collectGoodsListModel.goodsListModel?.enumerated())! {
                    model.isShow = true
                    model.isSelect = true
                    self.selectGoods.append(model.code ?? "")
                    collectGoodsListModel.goodsListModel?.remove(at:index)
                    collectGoodsListModel.goodsListModel?.insert(model, at: index)
                }
                self.selectDelete.setTitle(String(format:"删除(%d)",self.selectGoods.count), for: UIControl.State.normal)
                self.tableView.reloadData()
            }
        }else{
            if collectGoodsListModel.goodsListModel?.count ?? 0 > 0{
                self.selectGoods.removeAll()
                for (index,var model) in (collectGoodsListModel.goodsListModel?.enumerated())! {
                    model.isShow = true
                    model.isSelect = false
                    collectGoodsListModel.goodsListModel?.remove(at:index)
                    
                    collectGoodsListModel.goodsListModel?.insert(model, at: index)
                }
                self.selectDelete.setTitle("删除", for: UIControl.State.normal)
                self.tableView.reloadData()
            }
        }
   
    }
    //    删除
    @objc func selectDeleteAllGoodsListButtonClick(selectDelete:UIButton){
        if self.selectGoods.count > 0{
            let code = self.selectGoods.joined(separator: ",")
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            YDHomeProvider.request(.setMainCollectionGoodsDeleteList(goodsCode:code,deviceNumber:uuid ?? "")) { result in
                if case let .success(response) = result {
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    print("-------%@",json)
                    if json["success"] == true{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = "删除成功"
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
                            for (index,var goods) in (self.collectGoodsListModel.goodsListModel?.enumerated())!{
                                goods.isShow = false
                                self.collectGoodsListModel.goodsListModel?.remove(at:index)
                                self.collectGoodsListModel.goodsListModel?.insert(goods, at: index)
                            }
                            for model in self.selectGoods{
                                for (index, goods) in (self.collectGoodsListModel.goodsListModel?.enumerated())!{
                                    if goods.code == model{
                                    self.collectGoodsListModel.goodsListModel?.remove(at:index)
                                    }
                                }
                            }
                            self.rightBarButton.setTitle("编辑", for: UIControl.State.normal)
                            self.rightBarButton.isSelected = false
                            self.backView.isHidden = true
                            self.tableView.frame = CGRect(x: 0, y: LBFMNavBarHeight+10, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-10)
                            self.tableView.reloadData()
                       
                    }else{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "删除失败"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                    }
                }
            }
        }
    }
}
extension YDCollectGoodsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collectGoodsListModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDCollectGoodsTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDCollectGoodsTableViewCellID, for: indexPath) as! YDCollectGoodsTableViewCell
        cell.collectGoodsListModel = collectGoodsListModel.goodsListModel![indexPath.row]
        cell.isSelectButton.tag = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goodsModel = collectGoodsListModel.goodsListModel![indexPath.row]
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = goodsModel.goodsId ?? ""
        goodsVC.goodsCode = goodsModel.code ?? ""
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if collectGoodsListModel.numberOfRowsInSection(section: section) > 0{
            return 0
        }else{
            return LBFMScreenHeight
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView:YDPublicTitleFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDPublicTitleFooterViewID) as! YDPublicTitleFooterView
        headerView.IntegralGoods = "您还为关注商品，快去收藏吧～"
        headerView.headImg = "invitation_Image"
        return headerView
    }
}
extension YDCollectGoodsViewController : YDCollectGoodsTableViewCellDelegate{
    func isSecctGoodsCollectTableViewCell(isSelect: UIButton) {

        isSelect.isSelected = !isSelect.isSelected
        let goodsModel = collectGoodsListModel.goodsListModel?[isSelect.tag]
        if isSelect.isSelected == true {
            if self.selectGoods.count > 0 {
                for (index,model) in self.selectGoods.enumerated(){
                    if model != goodsModel?.code{
                      self.selectGoods.append(goodsModel?.code ?? "")
                        break
                    }
                }
            }else{
                self.selectGoods.append(goodsModel?.code ?? "")
            }
            self.selectDelete.setTitle(String(format:"删除(%d)",self.selectGoods.count), for: UIControl.State.normal)
            if self.selectGoods.count == collectGoodsListModel.goodsListModel?.count {
                self.selectBtn.isSelected = true
            }else{
                self.selectBtn.isSelected = false
            }
        }else{
            if self.selectGoods.count > 0 {
                for (index,model) in self.selectGoods.enumerated(){
                    if model == goodsModel?.code{
                        self.selectGoods.remove(at: index)
                    }
                }
                if self.selectGoods.count > 0 {
                     self.selectDelete.setTitle(String(format:"删除(%d)",self.selectGoods.count), for: UIControl.State.normal)
                }else{
                    self.selectDelete.setTitle("删除", for: UIControl.State.normal)
                }
                if self.selectGoods.count == collectGoodsListModel.goodsListModel?.count {
                    self.selectBtn.isSelected = true
                }else{
                    self.selectBtn.isSelected = false
                }
            }else{
                self.selectBtn.isSelected = false
            }
        }
    }
    
    
}
