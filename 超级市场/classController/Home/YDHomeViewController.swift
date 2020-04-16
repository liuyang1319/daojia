//
//  YDHomeViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/10.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import HandyJSON
import Alamofire
import MJRefresh
//位置
import CoreLocation
class YDHomeViewController: UIViewController ,AMapLocationManagerDelegate,YDLocationAddersViewControllerDelegate{
    var recommendModel = [YDHomeAllGoodListModel]()
    var recommend8Model = [YDHomeAllGoodListModel]()
    let locationManager = AMapLocationManager()
    let locationManager1 = CLLocationManager()
    var adders = String()
    var cityName = String()
    var goodsCount = Int()
    var cartCount = Int()
    var shopMenu = [YDShopMenuList]()
    var youLikeModel = [YDHomeYouLikeListModel]()
//    顶部刷新
    let header = MJRefreshNormalHeader()
//    分类
    var categoryNameArray = [YDCategoryNameModel]()
    var nameArray = [String]()
    var nameIdArray = [String]()
//    仓储图片
    let iconImage = UIImageView()
    // 轮播图
    private let YDHomeHeaderCellCollectionViewCellID     = "YDHomeHeaderCellCollectionViewCell"
    // 百宝箱
    private let YDTreasureChestCollectionViewCellID     = "YDTreasureChestCollectionViewCell"
    // 通栏
    private let YDColumnsCollectionViewCellID     = "YDColumnsCollectionViewCell"
    //    Y优选
    private let YDExcellentCollectionViewCellID = "YDExcellentCollectionViewCell"
    //    限时特价
    private let YDSpecialViewCellID = "YDSpecialViewCell"
    //    喜欢通栏
    private let YDLayoutPageCollectionViewCellID = "YDLayoutPageCollectionViewCell"
    //    喜欢
    private let YDYouLikeCollectionViewCellID = "YDYouLikeCollectionViewCell"
    //    小专场x
    private let YDRecommendViewCellID = "YDRecommendViewCell"
    
//    为你推荐
    let YDHomeRecommendReusableViewID = "YDHomeRecommendReusableView"
//    猜你喜欢
    let YDHomeLikeTableViewCellID = "YDHomeLikeTableViewCell"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.mj_header = header
        // 轮播图
        collection.register(YDHomeHeaderCellCollectionViewCell.self, forCellWithReuseIdentifier: YDHomeHeaderCellCollectionViewCellID)
        // 百宝箱
        collection.register(YDTreasureChestCollectionViewCell.self, forCellWithReuseIdentifier: YDTreasureChestCollectionViewCellID)
        // 通栏
        collection.register(YDColumnsCollectionViewCell.self, forCellWithReuseIdentifier: YDColumnsCollectionViewCellID)
        //        优选
        collection.register(YDExcellentCollectionViewCell.self, forCellWithReuseIdentifier: YDExcellentCollectionViewCellID)
        
        //        通栏
        collection.register(YDLayoutPageCollectionViewCell.self, forCellWithReuseIdentifier: YDLayoutPageCollectionViewCellID)
        
        //        猜你喜欢
        collection.register(YDYouLikeCollectionViewCell.self, forCellWithReuseIdentifier: YDYouLikeCollectionViewCellID)
        
        
//        collection.register(YDSpecialViewCell.self, forCellWithReuseIdentifier: YDSpecialViewCellID)
//          分类专场
        collection.register(YDRecommendViewCell.self, forCellWithReuseIdentifier: YDRecommendViewCellID)
        // - 注册头视图和尾视图
        collection.register(YDHomeLikeTableViewCell.self, forCellWithReuseIdentifier: YDHomeLikeTableViewCellID)
        collection.register(YDHomeRecommendReusableView.self, forCellWithReuseIdentifier: YDHomeRecommendReusableViewID)
//        collection.register(YDHomeRecommendReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDHomeRecommendReusableViewID)
//        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData()}
        return collection
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:180, height: 30)
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
    private lazy var leftBarView:UIView = {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y:0, width: 115, height: 30)
        leftView.backgroundColor?.withAlphaComponent(0)
        return leftView
    }()
    private lazy var rightBarView:UIView = {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y:0, width: 250, height: 30)
        leftView.backgroundColor?.withAlphaComponent(0)
        return leftView
    }()
    // - 导航栏右边菜单
    private lazy var menuButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:210, y:0, width:30, height: 30)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(selectGoodsMenuButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named:"menu_icon"), for: .normal)
        return button
    }()
    // - 导航栏左边按钮
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:7, width:15, height: 15)
        button.addTarget(self, action: #selector(addersButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "addersImage"), for: .normal)
        return button
    }()
    public lazy var addersButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
        button.frame = CGRect(x:15, y:5, width:90, height: 20)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        button.addTarget(self, action: #selector(addersButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var listButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:110, y:15, width:8, height: 5)
        button.setImage(UIImage(named: "listImage"), for: .normal)
        button.addTarget(self, action: #selector(addersButtonClick), for: UIControl.Event.touchUpInside)
        return button
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

    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(true)
        currentNetReachability()
        //        检查定位权限
        showEventsAcessDeniedAlert()
        let alpha = collectionView.contentOffset.y / CGFloat(LBFMNavBarHeight)
        self.navBarBackgroundAlpha = alpha

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        定位
        self.loadLocation()
        Thread.sleep(forTimeInterval: 3.0) //延长3秒
        header.setRefreshingTarget(self, refreshingAction: #selector(YDHomeViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        //        首页数据
        self.setupLoadData()
        //        查询购物车数量
        requestSearchGoodsDate()
        //        为你推荐
        requestrecommendGoodsDate()

        self.title = "首页"
        navBarBarTintColor = YDLabelColor
        self.navBarBackgroundAlpha = 0
        let currentVersion:String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
//        UserDefaults.localVersionInfo.set(value:"", forKey:.notFirst)
        if(String(UserDefaults.localVersionInfo.string(forKey:.notFirst) ?? "").isEmpty == true){
            self.setStaticGuidePage()
            UserDefaults.localVersionInfo.set(value:currentVersion, forKey:.notFirst)
        }else{
            if (String(UserDefaults.localVersionInfo.string(forKey:.notFirst) ?? "").isEmpty != true && String(UserDefaults.localVersionInfo.string(forKey:.notPrivacy) ?? "").isEmpty == true){
                let shopMenuVC = YDPrivacyStatementViewController()
                shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                shopMenuVC.modalTransitionStyle = .crossDissolve
                self.present(shopMenuVC,animated:true,completion:nil)
            }
        }
 
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView.frame = CGRect(x: 0, y:-LBFMNavBarHeight, width: LBFMScreenWidth, height:LBFMScreenHeight+20)
        
        if isIphoneX == true {
            self.menuButton.frame = CGRect(x:210, y:0, width:30, height: 30)
        }else{
            self.menuButton.frame = CGRect(x:190, y:0, width:30, height: 30)
        }
        self.leftBarView.addSubview(self.leftButton)
        self.leftBarView.addSubview(self.addersButton)
        self.leftBarView.addSubview(self.listButton)
        
        self.rightBarView.addSubview(self.rightBarButton)
        self.rightBarView.addSubview(self.menuButton)
     
//        搜索修改位置
        NotificationCenter.default.addObserver(self, selector: #selector(notificationValue(_:)), name: NSNotification.Name(rawValue: "sendValue"), object: nil)
//        重新定位修改位置
         NotificationCenter.default.addObserver(self, selector: #selector(notificationRestartLocationValue(_:)), name: NSNotification.Name(rawValue: "restartLocation"), object: nil)
//        修改仓储icon
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMenuLisetIcon(nofit:)), name: NSNotification.Name(rawValue:"refreshMenuLisetIcon"), object: nil)
//        购物车数量查询
         NotificationCenter.default.addObserver(self, selector: #selector(refreshDeleteGoodsCountCart(nofit:)), name: NSNotification.Name(rawValue:"refreshDeleteGoodsCountCart"), object: nil)
//        引导图显示tab
        NotificationCenter.default.addObserver(self, selector: #selector(refreshHHGuidePageHUDHomeTabbar(nofit:)), name: NSNotification.Name(rawValue:"HHGuidePageHUDHomeController"), object: nil)
//        第一次登录新用户礼包
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPrivacyStatementView(nofit:)), name: NSNotification.Name(rawValue:"YDPrivacyStatementViewController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShopCart), name: NSNotification.Name.init(kShopCartDataRefresh), object: nil)

        // - 导航栏右边按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarView)
        
        self.view.addSubview(self.wifiImage)
        self.wifiImage.frame = CGRect(x:115, y: 140, width: 260, height: 270)
        
        self.view.addSubview(self.titleName)
        self.titleName.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y:self.wifiImage.frame.maxY+10, width: 180, height: 40)
        
        self.view.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y:self.titleName.frame.maxY+30, width: 240, height: 40)
        

    }
    //    下啦刷新
    @objc func headerRefresh(){
        setupLoadData()
    }
    func showEventsAcessDeniedAlert() {
           if(CLLocationManager.authorizationStatus() == .denied) {
                 let alertController = UIAlertController(title: "打开定位开关", message: "定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许App使用定位服务",preferredStyle: .alert)
                 let settingsAction = UIAlertAction(title: "设置", style: .default) { (alertAction) in
                if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(appSettings as URL)
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
            }else {
//                //        定位
//                loadLocation()
            }
}

//    第一次启动引导图，图片，GIF，视频
// MARK: - 静态图片引导页
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["guidance_iamge1", "guidance_iamge2", "guidance_iamge3"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.view.addSubview(guideView)
    }
//   检测网络状态
    func currentNetReachability() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.addersButton.setTitle("暂时无法定位", for: UIControl.State.normal)
                self.collectionView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                self.menuButton.isHidden = true
                self.navBarBackgroundAlpha = 1
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.addersButton.setTitle("暂时无法定位", for: UIControl.State.normal)
                self.collectionView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                self.menuButton.isHidden = true
                self.navBarBackgroundAlpha = 1
                break
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                }
//                self.requestSearchGoodsDate()
                //        为你推荐
//                self.requestrecommendGoodsDate()
                self.view.addSubview(self.collectionView)
            }
            
        }
        manager?.startListening()
    }
    //    重新加载
    @objc func finisMeRequestButtonClick(){
        currentNetReachability()
        self.navBarBackgroundAlpha = 0
        //        定位
        self.loadLocation()
        self.requestSearchGoodsDate()
        self.setupLoadData()
        
        //        为你推荐
        self.requestrecommendGoodsDate()
        self.collectionView.reloadData()
        self.menuButton.isHidden = false
        self.collectionView.isHidden = false
    }
    lazy var homeGoodsViewModel: YDHomeGoodsListViewModel = {
        return YDHomeGoodsListViewModel()
    }()
//    仓储列表
    func requestsShopMenuLisetDate(latitude:Double,longitude:Double){
        YDHomeProvider.request(.getHomeShopMenuListPage(latitude: latitude, longitude: longitude,token: UserDefaults.LoginInfo.string(forKey: .token) as NSString? ?? "" as NSString , memberPhone: UserDefaults.LoginInfo.string(forKey: .phone) as NSString? ?? "" as NSString)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let mappedObject = JSONDeserializer<YDShopMenuList>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.shopMenu = mappedObject as! [YDShopMenuList]
                    if self.shopMenu.count > 0 {
                        let model = self.shopMenu[0]
                        UserDefaults.warehouseManagement.set(value:model.supplierId, forKey:.supplierId)
                        self.iconImage.kf.setImage(with: URL(string:model.siteImg ?? ""),placeholder:UIImage(named:"menu_icon") )
                        self.menuButton.setImage(self.iconImage.image, for: UIControl.State.normal)
                    }
                }
                }
            }
        }
    }
    //    首页数据
    func setupLoadData(){
        // 加载数据
        homeGoodsViewModel.updateDataBlock = { [unowned self] in
            self.collectionView.mj_header.endRefreshing()
//             self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        homeGoodsViewModel.refreshDataSource()
    }
    //    购物车数据
    lazy var shopCartViewModel: YDShopCartViewModel = {
        return YDShopCartViewModel.share()
    }()

//    购物车数量查询
    @objc func refreshDeleteGoodsCountCart(nofit:Notification){
        requestSearchGoodsDate()
    }
// MARK: -      第一次加载引导图显示tabbar
    @objc func refreshHHGuidePageHUDHomeTabbar(nofit:Notification){
        self.tabBarController?.tabBar.isHidden = false
        let shopMenuVC = YDPrivacyStatementViewController()
        shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        shopMenuVC.modalTransitionStyle = .crossDissolve
        self.present(shopMenuVC,animated:true,completion:nil)
    }

    //    购物车数量
    func requestSearchGoodsDate(){
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        shopCartViewModel.refreshClassfiyDataSource(deviceNumber: uuid!, memberId:UserDefaults.LoginInfo.string(forKey: .id) ?? "")
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
                            self.collectionView.reloadData()
                        }
                    }
                }
                }
            }
        }
    }
    
    // 刷新购物车
    @objc private func refreshShopCart() {
        self.goodsCount = 0
        // 更新列表数据\
        if self.shopCartViewModel.shopCartListModel?.count ?? 0 > 0{
            
            for (index, model) in self.shopCartViewModel.shopCartListModel!.enumerated(){
                for (index, listModel) in model.list!.enumerated(){
                    self.goodsCount += listModel.count
                }
            }
            UserDefaults.cartCountInfo.set(value:String(self.goodsCount), forKey:.countCart)
            
            print("=================%d",self.goodsCount)
            NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.goodsCount])
            
        }else{
            UserDefaults.cartCountInfo.set(value:String(self.goodsCount), forKey:.countCart)
            
            print("=================%d",self.goodsCount)
            NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.goodsCount])
        }
        
        self.collectionView.reloadData()
    }
//    修改menu仓储Icon
    @objc func refreshMenuLisetIcon(nofit:Notification){
        
        iconImage.kf.setImage(with: URL(string:nofit.object as! String))
        self.menuButton.setImage(iconImage.image, for: UIControl.State.normal)
    }
    //    修改位置
    @objc func notificationValue(_ notification:Notification) {
        let addserLatitude:CGFloat = notification.userInfo?["addserLatitude"] as! CGFloat
        let addserLongitude:CGFloat = notification.userInfo?["addserLongitude"] as! CGFloat
        requestsShopMenuLisetDate(latitude:Double(addserLatitude) as! Double, longitude:Double(addserLongitude) as! Double)
        self.addersButton.setTitle((notification.userInfo?["addserName"] as! String) ?? "", for: UIControl.State.normal)
    }
//    重新定位修改位置
    @objc func notificationRestartLocationValue(_ notification:Notification) {
        self.addersButton.setTitle((notification.userInfo?["addserName"] as! String) ?? "", for: UIControl.State.normal)
    }
// MARK: -    新用户一次登录礼包弹框
    @objc func refreshPrivacyStatementView(nofit:Notification){
        let shopMenuVC = YDNewUserGiftViewController()
        shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        shopMenuVC.modalTransitionStyle = .crossDissolve
        self.present(shopMenuVC,animated:true,completion:nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
// MARK: -    打开定位
    func loadLocation()
    {
        if(String(UserDefaults.AccountInfo.string(forKey:.addersName) ?? "").isEmpty == true){
            self.addersButton.setTitle("请开启定位权限", for: UIControl.State.normal)
        }else{
            self.addersButton.setTitle(UserDefaults.AccountInfo.string(forKey:.addersName), for: UIControl.State.normal)
        }
//        UserDefaults.AccountInfo.set(value:"", forKey:.addersName)
        self.locationManager1.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
        self.locationManager1.requestAlwaysAuthorization()                            //始终授权
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        locationManager.delegate = self
        locationManager.locatingWithReGeocode = true
        locationManager.distanceFilter = 200
        
        self.locationManager.requestLocation(withReGeocode: true) { (location, regeocode, error) in
            if (error == nil){
                print("------location%@",location)
                let locationStr = String(describing:location)
                self.adders = regeocode!.poiName ?? ""
                self.cityName = regeocode!.city ?? ""
                let addersInfo = String(regeocode!.province ?? "") + String(regeocode!.city ?? "") + String(regeocode!.district ?? "")
                print("=============%@",addersInfo)
                UserDefaults.AccountInfo.set(value:addersInfo, forKey:.addersInfo)
                UserDefaults.AccountInfo.set(value:self.adders as String, forKey:.addersName)
                UserDefaults.AccountInfo.set(value:self.cityName as String, forKey:.cityName)
                self.addersButton.setTitle(regeocode!.poiName, for: UIControl.State.normal)
                
                let index3 = locationStr.index(locationStr.startIndex, offsetBy: 11)
                let index4 = locationStr.index(locationStr.startIndex, offsetBy: 22)
                let latitude = locationStr[index3..<index4]
                
                let index1 = locationStr.index(locationStr.startIndex, offsetBy: 24)
                let index2 = locationStr.index(locationStr.startIndex, offsetBy: 36)
                let location = locationStr[index1..<index2]
                
                self.requestsShopMenuLisetDate(latitude:Double(latitude) as! Double, longitude:Double(location) as! Double)
                
//                self.locationManager.startUpdatingLocation()
            }
            
        }
        
    }

    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        //        检查定位权限
        showEventsAcessDeniedAlert()
    }

// MARK: -    设置位置
    func returnAddersValue(adders: String) {
        self.addersButton.setTitle(adders, for: UIControl.State.normal)
    }
// MARK: -    搜索
    @objc func rightBarButtonClick(){
        let searchVC = YDHomeSearchBarViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
// MARK: -    右侧菜单
    @objc func selectGoodsMenuButtonClick(){
        let shopMenuVC = YDSelectShopMenuViewController()
        shopMenuVC.shopMenu = self.shopMenu
        shopMenuVC.height = self.shopMenu.count
        shopMenuVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        if #available(iOS 13.0, *) {
            shopMenuVC.modalPresentationStyle = .custom
        } else {
                                           // Fallback on earlier versions
        }
        shopMenuVC.modalTransitionStyle = .crossDissolve
        self.present(shopMenuVC,animated:true,completion:nil)
    }
    // MARK: -     地址
    @objc func addersButtonClick(){
        let loginVC = YDLocationAddersViewController()
        loginVC.delegate = self;
        loginVC.addersTitile = self.adders
        loginVC.cityTitle = self.cityName
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}


extension YDHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: 当前控制器的滑动方法事件处理 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > -64{
            let alpha = scrollView.contentOffset.y / CGFloat(LBFMNavBarHeight)
            self.navBarBackgroundAlpha = alpha
            if scrollView.contentOffset.y > 0{
                
            }
        }else{
            self.navBarBackgroundAlpha = 0
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeGoodsViewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 6{
            return 3
        }else{
            return 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = homeGoodsViewModel.homeGoodsListModel?[indexPath.section]
        print("%d=================%@",indexPath.section,moduleType?.postionName)
        if(moduleType?.postionName == "/4?place=4"){
            let cell:YDHomeHeaderCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDHomeHeaderCellCollectionViewCellID, for: indexPath) as! YDHomeHeaderCellCollectionViewCell
            cell.seearchGoodsModel = moduleType?.list
            cell.delegate = self
            return cell
        }else if(moduleType?.postionName == "/5?place=5"){
            let cell:YDTreasureChestCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDTreasureChestCollectionViewCellID, for: indexPath) as! YDTreasureChestCollectionViewCell
            cell.functionGoodsModel = moduleType?.list
            cell.delegate = self
            return cell
        }else if(moduleType?.postionName == "/6?place=6"){
            let cell:YDColumnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDColumnsCollectionViewCellID, for: indexPath) as! YDColumnsCollectionViewCell
            cell.columnsGoodsModel = moduleType?.list
            //            cell.delegate = self
            return cell
        }else if (moduleType?.postionName == "/7?place=7"){
            let cell:YDExcellentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDExcellentCollectionViewCellID, for: indexPath) as! YDExcellentCollectionViewCell
            self.recommendModel = (moduleType?.list)!
            cell.excellentGoodsModel = moduleType?.list
            cell.backBtn.tag = indexPath.row
            cell.redImageBtn.tag = indexPath.row
            cell.delegate = self
            return cell
        }else if(moduleType?.postionName == "/8?place=8"){
            let cell:YDRecommendViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDRecommendViewCellID, for: indexPath) as! YDRecommendViewCell
            self.recommend8Model = (moduleType?.list)!
            cell.recommendGoodsModel = moduleType?.list
            cell.delegate = self
            return cell
        }else if(moduleType?.postionName == "/9?place=9"){
            let cell:YDLayoutPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDLayoutPageCollectionViewCellID, for: indexPath) as! YDLayoutPageCollectionViewCell
            cell.layoutPageGoodsModel = moduleType?.list
            //            cell.delegate = self as? YDHomeHeaderCellCollectionViewCellDelegate
            return cell
        }else{
            if indexPath.row == 0{
                let cell:YDYouLikeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDYouLikeCollectionViewCellID, for: indexPath) as! YDYouLikeCollectionViewCell
                cell.youLikeGoodsModel = moduleType?.list
                let count = (moduleType?.list?.count ?? 0)/3
                cell.heightFloat = CGFloat(195 * count)+10
                cell.delegate = self
                return cell
              
            }else if indexPath.row == 1{
                let cell:YDHomeLikeTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDHomeLikeTableViewCellID, for: indexPath) as! YDHomeLikeTableViewCell
                              return cell
            }else{
                let cell:YDHomeRecommendReusableView = collectionView.dequeueReusableCell(withReuseIdentifier: YDHomeRecommendReusableViewID, for: indexPath) as! YDHomeRecommendReusableView
                let height = self.youLikeModel.count*135
                cell.heightFloat = CGFloat(height)
                cell.delegate = self
                cell.youLikeGoodsModel = self.youLikeModel
                return cell
            }
         
        }
    
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let moduleType = homeGoodsViewModel.homeGoodsListModel?[6]
        if indexPath.section==0{
            return CGSize.init(width:LBFMScreenWidth,height:220)
        }else if indexPath.section==1{
            return CGSize.init(width:LBFMScreenWidth,height:160)
        }else if indexPath.section==2{
            return CGSize.init(width:LBFMScreenWidth,height:80)
        }else if indexPath.section==3{
            return CGSize.init(width:LBFMScreenWidth,height:100)
        }else if indexPath.section==4{
            return CGSize.init(width:LBFMScreenWidth,height:285)
        }else if indexPath.section==5{
            return CGSize.init(width:LBFMScreenWidth,height:105)
        }else{
            if indexPath.row == 0{
                let count = (moduleType?.list?.count ?? 0)/3
                return CGSize.init(width:LBFMScreenWidth,height:CGFloat(195 * count)+10)
               
            }else if indexPath.row == 1{
               return CGSize.init(width:LBFMScreenWidth,height:60)
            }else{
                let height = self.youLikeModel.count*135
                return CGSize.init(width: LBFMScreenWidth, height: CGFloat(height))
            }
        }
        
    }

}
// MARK: -为你推荐单个商品进详情
extension YDHomeViewController:YDHomeRecommendReusableViewDelegate{
    func addSelectYouLikeIndexReusableView(selectButton: UIButton, goodListModel: YDHomeYouLikeListModel, cell: YDHomeRecommendReusableView, cellExcellent: YDHomeRecommendCollectionViewCell, iconImage: UIImageView) {
        
        var rect : CGRect = cell.frame
        var rectExcellent : CGRect = cellExcellent.frame
        rect.origin.x = rectExcellent.origin.x
        //获取当前cell的相对坐标
        rect.origin.y = rect.origin.y - collectionView.contentOffset.y
        if selectButton.tag%2 == 1{
            rect.origin.y = rect.origin.y+CGFloat((selectButton.tag*135))-135
        }else{
            rect.origin.y = rect.origin.y+CGFloat((selectButton.tag*135))
        }
        rect.origin.y = rect.origin.y-60
        var imageViewRect : CGRect = iconImage.frame
        imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y
        imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x
        print("===================%@",selectButton.tag%2)
        print("++++++++++++++++%@",collectionView.contentOffset.y)
        print("---------------%@",imageViewRect.origin.y)
        ShoppingCarTool().startAnimation(view: iconImage, andRect: imageViewRect, andFinishedRect: CGPoint(x:(LBFMScreenWidth/4 * 3)-20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
        })
        
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
// MARK: - 单个商品进详情
extension YDHomeViewController:YDYouLikeCollectionViewCellDelegate{

    func addSelectGoodsCartCollectionViewCell(selectButton: UIButton,goodListModel:YDHomeAllGoodListModel, cell: YDYouLikeCollectionViewCell, cellExcellent: YDExcellentViewCell, iconImage: UIImageView) {
        var rect : CGRect = cell.frame
        var rectExcellent : CGRect = cellExcellent.frame
        rect.origin.x = rectExcellent.origin.x
        //获取当前cell的相对坐标
        rect.origin.y = (rect.origin.y - collectionView.contentOffset.y)
        var imageViewRect : CGRect = iconImage.frame
        imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y
        imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x
        print("===================%@",rect.origin.y)
        print("++++++++++++++++%@",collectionView.contentOffset.y)
        print("---------------%@",imageViewRect.origin.y)
        ShoppingCarTool().startAnimation(view: iconImage, andRect: imageViewRect, andFinishedRect: CGPoint(x:(LBFMScreenWidth/4 * 3)-20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
        })

        
//        let goodsModel = youLikeGoodsModel?[selectButton.tag]
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
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                }
            }
        }
    }
    
    func addSelectGoodsIndexTableViewCell(selectIndex: String,goodsCode:String) {
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = selectIndex
        goodsVC.goodsCode = goodsCode
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
    
}
// MARK: -   百宝箱
extension YDHomeViewController:YDHomeHeaderCellCollectionViewCellDelegate {

    func recommendHeaderBtnClick(categoryId: String, title: String, url: String) {
        self.tabBarController?.selectedIndex = 1
        NotificationCenter.default.post(name: NSNotification.Name("YDClassifyViewCategoryId"), object: self, userInfo: ["categoryId":categoryId])
        UserDefaults.localVersionInfo.set(value:categoryId, forKey: .classifyID)
    }
    
    func recommendHeaderBannerClick(url: String) {
        NSLog("-----------------")
        //        let vc = YDShoppingViewController()
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//  百宝箱
extension YDHomeViewController:YDTreasureChestCollectionViewCellDelegate{
    
}
// MARK: -通栏
extension YDHomeViewController:YDRecommendViewCellDelegate{
    
    func recommendGuessLikeCellItemClick(selectIndex: Int) {
        let model = self.recommend8Model[selectIndex]
        YDHomeProvider.request(.getReadCategoryGoodsNameList(categoryId:model.categoryId ?? "")){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        self.nameArray.removeAll()
                        self.nameIdArray.removeAll()
                        if let mappedObject = JSONDeserializer<YDCategoryNameModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.categoryNameArray = mappedObject as! [YDCategoryNameModel]
                            for model in self.categoryNameArray.enumerated(){
                                self.nameArray.append(model.element.name ?? "")
                                self.nameIdArray.append(model.element.id ?? "")
                            }

                            let vc = YDGoodsCategoryMainController()
                            vc.titles = self.nameArray
                            vc.titleId = self.nameIdArray
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        let vc = YDGoodsCategoryMainController()
                        vc.titles = []
                        vc.titleId = []
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                }
            }
        }
    }
}
// MARK: -超市优选
extension YDHomeViewController:YDExcellentCollectionViewCellDelegate {
    func recommendimageLeftCollectionViewCell(selectImage: UIButton) {
        let model = self.recommendModel[selectImage.tag]
        YDHomeProvider.request(.getReadCategoryGoodsNameList(categoryId:model.categoryId ?? "")){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        self.nameArray.removeAll()
                        self.nameIdArray.removeAll()
                        if let mappedObject = JSONDeserializer<YDCategoryNameModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.categoryNameArray = mappedObject as! [YDCategoryNameModel]
                            for model in self.categoryNameArray.enumerated(){
                                self.nameArray.append(model.element.name ?? "")
                                self.nameIdArray.append(model.element.id ?? "")
                            }
                            
                            let vc = YDGoodsCategoryMainController()
                            vc.titles = self.nameArray
                            vc.titleId = self.nameIdArray
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        let vc = YDGoodsCategoryMainController()
                        vc.titles = []
                        vc.titleId = []
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                }
            }
        }
    }
    
    func recommendimageRightCollectionViewCell(selectImage: UIButton) {
        let model = self.recommendModel[selectImage.tag]
        YDHomeProvider.request(.getReadCategoryGoodsNameList(categoryId:model.categoryId ?? "")){ result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        self.nameArray.removeAll()
                        self.nameIdArray.removeAll()
                        if let mappedObject = JSONDeserializer<YDCategoryNameModel>.deserializeModelArrayFrom(json: json["data"].description) {
                            self.categoryNameArray = mappedObject as! [YDCategoryNameModel]
                            for model in self.categoryNameArray.enumerated(){
                                self.nameArray.append(model.element.name ?? "")
                                self.nameIdArray.append(model.element.id ?? "")
                            }
                            
                            let vc = YDGoodsCategoryMainController()
                            vc.titles = self.nameArray
                            vc.titleId = self.nameIdArray
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        let vc = YDGoodsCategoryMainController()
                        vc.titles = []
                        vc.titleId = []
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                }
            }
        }
    }

}
