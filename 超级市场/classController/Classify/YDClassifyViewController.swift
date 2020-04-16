//
//  YDClassifyViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import Alamofire
class YDClassifyViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate {
    var YDClassifyCollectionViewCellID = "YDClassifyCollectionViewCell"
//    headerview
    let YDClassifyHeaderViewID = "YDClassifyHeaderView"
//    右侧cell
    let YDRightCollectionViewCellID = "YDRightCollectionViewCell"
    //    右侧cell
    let YDRightTwoCollectionViewCellID = "YDRightTwoCollectionViewCell"
//    选中商品
    var selectArray: [YDClassifyListOneModel] = []
//   选中分类名称
    var selectName = String()
//   选中分类ID
    var selectID = String()

    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:280, height: 30)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setTitle("搜索商品", for: UIControl.State.normal)
        button.setImage(UIImage(named: "searchImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 153, g: 153, b: 153, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var sectionView : UIView = {
        let sectionView = UIView()
        sectionView.backgroundColor = UIColor.white
        return sectionView
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return label
    }()
    var wifiImage :UIImageView = {
        let wifi = UIImageView()
        wifi.isHidden = true
        wifi.image = UIImage(named:"Wifi_image")
        return wifi
    }()
    var titleName:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "哇哦，网络好像不给力哦~ \n刷新下试试吧"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    var goHome : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finisMeRequestButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("重新加载", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    lazy var classifyListModel: YDClassifyListViewModel = {
        return YDClassifyListViewModel()
    }()
    lazy var classifyGoodsModel: YDClassifyListGoodsViewModel = {
        return YDClassifyListGoodsViewModel()
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y:LBFMNavBarHeight, width:80, height: LBFMScreenHeight - LBFMNavBarHeight-44), style: UITableView.Style.plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(YDClassifyCollectionViewCell.self, forCellReuseIdentifier: YDClassifyCollectionViewCellID)
        return tableView
    }()
    lazy var rightCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionHeadersPinToVisibleBounds = false //头视图悬浮
        layout.headerReferenceSize = CGSize.init(width: LBFMScreenWidth-80, height: 40)
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(YDRightCollectionViewCell.self, forCellWithReuseIdentifier: YDRightCollectionViewCellID)
        collectionView.register(YDRightTwoCollectionViewCell.self, forCellWithReuseIdentifier: YDRightTwoCollectionViewCellID)
        collectionView.register(YDClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDClassifyHeaderViewID)
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        currentNetReachability()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.localVersionInfo.set(value: "", forKey: .classifyID)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         navBarBarTintColor = YDLabelColor
//      百宝箱跳转查询
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsCategoryId(nofit:)), name: NSNotification.Name(rawValue:"YDClassifyViewCategoryId"), object: nil)

        self.view.backgroundColor = UIColor.white
        self.navigationItem.titleView = rightBarButton

        requestSearchGoodsDate()
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.rightCollectionView)
        if isIphoneX == true{
            self.tableView.frame = CGRect(x: 0, y:LBFMNavBarHeight, width:100, height: LBFMScreenHeight - LBFMNavBarHeight-44)
            self.rightCollectionView.frame = CGRect(x:100, y: 0, width:LBFMScreenWidth-100, height: LBFMScreenHeight-45)
        }else{
            self.tableView.frame = CGRect(x: 0, y:LBFMNavBarHeight, width:80, height: LBFMScreenHeight - LBFMNavBarHeight-44)
            self.rightCollectionView.frame = CGRect(x:80, y: 0, width:LBFMScreenWidth-80, height: LBFMScreenHeight-45)
        }

        
        self.view.addSubview(self.wifiImage)
        self.wifiImage.frame = CGRect(x:115, y: 140, width: 260, height: 270)
        
        self.view.addSubview(self.titleName)
        self.titleName.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y:self.wifiImage.frame.maxY+10, width: 180, height: 40)
        
        self.view.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y:self.titleName.frame.maxY+30, width: 240, height: 40)
    }

    func currentNetReachability() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.rightCollectionView.isHidden = true
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.rightCollectionView.isHidden = true
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                }
                self.wifiImage.isHidden = true
                self.titleName.isHidden = true
                self.goHome.isHidden = true
                self.rightCollectionView.isHidden = false
                self.tableView.isHidden = false
            }
            
            //            self.debugLog(statusStr as Any)
        }
        manager?.startListening()
    }
    //    重新加载
    @objc func finisMeRequestButtonClick(){
        currentNetReachability()
        requestSearchGoodsDate()
        self.tableView.reloadData()
        self.rightCollectionView.reloadData()
        self.tableView.isHidden = false
        self.rightCollectionView.isHidden = false
    }
    //    搜索
    @objc func rightBarButtonClick(){
        let searchVC = YDHomeSearchBarViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    //    商品分类
    func requestSearchGoodsDate(){
        // 加载数据
        self.selectName = ""
        self.selectID = ""
        classifyListModel.updateDataBlock = { [unowned self] in
            self.selectArray = self.classifyListModel.classfiyOneListModel!
            if String(UserDefaults.localVersionInfo.string(forKey:.classifyID) ?? "").isEmpty != true {
                for (index,var model) in self.selectArray.enumerated(){
                    if self.selectArray[index].id == UserDefaults.localVersionInfo.string(forKey: .classifyID){
                        self.selectName = model.name ?? ""
                        self.selectID = model.id ?? ""
                        self.requestClassifyGoodsDate(id: model.id ?? "0")
                        self.tableView.reloadData()
                        self.tableView.selectRow(at:IndexPath(row:index, section:0) , animated: true, scrollPosition: UITableView.ScrollPosition.none)
                    }
                }
            }else{
                if self.selectArray.count > 0{
                    let model = self.selectArray[0]
                    self.selectName = model.name ?? ""
                    self.selectID = model.id ?? ""
                    self.requestClassifyGoodsDate(id: model.id ?? "0")
                    self.tableView.reloadData()
                    self.tableView.selectRow(at:IndexPath(row:0, section:0) , animated: true, scrollPosition: UITableView.ScrollPosition.none)
                }
            }
        }
        classifyListModel.refreshClassfiyDataSource()
    }
//    分类商品
    func requestClassifyGoodsDate(id:String){
        // 加载数据
        classifyGoodsModel.updateDataBlock = { [unowned self] in
//             EWMBProgressHud.hideHud()
            // 更新列表数据
            self.rightCollectionView.reloadData()
        }
//        EWMBProgressHud.showLoadingHudView(message: "", isTranslucent: true)
        
        classifyGoodsModel.refreshClassifyGoodsDataSource(id: id)
    }
    // MARK: -    百宝箱查询
    @objc func refreshGoodsCategoryId(nofit:NSNotification) {
        self.selectArray = self.classifyListModel.classfiyOneListModel!
        for (index,var value) in self.selectArray.enumerated(){
            if self.selectArray[index].id == nofit.userInfo?["categoryId"] as? String {
                let model = self.selectArray[index]
                self.requestClassifyGoodsDate(id: model.id ?? "0")
                self.tableView.reloadData()
                self.tableView.selectRow(at:IndexPath(row:index, section:0) , animated: true, scrollPosition: UITableView.ScrollPosition.none)
            }
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectArray.count
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDClassifyCollectionViewCell = tableView.dequeueReusableCell(withIdentifier: YDClassifyCollectionViewCellID, for: indexPath) as! YDClassifyCollectionViewCell
        cell.classifyListTwoModel = self.selectArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectName = ""
        self.selectID = ""
        let model = self.selectArray[indexPath.row]
        self.requestClassifyGoodsDate(id: model.id ?? "0")
        self.selectName = model.name ?? ""
        self.selectID = model.id ?? ""
//        self.rightCollectionView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension YDClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            return CGSize(width:(LBFMScreenWidth-130)/3, height:115)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if classifyGoodsModel.allMenuModel?.count ?? 0 > 0{
            return (classifyGoodsModel.allMenuModel?.count ?? 0) + 1
        }else{
            return  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if classifyGoodsModel.allMenuModel?.count ?? 0 != indexPath.row  {
            let cell:YDRightTwoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDRightTwoCollectionViewCellID, for: indexPath) as! YDRightTwoCollectionViewCell
            cell.seearchGoodsModel = classifyGoodsModel.allMenuModel?[indexPath.row]
            return cell
        }else{
           let cell:YDRightCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDRightCollectionViewCellID, for: indexPath) as! YDRightCollectionViewCell
            cell.selectName =  self.selectName
            cell.backgroundColor = UIColor.white
            return cell
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let headerView : YDClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDClassifyHeaderViewID, for: indexPath) as! YDClassifyHeaderView
            headerView.bannersImage = classifyGoodsModel.classfiyGoodsModel?.banners ?? ""
            return headerView
    }
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isIphoneX == true{
            return UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
            
        }else{
             return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth-130)/3,height:120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        if classifyGoodsModel.allMenuModel?.count ?? 0 != indexPath.row  {
            let goodsModel = classifyGoodsModel.allMenuModel?[indexPath.row]
            let goodsVC = YDClassGoodsViewController()
            goodsVC.typeID = goodsModel?.id ?? ""
            goodsVC.searchName = goodsModel?.name ?? ""
            self.navigationController?.pushViewController(goodsVC, animated: true)
        }else{
            let goodsVC = YDClassAllGoodsViewController()
            goodsVC.typeID = self.selectID
            self.navigationController?.pushViewController(goodsVC, animated: true)
        }
    }
    
    
    
}
//  商品排序

