//
//  YDHomeSearchGoodsViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import SwiftMessages
import Alamofire
class YDHomeSearchGoodsViewController: YDBasicViewController,UITextFieldDelegate{
    var tableView: UITableView!
    var searchName = String()
    var addGoodArray = Array<Any>()
    let YDHomeSearchTableViewCellID = "YDHomeSearchTableViewCell"
    let YDHomeSearchBarFooterViewID = "YDHomeSearchBarFooterView"
    private lazy var rView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    var cartCount = Int()
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
    // - 导航栏右边菜单
    private lazy var cartButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:5, width:30, height: 30)
        button.addTarget(self, action: #selector(selectGoodsCartButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named:"search_cart_image"), for: .normal)
        return button
    }()
    
    private lazy var countLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x:-20, y:0, width:15, height: 15)
        label.backgroundColor = YMColor(r: 236, g: 29, b: 29, a: 1)
        label.layer.cornerRadius = 7.5
        label.text = ""
        label.isHidden = true
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 9, weight: UIFont.Weight.regular)
        return label
    }()
    
    func initTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y:LBFMNavBarHeight+54, width: self.view.bounds.width, height: self.view.bounds.height - LBFMNavBarHeight-54), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
//        tableView.uHead = URefreshHeader{ [weak self] in self?.requestSearchGoodsDate() }
        tableView.register(YDHomeSearchTableViewCell.self, forCellReuseIdentifier: YDHomeSearchTableViewCellID)
        tableView.register(YDHomeSearchBarFooterView.self, forHeaderFooterViewReuseIdentifier: YDHomeSearchBarFooterViewID)
        
    }
    
    private lazy var allButton : UIButton = {
        let button = UIButton()
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(reconAllGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("综合", for: UIControl.State.normal)
//        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    private lazy var priceButton : UIButton = {
        let button = UIButton()
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(reconPriceGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("价格", for: UIControl.State.normal)
//        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    private lazy var volumeButton : UIButton = {
        let button = UIButton()
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(reconVolumeGoodsListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitle("销量", for: UIControl.State.normal)
//        button.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitleColor(YDLabelColor, for: UIControl.State.selected)
        return button
    }()
    
    private lazy var searchBtn:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"searchImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var searchImage:UIView = {
        let search = UIView()
        search.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return search
    }()
    private lazy var searchField:UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        field.font = UIFont.systemFont(ofSize: 13)
        field.backgroundColor = YMColor(r: 246, g: 246, b:246, a: 1)
        field.placeholder = "搜索商品"
        field.returnKeyType = .search
        field.leftViewMode = .always
        field.delegate = self
//        field.leftView = searchBtn
//        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        return field
    }()
    lazy var searchView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        view.backgroundColor = UIColor.white
        return view
    }()
    var countSum : UILabel = {
        let label = UILabel()
        label.text = "约0个结果"
        label.textAlignment = .right
        label.textColor  = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        return label
    }()
    
    var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    lazy var searchGoodsViewModel: YDHomeSearchGoodsViewModel = {
        return YDHomeSearchGoodsViewModel()
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UserDefaults.cartCountInfo.string(forKey:.countCart) != "0" {
            countLabel.isHidden = false
            cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart)!)!
            countLabel.text = UserDefaults.cartCountInfo.string(forKey:.countCart)
        }
        currentNetReachability()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        countLabel.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(true)
         countLabel.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                self.searchImage.addSubview(self.searchBtn)
                self.searchField.leftView = self.searchImage
        }else{
                self.searchField.leftView = self.searchBtn
        }
        self.searchView.addSubview(searchField)
        self.searchView.addSubview(countSum)
        self.countSum.frame = CGRect(x: LBFMScreenWidth-220, y: 0, width: 70, height: 30)
        self.view.backgroundColor = UIColor.white
        self.searchField.text = self.searchName.unicodeStr
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cartButton)
        self.navigationItem.titleView = searchView
        self.searchField.delegate = self
        

        
        navigationController?.navigationBar.addSubview(countLabel)
        navigationController?.navigationBar.barTintColor = UIColor.white
        countLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-12)
            make.top.equalTo(10.5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        if UserDefaults.cartCountInfo.string(forKey:.countCart) != "0" {
            countLabel.isHidden = false
            cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart)!)!
            countLabel.text = UserDefaults.cartCountInfo.string(forKey:.countCart)
        }
        
        
        self.view.addSubview(self.allButton)
        self.allButton.isSelected = true
        self.allButton.frame = CGRect(x:(LBFMScreenWidth-240)*0.25, y: LBFMNavBarHeight+10, width: 80, height: 25)
        
        self.view.addSubview(self.priceButton)
        self.priceButton.frame = CGRect(x:2*(LBFMScreenWidth-240)*0.25 + 80 , y: LBFMNavBarHeight+10, width: 80, height: 25)
        
        self.view.addSubview(self.volumeButton)
        self.volumeButton.frame = CGRect(x:3*(LBFMScreenWidth-240)*0.25 + 160, y: LBFMNavBarHeight+10, width: 80, height: 25)
        
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.allButton.frame.maxY+10, width: LBFMScreenWidth, height: 10)

        
        requestSearchGoodsDate()
        initTableView()
        
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
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
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
               self.view.addSubview(self.tableView)
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
        self.tableView.isHidden = false
    }
//    去购物车
    @objc func selectGoodsCartButtonClick(){
        self.tabBarController?.selectedIndex = 2
        let viewCtl = self.navigationController?.viewControllers[0];
        self.navigationController?.popToViewController(viewCtl!, animated: true);

    }
    //    搜索商品名
    func requestSearchGoodsDate(){
        searchGoodsViewModel.updateDataBlock = { [unowned self] in
//            self.tableView.uHead.endRefreshing()
            self.countSum.text = String(format: "约%d个结果", self.searchGoodsViewModel.searchGoodsListModel?.count ?? 0)
            // 更新列表数据
            self.tableView.reloadData()
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        searchGoodsViewModel.refreshDataSource(name: self.searchName, sort:"count", deviceNumber:uuid ?? "")
    }
    //  全部商品
    @objc func reconAllGoodsListButtonClick(){
//        if self.allButton.isSelected == true {
//            self.allButton.isSelected = false
//            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
//        }else{
            self.priceButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
            self.allButton.layer.borderColor = YDLabelColor.cgColor
            self.priceButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.isSelected = true
            self.priceButton.isSelected = false
            self.volumeButton.isSelected  = false
//        }
        
        searchGoodsViewModel.updateDataBlock = { [unowned self] in
//            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        searchGoodsViewModel.refreshDataSource(name: self.searchName, sort:"count", deviceNumber:uuid ?? "")
        
    }
    //  全部商品价格
    @objc func reconPriceGoodsListButtonClick(){
        if self.priceButton.isSelected == true {
            self.priceButton.isSelected = false
            self.priceButton.setTitleColor(YDLabelColor, for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "orde_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YDLabelColor.cgColor
            
            searchGoodsViewModel.updateDataBlock = { [unowned self] in
//                self.tableView.uHead.endRefreshing()
                // 更新列表数据
                self.tableView.reloadData()
            }
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            searchGoodsViewModel.refreshDataSource(name: self.searchName, sort:"desc", deviceNumber:uuid ?? "")
        }else{
            self.volumeButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "order_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YDLabelColor.cgColor
            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.isSelected = false
            self.priceButton.isSelected = true
            self.volumeButton.isSelected  = false
            searchGoodsViewModel.updateDataBlock = { [unowned self] in
//                self.tableView.uHead.endRefreshing()
                // 更新列表数据
                self.tableView.reloadData()
            }
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            searchGoodsViewModel.refreshDataSource(name: self.searchName, sort:"asc", deviceNumber:uuid ?? "")
        }
        
    }
    //  全部商品销量
    @objc func reconVolumeGoodsListButtonClick(){
//        if self.volumeButton.isSelected == true {
//            self.volumeButton.isSelected = false
//            self.volumeButton.setTitleColor(YDLabelColor, for: UIControl.State.normal)
//        }else{
            self.priceButton.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
            self.priceButton.setImage(UIImage(named: "default_Select"), for: UIControl.State.normal)
            self.priceButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.allButton.layer.borderColor = YMColor(r: 238, g: 238, b: 238, a: 1).cgColor
            self.volumeButton.layer.borderColor = YDLabelColor.cgColor
            self.allButton.isSelected = false
            self.priceButton.isSelected = false
            self.volumeButton.isSelected  = true
//        }
        searchGoodsViewModel.updateDataBlock = { [unowned self] in
//            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        searchGoodsViewModel.refreshDataSource(name: self.searchName, sort:"saleNums", deviceNumber:uuid ?? "")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isLetterWithChinese(string) == true || string == ""{
            return true
        }else{
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty != true{
            let nameDate:Data = textField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
            let nameStr:String = String.init(data:nameDate, encoding:String.Encoding.utf8) ?? ""
            self.searchName = nameStr
            requestSearchGoodsDate()
            self.searchField.resignFirstResponder()
        }
    }
    //    搜索
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty != true{
            let nameDate:Data = textField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
            let nameStr:String = String.init(data:nameDate, encoding:String.Encoding.utf8) ?? ""
            self.searchName = nameStr
            requestSearchGoodsDate()
            self.searchField.resignFirstResponder()
      
            return true
        }else{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入搜索内容"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return true
        }
    }
}
extension  YDHomeSearchGoodsViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGoodsViewModel.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if searchGoodsViewModel.numberOfRowsInSection(section: section) <= 0{
            return LBFMScreenHeight
        }else{
            return 0
        }
        
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDHomeSearchBarFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDHomeSearchBarFooterViewID) as! YDHomeSearchBarFooterView
        footerView.goodsName = self.searchName
        return footerView
    }
    //MARK:- TableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDHomeSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDHomeSearchTableViewCellID, for: indexPath) as! YDHomeSearchTableViewCell
        cell.seearchGoodsModel = searchGoodsViewModel.searchGoodsListModel![indexPath.row]
        cell.addGoods.tag = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goodsModel = searchGoodsViewModel.searchGoodsListModel![indexPath.row]
        let goodsVC = YDShoppingViewController()
        goodsVC.goodsId = goodsModel.id ?? ""
        goodsVC.goodsCode = goodsModel.code ?? ""
        self.navigationController?.pushViewController(goodsVC, animated: true)
    }
    
}
extension  YDHomeSearchGoodsViewController:YDHomeSearchTableViewCellDelegate{
    func plusSelctTableViewCell(button: UIButton, cell: YDHomeSearchTableViewCell, icon: UIImageView) {
        var rect : CGRect = cell.frame
        //获取当前cell的相对坐标
        rect.origin.y = (rect.origin.y - tableView.contentOffset.y)
        
        var imageViewRect : CGRect = icon.frame
        imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y+44
        imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x+88
        print("===================%@",rect.origin.y)
        print("++++++++++++++++%@",tableView.contentOffset.y)
        print("---------------%@",imageViewRect.origin.y)
        ShoppingCarTool().startAnimationTop(view: icon, andRect: imageViewRect, andFinishedRect: CGPoint(x:(LBFMScreenWidth/4 * 3)-20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
            
            //                let tabBtn : UIView = (self.tabBarController?.tabBar.subviews[2])!
            //                ShoppingCarTool().shakeAnimation(shakeView: tabBtn)
        })
        //添加到已购买数组之中
        self.addGoodArray.append(searchGoodsViewModel.searchGoodsListModel![button.tag])
        let goodsModel = searchGoodsViewModel.searchGoodsListModel![button.tag]
//        YDShopCartViewModel.share().refreshClassfiyDataSource(deviceNumber: uuid ?? "", memberId: userMemberId)
    YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: goodsModel.code ?? "", count:1,deviceNumber: YDInfoTool.getUUid(),memberId: YDInfoTool.getMemberId(),status:1)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount += 1
                    self.countLabel.text = String(self.cartCount)
                    self.countLabel.isHidden = false
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                    YDShopCartViewModel.share().refreshGoodsCart()
//                    NotificationCenter.default.post(name: NSNotification.Name.init(kShopCartAddGoods), object: goodsModel)
                }
            }
            }
        }
        print("-------------------%@",self.addGoodArray.count)
      

    }
    
    
}
