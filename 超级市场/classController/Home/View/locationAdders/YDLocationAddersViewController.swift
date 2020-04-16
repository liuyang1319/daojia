//
//  YDLocationAddersViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import Alamofire
protocol YDLocationAddersViewControllerDelegate:NSObjectProtocol{
    func returnAddersValue(adders:String)
}

class YDLocationAddersViewController: YDBasicViewController,AMapSearchDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    var picker: AddressPickerView?
    let YDLocationAddersTableViewCellID = "YDLocationAddersTableViewCell"
    var addersTitile = String()
    var cityTitle = String()
    var addersInfo = String()
    weak var delegate : YDLocationAddersViewControllerDelegate?
    var searchController: UISearchController!
    var tableData: Array<AMapTip>!
    var search: AMapSearchAPI!
    var currentRequest: AMapInputTipsSearchRequest?
    let request = AMapReGeocodeSearchRequest()
    
    let locationManager = AMapLocationManager()
    let locationManager1 = CLLocationManager()
    
    
    
    private lazy var backLabel : UILabel = {
        let backView = UILabel()
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        backView.layer.borderColor = YMColor(r: 0, g: 0, b: 0, a: 0.1).cgColor
        backView.layer.borderWidth = 1;
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    
    private lazy var iamgeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"adders_Image"), for: UIControl.State.normal)
        return button
    }()
    
    public lazy var adderButton : UIButton = {
        let button = UIButton()
        button.setTitle(cityTitle, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectCityAddersButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "select_city"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()

    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        return label
    }()
    private lazy var searchBtn:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"searchImage"), for: UIControl.State.normal)
        return button
    }()
    private lazy var searchField:UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth - 140, height: 30)
        field.font = UIFont.systemFont(ofSize: 13)
//        field.backgroundColor = YMColor(r: 246, g: 246, b:246, a: 1)
        field.placeholder = "请输入收获地址"
        field.returnKeyType = .search
        field.leftViewMode = .always
        field.leftView = searchBtn
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        return field
    }()
    private lazy var searchAdders:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchAddersButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()

    private lazy var addersLabel : UILabel = {
        let label = UILabel()
        label.text = "定位地址"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationBut:UIButton = {
        let button = UIButton()
        button.setTitle("重新定位", for: UIControl.State.normal)
        button.setImage(UIImage(named: "location_image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(anewlocationButtonClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(YDLabelColor, for: UIControl.State.normal)
        return button
    }()
    private let YDLocationAddersHeaderViewID      = "YDLocationAddersHeaderView"
    
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+120, width:LBFMScreenWidth, height:LBFMScreenHeight - LBFMNavBarHeight - 100), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(YDLocationAddersHeaderView.self, forHeaderFooterViewReuseIdentifier: YDLocationAddersHeaderViewID)
        tableView.register(YDLocationAddersTableViewCell.self, forCellReuseIdentifier: YDLocationAddersTableViewCellID)
        return tableView
    }()
    lazy var viewModel: YDEditAddersViewModel = {
        return YDEditAddersViewModel()
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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        currentNetReachability()
        if isUserLogin() != true{
            setupLoadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择收货地址"
        self.view.backgroundColor = UIColor.white
//        地址信息
        if isUserLogin() != true{
                setupLoadData()
        }
        self.addersInfo = UserDefaults.AccountInfo.string(forKey:.addersInfo) ?? ""
        self.view.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 15, y:LBFMNavBarHeight+2, width: LBFMScreenWidth-30, height: 40)
        
        self.view.addSubview(self.iamgeButton)
        self.iamgeButton.frame = CGRect(x: 25, y: LBFMNavBarHeight+15, width: 15, height: 15)
        
        self.view.addSubview(self.adderButton)
        self.adderButton.frame = CGRect(x: self.iamgeButton.frame.maxX, y:LBFMNavBarHeight + 10, width: 80, height: 20)
        
        
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: self.adderButton.frame.maxX+5, y:LBFMNavBarHeight + 10, width: 1, height: 20)
        
        self.view.addSubview(self.searchField)
        self.searchField.frame = CGRect(x: self.lineLabel.frame.maxX+5, y: LBFMNavBarHeight + 5, width: LBFMScreenWidth-160, height: 30)

        self.view.addSubview(self.searchAdders)
        self.searchAdders.frame = CGRect(x: self.lineLabel.frame.maxX+5, y: LBFMNavBarHeight + 5, width: LBFMScreenWidth-160, height: 30)
        
        self.view.addSubview(self.addersLabel)
        self.addersLabel.frame = CGRect(x: 15, y: self.iamgeButton.frame.maxY+30, width: 55, height: 15)
        self.view.addSubview(self.nameLabel)
        self.nameLabel.text = addersTitile as String
        self.nameLabel.frame = CGRect(x: 15, y: self.addersLabel.frame.maxY+10, width: LBFMScreenWidth-120, height: 20)

        
        self.view.addSubview(self.locationBut)
        self.locationBut.frame = CGRect(x:LBFMScreenWidth-95, y: self.addersLabel.frame.maxY+10, width: 80, height: 15)
        
        

        tableData = Array()
        initSearch()
        searchTip(withKeyword:addersTitile as String)
        self.view.addSubview(self.tableView)
     
        
        let config = AddressPickerColor()
        config.cancelBtn = YDLabelColor
        config.barViewBackground = .white
        config.pickerRowTitle = YMColor(r: 102, g: 102, b: 102, a: 1)
        
        picker = AddressPickerView.addTo(superView: view, colorConfig: config)
        picker = AddressPickerView.addTo(superView: view)
        picker?.delegate = self
        
//        无网络
        
        self.view.addSubview(self.wifiImage)
        self.wifiImage.frame = CGRect(x:115, y: 170, width: 260, height: 270)
        
        self.view.addSubview(self.titleName)
        self.titleName.frame = CGRect(x: (LBFMScreenWidth-180)*0.5, y:self.wifiImage.frame.maxY+10, width: 180, height: 40)
        
        self.view.addSubview(self.goHome)
        self.goHome.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y:self.titleName.frame.maxY+30, width: 240, height: 40)
        
    }
    //   检测网络状态
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
                self.locationBut.isUserInteractionEnabled = false
                self.nameLabel.text = "无法获取定位，请刷新重试"
                self.nameLabel.textColor = YMColor(r: 231, g: 55, b: 43, a: 1)
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.tableView.isHidden = true
                self.wifiImage.isHidden = false
                self.titleName.isHidden = false
                self.goHome.isHidden = false
                self.locationBut.isUserInteractionEnabled = false
                self.nameLabel.text = "无法获取定位，请刷新重试"
                self.nameLabel.textColor = YMColor(r: 231, g: 55, b: 43, a: 1)
                break
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                }
                self.wifiImage.isHidden = true
//                self.anewlocationButtonClick()
                self.locationBut.isUserInteractionEnabled = true
                self.nameLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
                self.tableView.isHidden = false
                if isUserLogin() != true{
                    self.setupLoadData()
                }
               self.tableView.reloadData()
            }
        
        }
        manager?.startListening()
    }
    //    重新加载
    @objc func finisMeRequestButtonClick(){
        currentNetReachability()


    }
    lazy var homeGoodsViewModel: YDHomeGoodsListViewModel = {
        return YDHomeGoodsListViewModel()
    }()
    func setupLoadData() {
        // 加载数据
        viewModel.updateDataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
//    选择城市
    @objc func selectCityAddersButtonClick(){
        if picker!.isHidden {
            picker!.show()
        } else {
            picker!.hide()
        }
    }
//    搜索地址
    @objc func searchAddersButtonClick(){
        print("----------%@",addersInfo)
//        if addersInfo.isEmpty == true {
            let search = TipViewController()
            search.seaderAdders = addersInfo
            self.navigationController?.pushViewController(search, animated: true)
//        }else{
//            let search = TipViewController()
//            search.seaderAdders = addersInfo
//            self.navigationController?.pushViewController(search, animated: true)
//        }
        
    }
//      重新定位
    @objc func anewlocationButtonClick(){
        self.nameLabel.text = "定位中..."
        self.locationManager1.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
        self.locationManager1.requestAlwaysAuthorization()                            //始终授权
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        
        self.locationManager.requestLocation(withReGeocode: true) { (location, regeocode, error) in
            if (error == nil){
                self.addersInfo =  regeocode!.province + regeocode!.city
                self.adderButton.setTitle(regeocode!.district, for: UIControl.State.normal)
                NotificationCenter.default.post(name: NSNotification.Name.init("restartLocation"), object: self,userInfo: ["addserName":regeocode!.poiName])
                UserDefaults.AccountInfo.set(value:regeocode!.poiName, forKey:.addersName)
                self.nameLabel.text = regeocode!.poiName
            }
            
        }
        
    }
    func searchTip(withKeyword keyword: String?) {
        
        print("keyword \(String(describing: keyword))")
        if keyword == nil || keyword! == "" {
            return
        }
        
        let request = AMapInputTipsSearchRequest()
        request.keywords = keyword
        
        currentRequest = request
        search.aMapInputTipsSearch(request)
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if searchController.isActive && searchController.searchBar.text != "" {
            searchController.searchBar.placeholder = searchController.searchBar.text
        }
    }
    
    
    func onInputTipsSearchDone(_ request: AMapInputTipsSearchRequest!, response: AMapInputTipsSearchResponse!) {
        
        if currentRequest == nil || currentRequest! != request {
            return
        }
        
        if response.count == 0 {
            return
        }
        
        tableData.removeAll()
        for aTip in response.tips {
            tableData.append(aTip)
        }
        tableView.reloadData()
    }

}
extension YDLocationAddersViewController: AddressPickerViewDelegate {
    func addressSure(provinceID: Int?, cityID: Int?, regionID: Int?) {

    }
    
    func addressSure(province: String?, city: String?, region: String?) {
        self.adderButton.setTitle(region, for: UIControl.State.normal)
        if province != nil && city != nil && region != nil {
            self.addersInfo = province! + city! + region!
        }
    }
}
extension YDLocationAddersViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            if viewModel.numberOfRowsInSection(section: section) > 0{
                if  viewModel.numberOfRowsInSection(section: section) <= 2{
                    return viewModel.numberOfRowsInSection(section: section)
                }else{
                    return 2
                }
            }else{
                return 0
            }
            
        }else{
            if tableData.count > 0{
                if tableData.count <= 5{
                    return tableData.count
                }else{
                    return 5
                }
            }else{
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:YDLocationAddersHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDLocationAddersHeaderViewID) as! YDLocationAddersHeaderView
        headerView.delegate = self
        if section == 0 {
            headerView.titleName = "我的收货地址"
            headerView.moreBtn.isHidden = false
        }else if section == 1{
            headerView.titleName = "附近地址"
            headerView.moreBtn.isHidden = true
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }else if section == 1 {
            return 50
        }else{
            return 0
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            if viewModel.numberOfRowsInSection(section: indexPath.section) > 0{
                return 90
            }else{
                return 10
            }
            
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:YDLocationAddersTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDLocationAddersTableViewCellID, for: indexPath) as! YDLocationAddersTableViewCell
            if viewModel.numberOfRowsInSection(section: indexPath.section) > 0{
                cell.categoryContentsModel = viewModel.ydAdderModel![indexPath.row]
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }else{
            let cellIdentifier = "demoCellIdentifier"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
            }
            if !tableData.isEmpty {
                
                let tip = tableData[indexPath.row]
                cell!.textLabel?.text = tip.name
                cell!.detailTextLabel?.text = tip.address
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let tip = tableData[indexPath.row]
            delegate?.returnAddersValue(adders: tip.name)
            self.navigationController?.popViewController(animated: true)
        }else if indexPath.section == 1{
            let tip = tableData[indexPath.row]
            UserDefaults.AccountInfo.set(value:tip.name, forKey:.addersName)
            UserDefaults.standard.set("", forKey: "AddersDictionary")
            NotificationCenter.default.post(name: NSNotification.Name("YDLocationAddersViewControllerAdders"), object: self, userInfo:nil)
            delegate?.returnAddersValue(adders: tip.name)
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension YDLocationAddersViewController :YDLocationAddersTableViewCellDelegate{
    func editSelectAddersTableViewCell(index: NSInteger) {
        
    }
    
    func loginSelectAddersTableViewCell() {
        let  login = YDUserLoginViewController()
        if #available(iOS 13.0, *) {
                   login.modalPresentationStyle = .fullScreen
               } else {
                                                  // Fallback on earlier versions
               }
        self.present(login, animated: true, completion: nil)
    }
    
    
}
//添加地址
extension YDLocationAddersViewController :YDLocationAddersHeaderViewDelegate{
    
    func addNewLocationAddeersHeaderView() {
        if isUserLogin() != true{
            let addVC = YDNewAddersViewController()
            self.navigationController?.pushViewController(addVC, animated: true)
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
