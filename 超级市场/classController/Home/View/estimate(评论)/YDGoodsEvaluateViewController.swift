//
//  YDGoodsEvaluateViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MJRefresh
class YDGoodsEvaluateViewController: YDBasicViewController {
    var listCode = String()
    var tableView: UITableView!
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    let YDGoodsEvaluateTableViewCellID = "YDGoodsEvaluateTableViewCell"
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y:LBFMNavBarHeight, width:LBFMScreenWidth, height: LBFMScreenHeight - LBFMNavBarHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.mj_header = header
        tableView.tableFooterView = UIView()
        tableView.register(YDGoodsEvaluateTableViewCell.self, forCellReuseIdentifier: YDGoodsEvaluateTableViewCellID)
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        self.view.addSubview(tableView)
    }
    lazy var goodsEvaluateViewModel: YDGoodsEvaluateViewModel = {
        return YDGoodsEvaluateViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商品评价"
        self.view.backgroundColor = UIColor.white
        header.setRefreshingTarget(self, refreshingAction: #selector(YDGoodsEvaluateViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        initTableView()
        requestSearchGoodsDate()
    }
    //    下啦刷新
    @objc func headerRefresh(){
        requestSearchGoodsDate()
    }
    func requestSearchGoodsDate(){
        // 加载数据
        goodsEvaluateViewModel.updateDataBlock = { [unowned self] in
//            self.tableView.uHead.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        goodsEvaluateViewModel.refreshDataSource(code: listCode)
    }
}

extension YDGoodsEvaluateViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsEvaluateViewModel.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return goodsEvaluateViewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDGoodsEvaluateTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodsEvaluateTableViewCellID, for: indexPath) as! YDGoodsEvaluateTableViewCell
        cell.goodEvaluateModel = goodsEvaluateViewModel.homeGoodsEvaluateList![indexPath.row]
        if goodsEvaluateViewModel.homeGoodsEvaluateList![indexPath.row].able?.isEmpty != true{
            cell.nameArray = goodsEvaluateViewModel.homeGoodsEvaluateList![indexPath.row].able?.components(separatedBy:",")
        }else{
            cell.nameArray = []
        }
        cell.goodsImage1.tag = indexPath.row
        cell.goodsImage2.tag = indexPath.row
        cell.goodsImage3.tag = indexPath.row
        cell.goodsImage4.tag = indexPath.row
        cell.delegate = self
//        print("----------------%@",cell.nameArray)
        return cell
    }

}
extension YDGoodsEvaluateViewController:YDGoodsEvaluateTableViewCellDelegate{
    func getSelectLookGoodsImage(selectImage: UIImageView) {
        let bigImageArray = goodsEvaluateViewModel.homeGoodsEvaluateList![selectImage.tag].imageUrl?.components(separatedBy:",") ?? []
        let vc = YHPhotoBrowserController.photoBrowser(selectedIndex:0, urls: [bigImageArray[0]], parentImageViews: [selectImage])
        self.present(vc, animated: true, completion: nil)
    }
    
    func get1SelectLookGoodsImage(selectImage: UIImageView) {
        let bigImageArray = goodsEvaluateViewModel.homeGoodsEvaluateList![selectImage.tag].imageUrl?.components(separatedBy:",") ?? []
        let vc = YHPhotoBrowserController.photoBrowser(selectedIndex:0, urls: [bigImageArray[1]], parentImageViews: [selectImage])
        self.present(vc, animated: true, completion: nil)
    }
    
    func get2SelectLookGoodsImage(selectImage: UIImageView) {
        let bigImageArray = goodsEvaluateViewModel.homeGoodsEvaluateList![selectImage.tag].imageUrl?.components(separatedBy:",") ?? []
        let vc = YHPhotoBrowserController.photoBrowser(selectedIndex:0, urls: [bigImageArray[2]], parentImageViews: [selectImage])
        self.present(vc, animated: true, completion: nil)
    }
    
    func get3SelectLookGoodsImage(selectImage: UIImageView) {
        let bigImageArray = goodsEvaluateViewModel.homeGoodsEvaluateList![selectImage.tag].imageUrl?.components(separatedBy:",") ?? []
        let vc = YHPhotoBrowserController.photoBrowser(selectedIndex:0, urls: [bigImageArray[3]], parentImageViews: [selectImage])
        self.present(vc, animated: true, completion: nil)
    }
}
