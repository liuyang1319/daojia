//
//  YDEditAddersViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import MJRefresh
class YDEditAddersViewController: YDBasicViewController {
    let YDEditAddersTableViewCellID = "YDEditAddersTableViewCell"
    let YDEditAddersListFooterViewID = "YDEditAddersListFooterView"
    //    顶部刷新
    let header = MJRefreshNormalHeader()
    lazy var linelabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+0.5, width:LBFMScreenWidth, height:LBFMScreenHeight+80+0.5), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.mj_header = header
//        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData()}
        tableView.register(YDEditAddersTableViewCell.self, forCellReuseIdentifier: YDEditAddersTableViewCellID)
        tableView.register(YDEditAddersListFooterView.self, forHeaderFooterViewReuseIdentifier: YDEditAddersListFooterViewID)
        return tableView
    }()
    private lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    private lazy var finishLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(finishIphoneButtonClick), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        button.setTitle("+ 新建地址", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    lazy var viewModel: YDEditAddersViewModel = {
        return YDEditAddersViewModel()
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setupLoadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "管理收货地址"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.linelabel)
        self.linelabel.frame = CGRect(x: 0, y:LBFMNavBarHeight, width: LBFMScreenWidth, height: 0.5)
        header.setRefreshingTarget(self, refreshingAction: #selector(YDEditAddersViewController.headerRefresh))
        header.activityIndicatorViewStyle = .gray
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.backView)

        if isIphoneX == true {
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-80, width: LBFMScreenWidth, height: 80)
            self.backView.addSubview(self.finishLabel)
            self.finishLabel.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y: 10, width: 240, height: 40)
        }else{
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-60, width: LBFMScreenWidth, height: 60)
            self.backView.addSubview(self.finishLabel)
            self.finishLabel.frame = CGRect(x: (LBFMScreenWidth-240)*0.5, y: 10, width: 240, height: 40)
        }


        
    }
    //    下啦刷新
    @objc func headerRefresh(){
        setupLoadData()
    }
    func setupLoadData() {
        // 加载数据
        viewModel.updateDataBlock = { [unowned self] in
            self.tableView.mj_header.endRefreshing()
           
            if self.viewModel.ydAdderModel?.count == 0 {
               self.backView.isHidden = true
            }else{
                 self.backView.isHidden = false
            }
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    @objc func finishIphoneButtonClick(){
        let newVC = YDNewAddersViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }

}

extension YDEditAddersViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if viewModel.numberOfRowsInSection(section: section) == 0{
//            let userDefault = UserDefaults.standard
//
//            userDefault.set("", forKey: "AddersDictionary")
//        }

            return viewModel.numberOfRowsInSection(section: section)
   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 80

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell:YDEditAddersTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDEditAddersTableViewCellID, for: indexPath) as! YDEditAddersTableViewCell
            cell.delegate = self
            cell.categoryContentsModel = viewModel.ydAdderModel![indexPath.row]
            cell.selectionStyle = .none
            cell.editBtn.tag = indexPath.row
            return cell
       
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if viewModel.numberOfRowsInSection(section: section) > 0{
            return 0
        }else{
            return LBFMScreenHeight
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDEditAddersListFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDEditAddersListFooterViewID) as! YDEditAddersListFooterView
        footerView.delegate = self
//        if viewModel.numberOfRowsInSection(section: section) == 0{
//            footerView.isShow = "1"
//        }
        footerView.backgroundColor = UIColor.white
        return footerView
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let alertController = UIAlertController(title: "是否删除地址？",
                                                    message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {action in

                
            })
            let okAction = UIAlertAction(title:"确定", style: .default,
                                         handler: {action in
                                            let adders =   self.viewModel.ydAdderModel![indexPath.row]
                                            YDUserAddersProvider.request(.setDeleteAdders(addressId:adders.id!, memberPhone:  UserDefaults.LoginInfo.string(forKey: .phone)! as String, token: UserDefaults.LoginInfo.string(forKey: .token)! as String)) { result  in
                                                if case let .success(response) = result {
                                                    let data = try? response.mapJSON()
                                                    let json = JSON(data!)
                                                    print("-------%@",json)
                                                    if json["success"] == true{
                                                        if  json["data"] == 1{
                                                        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                        hud.mode = MBProgressHUDMode.text
                                                        hud.label.text = "删除成功"
                                                        hud.removeFromSuperViewOnHide = true
                                                        hud.hide(animated: true, afterDelay: 1)
                                                        //刷新tableview
//                                                        self.viewModel.ydAdderModel?.remove(at: indexPath.row)
//                                                        self.backView.isHidden = true
//                                                        self.tableView.reloadData()
                                                        self.setupLoadData()
                                                        //                        tableView.deleteRows(at: [indexPath.row], with: UITableView.RowAnimation.automatic)
                                                        }else{
                                                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                                                            hud.mode = MBProgressHUDMode.text
                                                            hud.label.text = "删除失败"
                                                            hud.removeFromSuperViewOnHide = true
                                                            hud.hide(animated: true, afterDelay: 1)
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
                                            
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            if #available(iOS 13.0, *) {
                alertController.modalPresentationStyle = .fullScreen
            } else {
                                                                                     // Fallback on earlier versions
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.ydAdderModel![indexPath.row]
        let userDefault = UserDefaults.standard
        let dictionary = ["addressPhone":model.phone ?? "","sex":model.sex ?? "","name":model.name ?? "","type":model.type ?? "","addressRegion":model.addressRegion ?? "","street":model.street ?? "","addressCode":model.addressCode ?? "","addressId":model.id ?? ""] as [String : Any]
        userDefault.set(dictionary, forKey: "AddersDictionary")
        
        NotificationCenter.default.post(name: NSNotification.Name(updeatAdders), object:nil)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension YDEditAddersViewController: YDEditAddersTableViewCellDelegate{
    func editSelectAddersTableViewCell(index: NSInteger) {
        let editVC = YDAddEditAddersViewController()
        editVC.categoryContentsModel = viewModel.ydAdderModel?[index]
        self.navigationController?.pushViewController(editVC, animated: true)
    }

}
extension YDEditAddersViewController: YDEditAddersListFooterViewDelegate{
    func newAddersListFooterView() {
        let newVC = YDNewAddersViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }

}
