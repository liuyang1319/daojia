//
//  YDRecruitInfoViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDRecruitInfoViewController: YDBasicViewController {
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "share_b_image"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "share_share_image"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    let YDRecruitInfoHeaderViewID = "YDRecruitInfoHeaderView"
    let YDRecruitPersonnelTableViewCellID = "YDRecruitPersonnelTableViewCell"
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        //        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData()}
        tableView.register(YDRecruitPersonnelTableViewCell.self, forCellReuseIdentifier: YDRecruitPersonnelTableViewCellID)
        tableView.register(YDRecruitInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: YDRecruitInfoHeaderViewID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBarTintColor = YDLabelColor
        navBarTitleColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        self.title = "辉鲜到家招聘·期待你的加入"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)

        self.view.addSubview(self.tableView)
    }
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    // - 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
        
        
    }
  
}
extension YDRecruitInfoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDRecruitPersonnelTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDRecruitPersonnelTableViewCellID, for: indexPath) as! YDRecruitPersonnelTableViewCell
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView:YDRecruitInfoHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDRecruitInfoHeaderViewID) as! YDRecruitInfoHeaderView
        headerView.delegate = self
        return headerView

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 850
    }
    
}
extension YDRecruitInfoViewController :YDRecruitInfoHeaderViewDelegate{
    func selectSubmitButtonClickHeaderView(name: String, iphone: String, city: String) {
        if name.isEmpty == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入姓名"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if iphone.isEmpty == true {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入手机号"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if city.isEmpty == true{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请输入城市"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        YDShopGoodsListProvider.request(.getRecruitPersonneCityList(name: name, phone: iphone, city: city, token:UserDefaults.LoginInfo.string(forKey: .token)! as String, memberPhone:UserDefaults.LoginInfo.string(forKey: .phone)! as String)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "提交成功"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
