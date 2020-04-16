//
//  YDShoppingViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import SnapKit
class YDShoppingViewController: YDBasicViewController {
    
    var goodsId = String()
    var goodsCode = String()
    var HomeGoodsInfo:YDHomeGoodsDetailsInfoModel?
    var HomeGoodSpecsInfo:[YDHomeGoodSpecsInfo]?
    var HomeGoodsEstimateInfo:[YDHomeGoodsEstimateInfo]?
    var HomeGoodsImageInfo:[YDHomeGoodsImageInfo]?
    var HomeGoodsListInfo:YDHomeGoodsListInfo?
    
    var collectStatus = String()
    ///贝塞尔曲线
    fileprivate var path : UIBezierPath?
    
    //自定义图层
    var layer: CALayer?
    
//    添加商品购物车数量显示
    var cartCount = Int()
    
    private lazy var backView : UIView = {
       let viewBack = UIView()
        viewBack.backgroundColor = UIColor.white
        viewBack.frame = CGRect(x: 0, y:LBFMScreenHeight-45, width: LBFMScreenWidth, height: 45)
        return viewBack
    }()
    var labelView:UIView = {
        let view = UIView()
        view.backgroundColor =  YMColor(r: 51, g: 51, b: 51, a: 1)
        return view
    }()
    
    lazy var amontCart : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 11)
        //画一个圆圈
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 7.5
        label.layer.masksToBounds = true
//        label.isHidden = true
        return label
    }()
    private lazy var cartButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named:"search_cart_image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goGoodsCartPayList), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var cartBtn : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.setTitle("加入购物车", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(goShoppingCartButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    //Mark: - 导航栏右边按钮
    private lazy var rightBarButton1:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "collectImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "collectImage_H"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    //Mark: - 导航栏右边按钮
    private lazy var rightBarButton2:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "shareImage"), for: UIControl.State.normal)
        
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControl.Event.touchUpInside)
        return button
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navBarBackgroundAlpha = 0
    }
//    cell
    let YDShoppingListCollectionViewCellID = "YDShoppingListCollectionViewCell"
//    headerView
    let YDShoppingHeaderReusableViewID = "YDShoppingHeaderReusableView"
//    footerView
    let YDShoppingFooterReusableViewID = "YDShoppingFooterReusableView"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(YDShoppingListCollectionViewCell.self, forCellWithReuseIdentifier: YDShoppingListCollectionViewCellID)
        // - 注册头视图和尾视图
        collection.register(YDShoppingHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShoppingHeaderReusableViewID)
        collection.register(YDShoppingFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDShoppingFooterReusableViewID)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
        self.view.backgroundColor = UIColor.white
        
        setupGoodsLoadData()
        self.automaticallyAdjustsScrollViewInsets = false
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
        let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem2,rightBarButtonItem1 ]
        self.view.addSubview(self.collectionView)
        
        self.view.addSubview(self.backView)
        
        if isIphoneX == true{
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-65, width: LBFMScreenWidth, height: 65)
        }else{
             self.backView.frame = CGRect(x: 0, y:LBFMScreenHeight-45, width: LBFMScreenWidth, height: 45)
        }
        self.backView.addSubview(self.cartButton)
        
        self.cartButton.frame = CGRect(x:0, y: 0, width: 80, height: 45)
        
        self.backView.addSubview(self.labelView)
        self.labelView.frame = CGRect(x: self.cartButton.frame.maxX, y: 0, width: LBFMScreenWidth-180, height: 45)
        
        self.backView.addSubview(self.amontCart)
        
        if Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0") ?? 0 > 0{
            cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0") ?? 0
            self.amontCart.text = UserDefaults.cartCountInfo.string(forKey:.countCart)
            self.amontCart.frame = CGRect(x: 45, y:6 , width: 15, height: 15)
        }else{
            self.amontCart.frame = CGRect(x: 45, y:6 , width: 0, height: 0)
        }
        
        self.backView.addSubview(self.cartBtn)
        self.cartBtn.frame = CGRect(x: LBFMScreenWidth-100, y: 0, width: 90, height: 45)
        
    }
    
    
    
//    商品详情
    @objc func setupGoodsLoadData(){
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDHomeProvider.request(.getHomeGoodsDetailsInfo(id: goodsId, code: goodsCode, deviceNumber:uuid ?? "")) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsImage = JSONDeserializer<YDHomeGoodsDetailsInfoModel>.deserializeFrom(json: json["data"].description) {
                    self.HomeGoodsInfo = goodsImage
                    self.HomeGoodsImageInfo = goodsImage.goodsImg
                    self.HomeGoodSpecsInfo = goodsImage.goodSpecs
                    self.HomeGoodsEstimateInfo = goodsImage.goodsEstimate
                    self.HomeGoodsListInfo = goodsImage.goodsList
                    self.collectStatus = goodsImage.collectStatus ?? ""
                    if self.collectStatus == "1"{
                        self.rightBarButton1.isSelected = true
                    }else if self.collectStatus == "0"{
                        self.rightBarButton1.isSelected = false
                    }
                }

                self.collectionView.frame = CGRect(x: 0, y:LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-45)
                self.collectionView.reloadData()
            }
          }
        }
    }

    
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick1() {
        if self.rightBarButton1.isSelected == true {
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            YDHomeProvider.request(.setHomeDeleteCollectionGoodsList(goodsCode: goodsCode, deviceNumber: uuid ?? "")) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                    if json["success"] == true{
                        self.rightBarButton1.isSelected = !self.rightBarButton1.isSelected
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "取消收藏"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = json["error"]["errorMessage"].description
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                    }
                }
                }
            }
        }else if self.rightBarButton1.isSelected == false{
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            YDHomeProvider.request(.setHomecollectionGoodsLikeList(goodsCode: goodsCode, deviceNumber: uuid ?? "")) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                    if json["success"] == true{
                        self.rightBarButton1.isSelected = !self.rightBarButton1.isSelected
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = "收藏成功"
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode = MBProgressHUDMode.text
                        hud.label.text = json["error"]["errorMessage"].description
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(animated: true, afterDelay: 1)
                    }
                }
                }
            }
        }
       

    }
//    去购物车
    @objc func goGoodsCartPayList(){
        self.tabBarController?.selectedIndex = 2
        let viewCtl = self.navigationController?.viewControllers[0]
        self.navigationController?.popToViewController(viewCtl!, animated:true)
    }
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }
//    加入购物车
    @objc func goShoppingCartButtonClick(){
        
            let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: goodsCode, count:1,deviceNumber:uuid ?? "",memberId: goodsId,status:1)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount += 1
                    self.amontCart.text = String(self.cartCount)
                    self.amontCart.frame = CGRect(x: 45, y:6 , width: 15, height: 15)
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartImageView"), object: self, userInfo: nil)
                }
            }
            }
        }
        
    }
}
//更多评论
extension YDShoppingViewController:YDShoppingHeaderReusableViewDelegate{
    
    func goodsEvaluateMoreHeaderReusableView() {
        let evaluate = YDGoodsEvaluateViewController()
        evaluate.listCode = self.goodsCode
        self.navigationController?.pushViewController(evaluate, animated: true)
    }
}
extension YDShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.HomeGoodSpecsInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:YDShoppingListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDShoppingListCollectionViewCellID, for: indexPath) as! YDShoppingListCollectionViewCell
        cell.goodSpecsModel = self.HomeGoodSpecsInfo?[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.HomeGoodsEstimateInfo?.count ?? 0 > 0{
            return CGSize.init(width: LBFMScreenWidth, height:815)
        }else{
            return CGSize.init(width: LBFMScreenWidth, height:685)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: LBFMScreenWidth, height:1320)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : YDShoppingHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShoppingHeaderReusableViewID, for: indexPath) as! YDShoppingHeaderReusableView
                headerView.sumCommentCount = self.HomeGoodsEstimateInfo?.count ?? 0
                headerView.goodsImageModel = self.HomeGoodsImageInfo
                headerView.focusModel = self.HomeGoodsListInfo
                headerView.goodsEstimateModel = self.HomeGoodsEstimateInfo
                headerView.selectEstimateCount =  self.HomeGoodsInfo?.selectEstimateCount ?? 0
                headerView.applauseRate = self.HomeGoodsInfo?.applauseRate ?? 0
                headerView.delegate = self
                return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView : YDShoppingFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDShoppingFooterReusableViewID, for: indexPath) as! YDShoppingFooterReusableView
            footerView.contentName  = self.HomeGoodsListInfo?.content ?? ""
            return footerView
        }
        return UICollectionReusableView()
    }
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
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
        return CGSize.init(width:LBFMScreenWidth,height:40)
    }
}
