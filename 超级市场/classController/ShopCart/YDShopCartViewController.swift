//
//  YDShopCartViewController.swift
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
import MJRefresh
import Toast_Swift

class YDShopCartViewController: YDBasicViewController {
    //    cell
    let YDShopCartViewCellID = "YDShopCartViewCell"
    //    headerView
    let YDShopCartHeaderReusableViewID = "YDShopCartHeaderReusableView"
    //    footerView
    let YDShopCartFooterReusableViewID = "YDShopCartFooterReusableView"
    //    为你推荐
    let YDHomeRecommendReusableViewID = "YDHomeRecommendReusableView"
    
    let YDGoodsCartHeaderReusableViewID = "YDGoodsCartHeaderReusableView"
//    顶部刷新
    let header = MJRefreshNormalHeader()
    var hicht = NSInteger()
    var cartCount = Int()
    //    Footer的高
    var FooterH = Int()
//    猜你喜欢
    var youLikeModel = [YDHomeYouLikeListModel]()
//    地址
    var ydAdderModel = [YDAddAddersModel]()
//商品数量
    var goodsCount = Int()
    var selectArray = [YDShopCartGoodsModel]()
    
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
    
//    删除商品ID
    var deleteIdArray = [String]()
    lazy var shopCartViewModel: YDShopCartViewModel = {
        return YDShopCartViewModel.share()
    }()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.isHidden = true
        return backView
    }()
//    lazy var selectBtn : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
//        button.addTarget(self, action: #selector(selectAllGoodsListButtonClick(selectGoods:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
    
    lazy var allLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.text = "全选"
        return label
    }()
    
    lazy var selectCollect : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "collect_image"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitle("添加至收藏", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectCollectAllGoodsListButtonClick(selectCollect:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
//    lazy var selectDelete : UIButton = {
//        let button = UIButton()
//        button.setBackgroundImage(UIImage(named: "delete_iamge"), for: UIControl.State.normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
//        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        button.setTitle("删除", for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(selectDeleteAllGoodsListButtonClick(selectDelete:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.mj_header = header
//        collectionView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        // - 注册不同分区cell
        collectionView.register(YDShopCartViewCell.self, forCellWithReuseIdentifier: YDShopCartViewCellID)
        // - 注册头视图和尾视图
        collectionView.register(YDShopCartHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShopCartHeaderReusableViewID)
        collectionView.register(YDGoodsCartHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDGoodsCartHeaderReusableViewID)
        collectionView.register(YDHomeRecommendReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDHomeRecommendReusableViewID)
        return collectionView
    }()
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:50, height: 40)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitle("删除", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: .touchUpInside)
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navBarBarTintColor = YDLabelColor
        if isUserLogin() != true{
            reuqestLookAdders()
        }
//        self.selectBtn.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
         FooterH = 70
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        currentNetReachability()
        navBarTitleColor = UIColor.white
        navBarBarTintColor = YDLabelColor
        header.setRefreshingTarget(self, refreshingAction: #selector(YDShopCartViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        requestSearchGoodsDate()
        requestrecommendGoodsDate()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        self.collectionView.frame = CGRect(x:0, y: 0, width:LBFMScreenWidth, height: LBFMScreenHeight);
        self.view.addSubview(self.collectionView)
        
//        self.backView.addSubview(self.selectBtn)
//        self.selectBtn.frame = CGRect(x: 10, y:10, width: 30, height: 30)
        
        self.backView.addSubview(self.allLabel)
//        self.allLabel.frame = CGRect(x: self.selectBtn.frame.maxX+10, y:10, width: 25, height: 30)
        
//        self.backView.addSubview(self.selectCollect)
//        self.selectCollect.frame = CGRect(x: LBFMScreenWidth-195, y: 5, width: 90, height: 25)
        
//        self.backView.addSubview(self.selectDelete)
//        self.selectDelete.frame = CGRect(x:LBFMScreenWidth - 110, y: 10, width: 95, height: 30)
        
        
        self.view.addSubview(self.wifiImage)
        self.wifiImage.frame = CGRect(x:115, y: 140, width: 260, height: 270)
        
        self.view.addSubview(self.titleName)
        self.titleName.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y:self.wifiImage.frame.maxY+10, width: 180, height: 40)
        
        self.view.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y:self.titleName.frame.maxY+30, width: 240, height: 40)
    }
    
//    下啦刷新
    @objc func headerRefresh(){
        self.view.hideAllToasts(includeActivity: true, clearQueue: true)
        self.backView.isHidden = true
        FooterH = 70
//        self.rightBarButton.isSelected = false
//        self.rightBarButton.setTitle("编辑", for: UIControl.State.normal)
       requestSearchGoodsDate()
    }
    func currentNetReachability() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.backView.isHidden = true
                self.collectionView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.backView.isHidden = true
                self.collectionView.isHidden = true
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
                
                self.view.addSubview(self.collectionView)
            }
            
            //            self.debugLog(statusStr as Any)
        }
        manager?.startListening()
    }
    //    重新加载
    @objc func finisMeRequestButtonClick(){
        currentNetReachability()
        if isUserLogin() != true{
            reuqestLookAdders()
        }
        requestSearchGoodsDate()
        requestrecommendGoodsDate()
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
    }
    
//    // 第一次请求购物车 默认全选
//    private func getCartGoods() {
//        shopCartViewModel.refreshGoodsCartAllSelect()
//    }
    
//    购物车数据
    func requestSearchGoodsDate(){
        shopCartViewModel.refreshGoodsCart()
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
                        }
                        self.collectionView.reloadData()
                    }
                }
                }
            }
        }
    }
//    查询收货地址
    func reuqestLookAdders(){
            YDUserAddersProvider.request(.getAddressInfo(token: UserDefaults.LoginInfo.string(forKey: .token) ?? "", memberPhone: UserDefaults.LoginInfo.string(forKey: .phone) ?? "")) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    if data != nil{
                    if data != nil {
                        let json = JSON(data!)
                        print("---------------%@",json)
                        if json["success"] == true{
                            if json["data"].isEmpty == true{
                                let userDefault = UserDefaults.standard
                                userDefault.set("", forKey: "AddersDictionary")
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue:updeatAdders), object:nil)
                            }
                        }
                    }
                    }
                }
        }
    }
    
    private func deleteGoodsFromShopCart() {
        let deleteId = deleteIdArray.joined(separator: ",")
        deleteGoodsFromShopCart(deleteId: deleteId) {
            self.deleteIdArray.removeAll()
        }
    }
    
    private func deleteGoodsFromShopCart(deleteId: String, success: @escaping() -> ()) {
        YDShopCartViewProvider.request(.getGoodsDeleteCartListInfo(id:deleteId)) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                    print("-------%@",json)
                    if json["success"] == true{
                        success()
                        self.FooterH = 70
                        //                    self.backView.isHidden = true
                        //                        self.rightBarButton.isSelected = false
                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsLisetCart"), object:nil)
                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshDeleteGoodsCountCart"), object:nil)
                        self.requestSearchGoodsDate()
                    } else {
                        self.toast(errorJson: json)
                    }
                } else {
                    self.toast(error: "您的网络情况不好，请重新操作")
                }
            }
        }
    }
    
   
//  编辑
    @objc func rightBarButtonClick(){
        if deleteIdArray.count == 0 {
            toast(title: "请选择要删除的商品")
            return
        }
        
        let alert = UIAlertController.init(
            title: "",
            message: "您是否要删除已选中的商品",
            preferredStyle: .alert
        )
        
        let confirm = UIAlertAction.init(title: "确定", style: .default) { (_) in
            self.deleteGoodsFromShopCart()
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
//        selectBtn.isSelected = !selectBtn.isSelected
//        if selectBtn.isSelected != true {
//            self.backView.isHidden = true
//            FooterH = 70
//            self.deleteIdArray.removeAll()
//        }else{
//            FooterH = 0
//            self.view.addSubview(self.backView)
//            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-LBFMTabBarHeight-50, width: LBFMScreenWidth, height: 50)
//            self.selectBtn.isSelected = false
//            self.backView.isHidden = false
//        }
//        if shopCartViewModel.shopCartListModel?.count ?? 0 > 0 {
//            for (index, model) in selectArray.enumerated(){
//                var listModel = self.selectArray[index].list
//                for (index,var goodsModel) in listModel!.enumerated(){
//                    listModel![index].selected = false
//                }
//                print("=============%@",listModel)
//                self.selectArray[index].list = listModel
//
//            }
//            NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsLisetCart"), object:nil)
//            self.collectionView.reloadData()
//        }
    }
//    删除全选
//    @objc func selectAllGoodsListButtonClick(selectGoods:UIButton){
//        selectGoods.isSelected = !selectGoods.isSelected
//        if shopCartViewModel.shopCartListModel?.count ?? 0 > 0 {
//            self.goodsCount = 0
//            for (index, model) in selectArray.enumerated(){
//                var listModel = self.selectArray[index].list
//                for (index,var goodsModel) in listModel!.enumerated(){
//                    listModel![index].selected = selectGoods.isSelected
//                    self.goodsCount += goodsModel.count
//                    self.deleteIdArray.append(listModel![index].id!)
//                }
//                print("=============%@",deleteIdArray)
//                self.selectArray[index].list = listModel
//
//            }
//            if selectGoods.isSelected == true{
//                self.selectDelete.setTitle("删除(\(self.goodsCount))", for: UIControl.State.normal)
//            }else{
//                self.selectDelete.setTitle("删除", for: UIControl.State.normal)
//            }
//
////            NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsLisetCart"), object:nil)
//            self.collectionView.reloadData()
//        }
//    }
//    收藏
    @objc func selectCollectAllGoodsListButtonClick(selectCollect:UIButton){

    }
//    删除
//    @objc func selectDeleteAllGoodsListButtonClick(selectDelete:UIButton){
//        if self.deleteIdArray.count > 0{
//            let deleteId = self.deleteIdArray.joined(separator: ",")
//            YDShopCartViewProvider.request(.getGoodsDeleteCartListInfo(id:deleteId)) { result  in
//                if case let .success(response) = result {
//                    let data = try? response.mapJSON()
//                    if data != nil{
//                    let json = JSON(data!)
//                    print("-------%@",json)
//                    if json["success"] == true{
//                        self.FooterH = 70
//                        self.deleteIdArray.removeAll()
//                        self.backView.isHidden = true
////                        self.rightBarButton.isSelected = false
//                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsLisetCart"), object:nil)
//                         NotificationCenter.default.post(name: NSNotification.Name.init("refreshDeleteGoodsCountCart"), object:nil)
//                        self.requestSearchGoodsDate()
//                    }
//                    }
//                }
//            }
//        }else{
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = MBProgressHUDMode.text
//            hud.label.text = "请选择商品"
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(animated: true, afterDelay: 1)
//        }
//}
//    删除单选数量
    @objc func refreshGoodsCountLisetCart(nofit:NSNotification) {
        self.goodsCount = nofit.object as! Int;
//        if self.goodsCount  > 0{
//            self.selectDelete.setTitle("删除(\(self.goodsCount))", for: UIControl.State.normal)
//        }else{
//            self.selectBtn.isSelected = false
//            self.selectBtn.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
//            self.selectDelete.setTitle("删除", for: UIControl.State.normal)
//        }
    }
//    删除未全选
//    @objc func refreshGoodsCountLisetAllSelect(nofit:NSNotification) {
//        self.selectBtn.isSelected = false
//    }
//    删除全选
    @objc func refreshGoodsISAllSelect(nofit:NSNotification) {
//        self.selectBtn.isSelected = true
    }
//    删除单选商品ID
    @objc func refreshGoodsIdArrayCart(nofit:NSNotification) {
        print("==========nofit.object:%@",nofit.object)

        self.deleteIdArray = nofit.object as! [String]
        print("++++++++++++self.deleteIdArray:%@",self.deleteIdArray)
    }
//     猜你喜欢，添加购物车刷新数据
    @objc func requestCartGoodsShowHintData(nofit:NSNotification) {
        self.view.makeToast("已添加，请下拉刷新查看", duration: 3.0, position: .center)
    }
//    商品添加刷新
    @objc func requestCartGoodsData(nofit:NSNotification) {
        self.requestSearchGoodsDate()
    }
//    查看订单返回购物车刷新
    @objc func refreshDetailsOrderGoodsCart(nofit:NSNotification){
        self.requestSearchGoodsDate()
    }
//    选择地址刷新
    @objc func notificationUpudeatAddersValue(nofit:NSNotification){
        
//        self.collectionView.reloadData()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// Notification
extension YDShopCartViewController {
    
    private func addNotification() {
        //        单选删除数量
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsCountLisetCart(nofit:)), name: NSNotification.Name(rawValue:"refreshGoodsCountLisetCart"), object: nil)
        
        //        删除未全选
        //         NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsCountLisetAllSelect(nofit:)), name: NSNotification.Name(rawValue:"refreshGoodsCountLisetAllSelect"), object: nil)
        //        删除全选
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsISAllSelect(nofit:)), name: NSNotification.Name(rawValue:"refreshGoodsISAllSelect"), object: nil)
        //        单选商品ID
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsIdArrayCart(nofit:)), name: NSNotification.Name(rawValue:"refreshGoodsIdArrayCart"), object: nil)
        //          猜你喜欢，添加购物车刷新数据
        NotificationCenter.default.addObserver(self, selector: #selector(requestCartGoodsShowHintData(nofit:)), name: NSNotification.Name(rawValue:"requestCartGoodsShowHintData"), object: nil)
        //      添加商品购物车刷新
        NotificationCenter.default.addObserver(self, selector: #selector(requestCartGoodsData(nofit:)), name: NSNotification.Name(rawValue:"requestCartGoodsData"), object: nil)
        
        //      选择地址刷新
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpudeatAddersValue(nofit:)), name: NSNotification.Name(rawValue:updeatAdders), object: nil)
        
        //      订单支付完成查看订单返回
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDetailsOrderGoodsCart(nofit:)), name: NSNotification.Name(rawValue:"refreshDetailsOrderGoodsCart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init(""), object:nil)
        
        // 刷新购物车
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShopCart(noti:)), name: NSNotification.Name.init(kShopCartDataRefresh), object: nil)
        
        // 往购物车添加商品
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addToCart(noti:)),
            name: NSNotification.Name.init(kShopCartAddGoods),
            object: nil
        )
    }
    
    // 刷新购物车
    @objc private func refreshShopCart(noti: NSNotification) {
        self.collectionView.mj_header.endRefreshing()
        if self.shopCartViewModel.shopCartListModel != nil {
            self.selectArray = self.shopCartViewModel.shopCartListModel!
        }
        let object = noti.object
        if isAllSelect(object: object) {
            selectAllGoods()
        } else {
            
        }
        //        NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsLisetCart"), object:nil)
        // 更新列表数据
        self.collectionView.reloadData()
    }
    
    @objc private func addToCart(noti: NSNotification) {
        
    }
    
    
    private func isAllSelect(object: Any?) -> Bool {
        if object == nil {
            return false
        }
        
        if !(object is Bool) {
            return false
        }
        
        return (object as! Bool)
    }
    
    private func selectAllGoods() {
        deleteIdArray.removeAll()
        for (goodsIndex, _) in selectArray.enumerated() {
            var goodsModel = self.selectArray[goodsIndex]
            if goodsModel.list == nil {
                continue
            }
            
            for (listIndex, _) in goodsModel.list!.enumerated() {
                var goodsList = goodsModel.list![listIndex]
                goodsList.selected = true
                goodsModel.list![listIndex] = goodsList
                deleteIdArray.append(goodsList.id ?? "")
            }
            
            selectArray[goodsIndex] = goodsModel
        }
        
        self.collectionView.reloadData()
    }
}

extension YDShopCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return  shopCartViewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDShopCartViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YDShopCartViewCell", for: indexPath) as! YDShopCartViewCell
        cell.setFooterH = FooterH
        if selectArray.count > indexPath.row {
            cell.focusModel = self.selectArray[indexPath.row].list
            cell.supplierName = self.selectArray[indexPath.row].supplierName ?? ""
            cell.supplierImg = self.selectArray[indexPath.row].supplierImg ?? ""
            cell.supplierId = self.selectArray[indexPath.row].supplierId ?? ""
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectArray.count <= indexPath.row {
            return .zero
        }
        
        let height = ((self.selectArray[indexPath.row].list?.count ?? 0)*120) + 50 + FooterH
        return CGSize.init(width: LBFMScreenWidth, height:CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.selectArray.count ?? 0 > 0 {
            return CGSize.init(width: LBFMScreenWidth, height:70)
        }else{
            return CGSize.init(width: LBFMScreenWidth, height:270)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if (self.youLikeModel.count)%2 == 0 {
            let height = 60+(self.youLikeModel.count/2)*260
            return CGSize.init(width: LBFMScreenWidth-30, height: CGFloat(height))
        }else{
            let height = 60+(self.youLikeModel.count/2 + 1)*260
            return CGSize.init(width: LBFMScreenWidth-30, height: CGFloat(height))
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            if self.selectArray.count ?? 0 > 0 {
                let headerView : YDShopCartHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShopCartHeaderReusableViewID, for: indexPath) as! YDShopCartHeaderReusableView
                headerView.delegate = self
                return headerView
            }else{
                let headerView : YDGoodsCartHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDGoodsCartHeaderReusableViewID, for: indexPath) as! YDGoodsCartHeaderReusableView
                headerView.delegate = self
                return headerView
            }
           
          
        
        
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView : YDHomeRecommendReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDHomeRecommendReusableViewID, for: indexPath) as! YDHomeRecommendReusableView
            if (self.youLikeModel.count)%2 == 0 {
                let height = 60+(self.youLikeModel.count/2)*260
                footerView.heightFloat = CGFloat(height)
                footerView.delegate = self
                footerView.youLikeGoodsModel = self.youLikeModel
                return footerView
            }else{
                let height = 60+(self.youLikeModel.count/2 + 1)*260
                footerView.heightFloat = CGFloat(height)
                footerView.delegate = self
                footerView.youLikeGoodsModel = self.youLikeModel
                return footerView
            }
         
        }
        return UICollectionReusableView()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
    }
}
//为你推荐单个商品进详情
extension YDShopCartViewController:YDHomeRecommendReusableViewDelegate{
    func addSelectYouLikeIndexReusableView(selectButton: UIButton, goodListModel: YDHomeYouLikeListModel, cell: YDHomeRecommendReusableView, cellExcellent: YDHomeRecommendCollectionViewCell, iconImage: UIImageView) {
           
//           var rect : CGRect = cell.frame
//           var rectExcellent : CGRect = cellExcellent.frame
//           rect.origin.x = rectExcellent.origin.x
//           //获取当前cell的相对坐标
//           rect.origin.y = rect.origin.y + 50
//           
//           var imageViewRect : CGRect = iconImage.frame
//           imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y+44
//           imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x
//
//           ShoppingCarTool().startAnimation(view: iconImage, andRect: imageViewRect, andFinishedRect: CGPoint(x:(LBFMScreenWidth/4 * 3)-20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
//
//           })
           
           //        let goodsModel = self.likeGoodsModel[selectBtn.tag]
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
                       self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                       self.cartCount += 1
                       UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                       //                    显示购物车数量
                       NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                       NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsShowHintData"), object: self, userInfo: nil)
                   }
               }
           }
       }
    func addSelectYouLikeIndexTableViewCell(selectIndex: String, goodsCode: String) {
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = selectIndex
        goodsVC.goodsCode = goodsCode
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
}

//  结算
extension YDShopCartViewController:YDShopCartViewCellDelegate{
//    查看伤心详情
    func selectLoockGoodsInfo(selectSecton: Int, selectRow: Int) {
        if selectArray.count <= selectSecton {
            return
        }
        
        let goodsModel = self.selectArray[selectSecton].list?[selectRow]
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = goodsModel?.id ?? ""
        goodsVC.goodsCode = goodsModel?.goodsCode ?? ""
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
    
    // 删除单个商品
    func deleteGoodsInfo(selectSection: Int, selectRow: Int) {
        if selectArray.count <= selectSection {
            return
        }
        
        let goodsModel = self.selectArray[selectSection].list?[selectRow]
        if goodsModel == nil {
            return
        }
        
        deleteGoodsFromShopCart(deleteId: goodsModel?.id ?? "") {
            if self.deleteIdArray.contains(goodsModel?.id ?? "") {
                self.deleteIdArray.removeAll(where: { $0 == goodsModel!.id})
            }
        }
    }
    
//    去结算
    func paySelectIndexGoodsListCollectionViewCell(goodsCount: YDShopCartViewCell, goodsIdArray: Array<String>, goodsCountArray: Array<String>, priceSum: CGFloat) {
        let userDefault = UserDefaults.standard
        let adders = userDefault.dictionary(forKey: "AddersDictionary")
        if DYStringIsEmpty(value:adders?["addressId"] as AnyObject?) == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择收货地址"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            
            return
        }
        let goodsId = goodsIdArray.joined(separator: ",")
        let goodsCount = goodsCountArray.joined(separator: ",")
        YDShopCartViewProvider.request(.getPayGoodsOrderList(addressId:adders!["addressId"] as! String, goodsId:goodsId, count:goodsCount, countSum:priceSum, supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone:(UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                    print("---------------%@",json["data"]["orderNum"])
                    let dict = json["data"]
                    if DYStringIsEmpty(value: dict["orderNum"].string as AnyObject?) != true{
                        let goCart = YDGoShopPayViewController()
                        goCart.orderNumber = String(describing:dict["orderNum"])
                        self.navigationController?.pushViewController(goCart, animated: true)
                    }
                }else{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "订单生成失败"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    return
                }
            }
            
        }
    }
        
}
//  地址管理
extension YDShopCartViewController:YDShopCartHeaderReusableViewDelegate{
    func selectAddersListHeaderView() {
        if isUserLogin() != true{
            let addersVC = YDEditAddersViewController()
            self.navigationController?.pushViewController(addersVC, animated: true)
        }else{
            let  login = YDUserLoginViewController()
            if #available(iOS 13.0, *) {
                login.modalPresentationStyle = .fullScreen
            } else {
                                                           // Fallback on earlier versions
            }
            self.present(login, animated: true, completion: nil)
        }
    }
}
//去首页
extension YDShopCartViewController:YDGoodsCartHeaderReusableViewDelegate{
    func goHomeGoodsCartHeaderReusableView() {
        self.tabBarController?.selectedIndex = 0
    }
}
