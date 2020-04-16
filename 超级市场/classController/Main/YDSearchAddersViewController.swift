//
//  YDSearchAddersViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDSearchAddersViewControllerDelegate:NSObjectProtocol{
    func returnAddersValue(city:String,adders:String,longitude:CGFloat,latitude:CGFloat ,code:String)
}
class YDSearchAddersViewController: YDBasicViewController ,AMapSearchDelegate,MAMapViewDelegate,UITextFieldDelegate{
    var tableData: Array<AMapPOI>!
    var search: AMapSearchAPI!
    var currentRequest: AMapInputTipsSearchRequest?
    let request = AMapReGeocodeSearchRequest()
    let mapView = MAMapView()
    
    weak var delegate : YDSearchAddersViewControllerDelegate?
    
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+300, width:LBFMScreenWidth, height:LBFMScreenHeight - LBFMNavBarHeight - 300), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var searchBtn:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"searchImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var searchImage:UIView = {
         let searchView = UIView()
         searchView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
         return searchView
     }()
    private lazy var searchField:UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        field.font = UIFont.systemFont(ofSize: 13)
        field.backgroundColor = YMColor(r: 246, g: 246, b:246, a: 1)
        field.placeholder = "请输入收货地址"
        field.returnKeyType = .search
        field.leftViewMode = .always
        field.delegate = self
//        field.leftView = searchBtn
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        return field
    }()
    
    lazy var backView : UIView = {
        let backview  = UIView()
        backview.backgroundColor = UIColor.white
        backview.isHidden = true
        return backview
    }()
    lazy var addersImage : UIImageView = {
        let addser = UIImageView()
        addser.image = UIImage(named: "selectAddersImage")
        return addser
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索地址"
        self.view.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            self.searchImage.addSubview(self.searchBtn)
            self.searchField.leftView = self.searchImage
        }else{
            self.searchField.leftView = self.searchBtn
        }
        AMapServices.shared().enableHTTPS = true
        mapView.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 300)
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.zoomLevel = 14
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        self.view.addSubview(mapView)

        self.view.addSubview(self.searchField)
        self.searchField.frame = CGRect(x: 30, y: LBFMNavBarHeight+10, width: LBFMScreenWidth-60, height: 30)
        
        self.view.addSubview(self.addersImage)
        self.addersImage.frame  = CGRect(x: (LBFMScreenWidth - 20)*0.5, y: 190, width: 20, height: 20)
        
        
        
        tableData = Array()
//        initSearch()
        
        self.view.addSubview(self.tableView)
        
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: LBFMNavBarHeight+50, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight+50)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.tableView.frame = CGRect(x: 0, y:LBFMNavBarHeight+50, width: LBFMScreenWidth, height: LBFMScreenHeight-LBFMNavBarHeight-50)
        print("文本输入内容将要发生变化（每次输入都会调用）")
        searchTip(withKeyword: textField.text ?? "" + string)
        print(textField.text! + string)
        print("文本输入内容将要发生变化",textField.text,string)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            self.tableView.frame = CGRect(x:0, y:LBFMNavBarHeight+300, width:LBFMScreenWidth, height:LBFMScreenHeight - LBFMNavBarHeight - 300)
            print("文本输入内容将要发生变化（每次输入都会调用）")
            return true
    }
//    搜索
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchField.resignFirstResponder()
        searchTip(withKeyword: textField.text)
        return true
    }
//    结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchField.resignFirstResponder()
        searchTip(withKeyword: textField.text)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchField.resignFirstResponder()
    }
    func mapViewRegionChanged(_ mapView: MAMapView!) {
//        searchView()
    }
//    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
//        searchView()
//    }
    func mapView(_ mapView: MAMapView!, mapDidZoomByUser wasUserAction:Bool) {
//         searchView()
    }
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        searchView()
    }

    func searchView() {
        search = AMapSearchAPI()
        search.delegate = self
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = "地名地址信息|商务住宅|公司企业"
        request.requireExtension = true
        request.requireSubPOIs = true
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(mapView.centerCoordinate.latitude), longitude: CGFloat(mapView.centerCoordinate.longitude))
        search.aMapPOIKeywordsSearch(request)
    }

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
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if searchController.isActive && searchController.searchBar.text != "" {
            searchController.searchBar.placeholder = searchController.searchBar.text
        }
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
    

    

   
}
extension YDSearchAddersViewController : UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
            return tableData.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 60

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cellIdentifier = "demoCellIdentifier"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
            }
            if !tableData.isEmpty {
                
                let tip = tableData[indexPath.row]
                cell!.textLabel?.text = tip.name
                cell!.detailTextLabel?.text = tip.province + tip.city + tip.district + tip.name
//               cell!.detailTextLabel?.text =  tip.pcode + tip.citycode + tip.adcode
            }
            
            return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tip = tableData[indexPath.row]
        let adders = tip.city + tip.district + tip.name
        let code = "\(tip.pcode ?? "")," + "\(tip.citycode ?? "")," + "\(tip.adcode ?? "")"
        delegate?.returnAddersValue(city:tip.city,adders:adders, longitude: tip.location.longitude, latitude: tip.location.latitude ,code:code)
        self.navigationController?.popViewController(animated: true)
    }
}
