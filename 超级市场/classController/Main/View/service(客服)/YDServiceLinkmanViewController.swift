//
//  YDServiceLinkmanViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/28.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDServiceLinkmanViewController: YDBasicViewController {
    
    let YDServerLinkmanHeaderViewID = "YDServerLinkmanHeaderView"
    let YDServiceLinkmanTableViewCellID = "YDServiceLinkmanTableViewCell"
    let YDServerLinkManTwoHeaderViewID = "YDServerLinkManTwoHeaderView"
    var backView : UIView = {
        let back = UIView()
        back.backgroundColor = UIColor.white
        return back
    }()
    var serverBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(telpromptServerButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "list_cell_iamge"), for: UIControl.State.normal)
        return button
    }()
    var weChatBtn :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(weChatServerButtonClick), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "WeChat_ii_image"), for: UIControl.State.normal)
        return button
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "温馨提示：客服工作时间（9:00-23:00)"
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var serviceLinkmanViewModel: YDServiceLinkmanViewModel = {
        return YDServiceLinkmanViewModel()
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight-100), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(YDServerLinkmanHeaderView.self, forHeaderFooterViewReuseIdentifier: YDServerLinkmanHeaderViewID)
        tableView.register(YDServerLinkManTwoHeaderView.self, forHeaderFooterViewReuseIdentifier: YDServerLinkManTwoHeaderViewID)
        tableView.register(YDServiceLinkmanTableViewCell.self, forCellReuseIdentifier: YDServiceLinkmanTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "客服中心"
        requestClassifyGoodsDate()
        self.view.addSubview(self.tableView)
        
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-100, width: LBFMScreenWidth, height: 100)
        
        self.backView.addSubview(self.serverBtn)
        self.serverBtn.frame = CGRect(x: 15, y: 10, width: 170, height: 35)
        
        self.backView.addSubview(self.weChatBtn)
        self.weChatBtn.frame = CGRect(x: LBFMScreenWidth-185, y: 10, width: 170, height: 35)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: (LBFMScreenWidth-210)*0.5, y: self.serverBtn.frame.maxY+10, width: 210, height: 15)
    }
    func requestClassifyGoodsDate(){
        if  isUserLogin() != true{
            // 加载数据
            serviceLinkmanViewModel.updateDataBlock = { [unowned self] in
                // 更新列表数据
                self.tableView.reloadData()
            }
            self.serviceLinkmanViewModel.refreshServiceLinkmanList(supplierId: "38", token: UserDefaults.LoginInfo.string(forKey: .token)!, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)!)
        }
    }
    //打电话
    @objc func telpromptServerButtonClick(){
        let model = self.serviceLinkmanViewModel.serviceSiteInfoModel
        let phone = "telprompt://" + (model?.tell ?? "")
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.openURL(URL(string: phone)!)
        }
    }
//    微信聊天
    @objc func weChatServerButtonClick(){
        let model = self.serviceLinkmanViewModel.serviceSiteInfoModel
        let weChatVc = YDWeChatCodeViewController()
        weChatVc.imageCode = model?.wechatQrcode ?? ""
        weChatVc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        weChatVc.modalTransitionStyle = .crossDissolve
//        if #available(iOS 13.0, *) {
//            weChatVc.modalPresentationStyle = .fullScreen
//        } else {
//            // Fallback on earlier versions
//        }
        self.present(weChatVc,animated:true,completion:nil)
    }
}


extension YDServiceLinkmanViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.serviceLinkmanViewModel.serviceHelpInfoModel?.count ?? 0)+1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else{
            let model =  self.serviceLinkmanViewModel.serviceHelpInfoModel?[section - 1]
            if model?.isShow == false {
                return 0
            }else{
                return self.serviceLinkmanViewModel.serviceHelpInfoModel?[section-1].list?.count ?? 0
            }
        }
//        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
             return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDServiceLinkmanTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDServiceLinkmanTableViewCellID, for: indexPath) as! YDServiceLinkmanTableViewCell
        cell.number = indexPath.row
        cell.serviceHelpListModel = self.serviceLinkmanViewModel.serviceHelpInfoModel?[indexPath.section-1].list?[indexPath.row]
//        cell.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
//        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let headerView:YDServerLinkmanHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDServerLinkmanHeaderViewID) as! YDServerLinkmanHeaderView
            return headerView
        }else{
            let headerView:YDServerLinkManTwoHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDServerLinkManTwoHeaderViewID) as! YDServerLinkManTwoHeaderView
            headerView.serviceHelpInfoModel = self.serviceLinkmanViewModel.serviceHelpInfoModel?[section-1]
            headerView.listBtn.tag = section-1
//            headerView.titleImage = self.imageStr[section]
            headerView.delegate = self
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 65
        }else{
            return 50
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0{
        let content =  self.serviceLinkmanViewModel.serviceHelpInfoModel?[indexPath.section].list?[indexPath.row]
        let model = self.serviceLinkmanViewModel.serviceSiteInfoModel
        let serverInfo = YDServerPageInfoViewController()
        serverInfo.imageCode = model?.wechatQrcode ?? ""
        serverInfo.iphoneCell = model?.tell ?? ""
        serverInfo.serviceHelplistInfo = content
            self.navigationController?.pushViewController(serverInfo, animated: true)
            
        }
    }
}
extension YDServiceLinkmanViewController :YDServerLinkManTwoHeaderViewDelegate {
//    查看问题
    func serviceLinkmanLookListHeaderView(selectBtn: UIButton) {
        var model = self.serviceLinkmanViewModel.serviceHelpInfoModel?[selectBtn.tag]
//        selectBtn.isSelected = !selectBtn.isSelected
        if model?.isShow == false {
            if self.serviceLinkmanViewModel.serviceHelpInfoModel?.count ?? 0 > 0{
                for (index,var modelServer) in (self.serviceLinkmanViewModel.serviceHelpInfoModel?.enumerated())!{
                    if index == selectBtn.tag
                    {
                        modelServer.isShow = !selectBtn.isSelected
                        self.serviceLinkmanViewModel.serviceHelpInfoModel?.remove(at: index)
                        self.serviceLinkmanViewModel.serviceHelpInfoModel?.insert(modelServer, at: index)
                    }else{
                        modelServer.isShow = selectBtn.isSelected
                        self.serviceLinkmanViewModel.serviceHelpInfoModel?.remove(at: index)
                        self.serviceLinkmanViewModel.serviceHelpInfoModel?.insert(modelServer, at:index)
                    }
                }
            }
           
            self.tableView.reloadData()
        }else{
            for (index,var modelServer) in (self.serviceLinkmanViewModel.serviceHelpInfoModel?.enumerated())!{

                    modelServer.isShow = selectBtn.isSelected
                    self.serviceLinkmanViewModel.serviceHelpInfoModel?.remove(at: index)
                    self.serviceLinkmanViewModel.serviceHelpInfoModel?.insert(modelServer, at: index)
              
            }
            self.tableView.reloadData()
        }
        
    }
}
