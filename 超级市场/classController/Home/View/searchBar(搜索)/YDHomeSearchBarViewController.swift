//
//  YDHomeSearchBarViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD

class YDHomeSearchBarViewController: YDBasicViewController,UITextFieldDelegate,UIScrollViewDelegate {
    fileprivate var hotSearchView: YDSearchView?
    fileprivate var historySearchView: YDSearchView?
    
    var hotSeachModel:[YDHomeHotListSearchModel]?
    var newSeachModel:[YDHomeNewListSearchModel]?
//    var footView = YDHomeSearchBarFooterView()
    
    var nameArray = [String]()
    var deleteBtn:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "deleteSerch_image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(deleteGoodseSearch), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    var tableView: UITableView!
    fileprivate let cleanHistoryButton: UIButton = UIButton()
    fileprivate let contentScrollView = UIScrollView(frame: ScreenBounds)
    fileprivate let searchBar = UISearchBar()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:40, height: 30)
        button.setTitle("取消", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var titleView:UIView = {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y:0, width:LBFMScreenWidth - 140, height: 30)
        leftView.backgroundColor = UIColor.white
        return leftView
    }()

    private lazy var searchBtn:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"searchImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var searchView:UIView = {
        let search = UIView()
        search.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return search
    }()
    func initTableView() {
        
        let tableY = self.navigationController!.navigationBar.frame.maxY
        tableView = UITableView(frame: CGRect(x: 0, y:LBFMNavBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - tableY), style: UITableView.Style.plain)
        tableView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        self.view.addSubview(tableView)
    }
    
    private lazy var searchField:UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        field.font = UIFont.systemFont(ofSize: 13)
        field.backgroundColor = YMColor(r: 246, g: 246, b:246, a: 1)
        field.placeholder = "搜索商品"
        field.returnKeyType = .search
        field.leftViewMode = .always
        field.delegate = self
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        return field
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        搜索热词，最近搜索
        requestSearchDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            self.searchView.addSubview(self.searchBtn)
            self.searchField.leftView = self.searchView
        }else{
            self.searchField.leftView = self.searchBtn
        }

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigationItem.titleView = titleView
        self.searchField.delegate = self
        self.titleView.addSubview(self.searchField)


        buildContentScrollView()

//       删除历史
        buildCleanHistorySearchButton()

        initTableView()

//
    }
    func requestSearchDate(){
         let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDHomeProvider.request(.getHomeSearchHotsInfo(deviceNumber: uuid ?? "")) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                    if json["success"] == true{
                         if json["data"].isEmpty != true{
                            if let hotSeachModel =
                                JSONDeserializer<YDHomeHotListSearchModel>.deserializeModelArrayFrom(json: json["data"]["goodsList"].description) {
                                self.hotSeachModel = hotSeachModel as? [YDHomeHotListSearchModel]
                                //        热门搜索
                                self.loadHotSearchButtonData()
                            }
                            if let newSeachModel =
                                JSONDeserializer<YDHomeNewListSearchModel>.deserializeModelArrayFrom(json: json["data"]["latelyList"].description) {
                                self.newSeachModel = newSeachModel as? [YDHomeNewListSearchModel]
                            //        最近搜索
                                self.loadHistorySearchButtonData()
                            }
                        }
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
//    删除最近搜索
    func requestDeleteSearchData(){
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDHomeProvider.request(.setHomeSearchDeleteName(deviceNumber: uuid ?? "")) { result  in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                if json["success"] == true{
                    self.requestSearchDate()
                    self.cleanHistoryButton.isHidden = true
                    self.deleteBtn.isHidden = true
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
    
//    搜索商品名
    func requestSearchGoodsDate(name:String){
//        let uuid = UIDevice.current.identifierForVendor?.uuidString
//        YDHomeProvider.request(.getHomeSearchGoodsInfo(name:name, deviceNumber: uuid ?? "")) { result  in
//            if case let .success(response) = result {
//                let data = try? response.mapJSON()
//                if data != nil{
//                let json = JSON(data!)
//                print("-------%@",json.count)
//                if json["success"] == true{
////                    if json["data"].arrayObject!.count > 0 {
////                        for (index,value) in json.enumerated(){
////                            var nameDict = json["data"]
////                            self.nameArray.append(nameDict[index]["name"].string!)
////                        }
////                    self.tableView.reloadData()
////                    }
//                }else{
//                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                    hud.mode = MBProgressHUDMode.text
//                    hud.label.text = json["error"]["errorMessage"].description
//                    hud.removeFromSuperViewOnHide = true
//                    hud.hide(animated: true, afterDelay: 1)
//                }
//            }
//            }
//        }
    }
    fileprivate func buildContentScrollView() {
        contentScrollView.backgroundColor = view.backgroundColor
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.delegate = self
        view.addSubview(contentScrollView)
    }
//    设置搜索关键字按钮
     func loadHotSearchButtonData() {
        var array = [String]()
        for (index,value) in self.hotSeachModel!.enumerated(){
            array.append(self.hotSeachModel![index].goodsName!)
            print("--------------%@",array)
        }

        var historySearch = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        if historySearch == nil {
            historySearch = [String]()
            UserDefaults.standard.set(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        }
        weak var tmpSelf = self
        let pathStr = Bundle.main.path(forResource: "SearchProduct", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: pathStr!))
        if array != nil {
//            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
//            array = (dict.object(forKey: "data")! as! NSDictionary).object(forKey: "hotquery") as? [String]
            if array.count > 0 {
                if historySearchView?.frame.maxY != nil{
                    hotSearchView = YDSearchView(frame: CGRect(x: 10, y:10, width: LBFMScreenWidth - 20, height: 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array) { (sender) -> () in
                    let str = sender.title(for: UIControl.State())
                    tmpSelf!.writeHistorySearchToUserDefault(str!)
                    tmpSelf!.searchField.text = sender.title(for: UIControl.State())
                    tmpSelf!.loadProductsWithKeyword(sender.title(for: UIControl.State())!)
                    
                    }
                }else{
                    hotSearchView = YDSearchView(frame: CGRect(x: 10, y:10, width: LBFMScreenWidth - 20, height: 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array) { (sender) -> () in
                        let str = sender.title(for: UIControl.State())
                        tmpSelf!.writeHistorySearchToUserDefault(str!)
                        tmpSelf!.searchField.text = sender.title(for: UIControl.State())
                        tmpSelf!.loadProductsWithKeyword(sender.title(for: UIControl.State())!)
                        
                    }
                }
                hotSearchView!.frame.size.height = hotSearchView!.searchHeight

                contentScrollView.addSubview(hotSearchView!)
            }
        }
    }
    
    fileprivate func loadHistorySearchButtonData() {
        if historySearchView != nil {
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        var array = [String]()
        for (index,value) in self.newSeachModel!.enumerated(){
            array.append(self.newSeachModel![index].goodsName!)
            print("--------------%@",array)
        }
        weak var tmpSelf = self;
//        let array = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        if array.count > 0 {
            if hotSearchView?.frame.maxY != nil{
                historySearchView = YDSearchView(frame: CGRect(x: 10, y:hotSearchView!.frame.maxY + 20, width: LBFMScreenWidth - 20, height: 0), searchTitleText: "最近搜索", searchButtonTitleTexts: array, searchButtonClickCallback: { (sender) -> () in
                let str = sender.title(for: UIControl.State())
                tmpSelf!.writeHistorySearchToUserDefault(str!)
                tmpSelf!.searchField.text = sender.title(for: UIControl.State())
                tmpSelf!.loadProductsWithKeyword(sender.title(for: UIControl.State())!)
                })
            }else{
                historySearchView = YDSearchView(frame: CGRect(x: 10, y:10, width: LBFMScreenWidth - 20, height: 0), searchTitleText: "最近搜索", searchButtonTitleTexts: array, searchButtonClickCallback: { (sender) -> () in
                    let str = sender.title(for: UIControl.State())
                    tmpSelf!.writeHistorySearchToUserDefault(str!)
                    tmpSelf!.searchField.text = sender.title(for: UIControl.State())
                    tmpSelf!.loadProductsWithKeyword(sender.title(for: UIControl.State())!)
                })
            }
            historySearchView!.frame.size.height = historySearchView!.searchHeight
            contentScrollView.addSubview(historySearchView!)
            updateCleanHistoryButton(false)
        }
    }

    func loadProductsWithKeyword(_ keyWord: String?) {
        if keyWord == nil || keyWord?.count == 0 {
            return
        }
    }
    // MARK: - Private Method
    fileprivate func writeHistorySearchToUserDefault(_ str: String) {
        self.searchField.resignFirstResponder()
//        tableView.isHidden = false
        requestSearchGoodsDate(name: str)
        let searchGoods = YDHomeSearchGoodsViewController()
        searchGoods.searchName = str
        self.navigationController?.pushViewController(searchGoods, animated: true)
    }
//    清空历史记录
    fileprivate func buildCleanHistorySearchButton() {

        cleanHistoryButton.setImage(UIImage(named:"deleteSerch_image"), for: UIControl.State.normal)
        if historySearchView?.frame.maxY != nil{
            cleanHistoryButton.isHidden = false
            self.deleteBtn.isHidden = false
        }else{
            cleanHistoryButton.isHidden = true
            self.deleteBtn.isHidden = true
        }
        
        
        cleanHistoryButton.addTarget(self, action: #selector(YDHomeSearchBarViewController.cleanSearchHistorySearch), for: UIControl.Event.touchUpInside)
        contentScrollView.addSubview(cleanHistoryButton)
        
        self.view.addSubview(self.deleteBtn)
    }
    @objc func deleteGoodseSearch(){
        requestDeleteSearchData()
    }
//    删除
    @objc func cleanSearchHistorySearch() {
        requestDeleteSearchData()
    }
//    更新位置
    fileprivate func updateCleanHistoryButton(_ hidden: Bool) {
        cleanHistoryButton.isHidden = hidden
        self.deleteBtn.isHidden = hidden
        if historySearchView != nil {
            self.deleteBtn.frame = CGRect(x:LBFMScreenWidth-50, y: historySearchView!.frame.maxY - 70 + LBFMNavBarHeight, width: 40, height: 40)
        }
    }
    
//    取消
    @objc func rightBarButtonClick(){
        self.searchField.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
//  删除输入框内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        tableView.isHidden = true
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isLetterWithChinese(string) == true || string == ""{
            return true
        }else{
            return false
        }
    }
//    搜索
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nameDate:Data = textField.text?.data(using:String.Encoding.nonLossyASCII, allowLossyConversion: true) as! Data
        let nameStr:String = String.init(data:nameDate, encoding:String.Encoding.utf8) ?? ""
        writeHistorySearchToUserDefault(nameStr)
        self.searchField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchField.resignFirstResponder()
    }
}

extension  YDHomeSearchBarViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }

    //MARK:- TableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "demoCellIdentifier"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = self.nameArray[indexPath.row]
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)

    }
    
}
