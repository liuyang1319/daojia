//
//  TipViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class TipViewController: YDBasicViewController ,AMapSearchDelegate,UITextFieldDelegate{
    var tableView: UITableView!
    var tableData: Array<AMapPOI>!
    var search: AMapSearchAPI!
    var currentRequest: AMapInputTipsSearchRequest?
    let request = AMapReGeocodeSearchRequest()
    var seaderAdders = String()
    private lazy var searchBtn:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"searchImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var searchView:UIView = {
        let searchView = UIView()
        searchView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return searchView
    }()
    private lazy var searchField:UITextField = {
        let field = UITextField()
        field.delegate = self
        field.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        field.font = UIFont.systemFont(ofSize: 13)
        field.backgroundColor = YMColor(r: 246, g: 246, b:246, a: 1)
        field.placeholder = "请输入收获地址"
        field.returnKeyType = .search
        field.leftViewMode = .always
//        field.leftView = searchBtn
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        return field
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择收获地址"
        self.view.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            self.searchView.addSubview(self.searchBtn)
            self.searchField.leftView = self.searchView
        }else{
            self.searchField.leftView = self.searchBtn
        }
        tableData = Array()
        initSearch()
        initTableView()
        self.searchField.delegate = self
        self.view.addSubview(self.searchField)
        self.searchField.frame = CGRect(x: 30, y: LBFMNavBarHeight + 10, width: LBFMScreenWidth-60, height: 35)
        
        
    }
    func initTableView() {
        
        let tableY = self.navigationController!.navigationBar.frame.maxY
        tableView = UITableView(frame: CGRect(x: 0, y:LBFMNavBarHeight+50, width: self.view.bounds.width, height: self.view.bounds.height - tableY), style: UITableView.Style.plain)
        tableView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        tableView.isHidden = !textField.isEditing
        searchTip(withKeyword:seaderAdders + textField.text! + string)
        print(seaderAdders + textField.text! + string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTip(withKeyword:seaderAdders + textField.text!)
        self.searchField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        searchTip(withKeyword:seaderAdders + textField.text!)
        self.searchField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchField.resignFirstResponder()
    }

    
    //MARK: - Action
    
    func searchTip(withKeyword keyword: String?) {
        
        print("keyword \(String(describing: keyword))")
        if keyword == nil || keyword! == "" {
            return
        }
        
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = keyword

        request.requireExtension = true
        request.requireSubPOIs = true
        search.aMapPOIKeywordsSearch(request)
        
//        currentRequest = request
//        search.aMapInputTipsSearch(request)
    }
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        if response.count == 0 {
            return
        }
        tableData.removeAll()
        print("++++++++++++++++%@",response)
        for aTip in response.pois {
            
            tableData.append(aTip)
        }
        tableView.reloadData()
    }
    
//    func onInputTipsSearchDone(_ request: AMapInputTipsSearchRequest!, response: AMapInputTipsSearchResponse!) {
//
//        if currentRequest == nil || currentRequest! != request {
//            return
//        }
//
//        if response.count == 0 {
//            return
//        }
//
//        tableData.removeAll()
//        for aTip in response.tips {
//
//            tableData.append(aTip)
//        }
//        tableView.reloadData()
//    }

   
}
extension  TipViewController: UITableViewDataSource, UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //MARK:- TableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "demoCellIdentifier"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if !tableData.isEmpty {
            
            let tip = tableData[indexPath.row]
            cell!.textLabel?.text = tip.name
            cell!.detailTextLabel?.text = tip.district + tip.address
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
                let tip = tableData[indexPath.row]
                if tip.location != nil {
                    NotificationCenter.default.post(name: NSNotification.Name.init("sendValue"), object: self,userInfo: ["addserName":tip.name,"addserLatitude":tip.location.latitude,"addserLongitude":tip.location.longitude])
                    UserDefaults.AccountInfo.set(value:tip.name, forKey:.addersName)
                    UserDefaults.standard.set("", forKey: "AddersDictionary")
                    NotificationCenter.default.post(name: NSNotification.Name("YDLocationAddersViewControllerAdders"), object: self, userInfo:nil)
                    self.navigationController?.popToRootViewController(animated: true)
                    guard let delegate = UIApplication.shared.delegate as? AppDelegate,let tabBarController = delegate.window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers  else {
                        
                        return
                    }
                    
                    for item in viewControllers {
                        guard let navController = item as? UINavigationController, let rootViewController = navController.viewControllers.first else { continue }
                        if rootViewController is YDHomeViewController {
                            tabBarController.selectedViewController = navController
                            break
                        }
                    }
        
                }

    }

}
