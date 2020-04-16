//
//  YDSettingViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/19.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSettingViewController: YDBasicViewController {
     let YDSettingTableViewCellID = "YDSettingTableViewCell"
    var versionStr = String()
    lazy var footerView : UIView = {
        let footer = UIView()
        footer.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return footer
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Copyright©️2004-2019 云达版权所有"
        label.textAlignment = .center
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var quit : UIButton = {
       let button = UIButton()
        button.setTitle("退出登录", for: UIControl.State.normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action:#selector(exitLoginButtonClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        button.backgroundColor = YDLabelColor
        return button
    }()
    
    
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight+10, width:LBFMScreenWidth, height:LBFMScreenHeight - LBFMNavBarHeight-10), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.register(YDSettingTableViewCell.self, forCellReuseIdentifier: YDSettingTableViewCellID)
        return tableView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        let infoDictionary = Bundle.main.infoDictionary
        self.versionStr  = infoDictionary?["CFBundleShortVersionString"] as! String//主程序版本号
        self.footerView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMScreenHeight-180-LBFMNavBarHeight)
        self.footerView.addSubview(self.quit)
        self.quit.frame = CGRect(x: 15, y: 50, width: LBFMScreenWidth-30, height: 50)
        self.view.addSubview(self.tableView)
        
        self.footerView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 0, y: LBFMScreenHeight - LBFMNavBarHeight - 230, width: LBFMScreenWidth, height: 20)
        
    }
//    退出登录
    @objc func exitLoginButtonClick(){
        let alertController = UIAlertController(title: "确定退出登录？",
                                                message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil);
        
        let okAction = UIAlertAction(title: "确定", style: .default,
                                     handler: {action in
//                                        self.navigationController?.popViewController(animated: true)
                                        NotificationCenter.default.post(name: NSNotification.Name.init("refreshMain"), object:nil)
                                        UserDefaults.LoginInfo.set(value:"", forKey:.phone)
                                        UserDefaults.LoginInfo.set(value:"", forKey:.id)
                                        UserDefaults.LoginInfo.set(value:"", forKey:.token)
                                        
                                        //        UserDefaults.AccountInfo.set(value: "", forKey: .addersName)
                                        UserDefaults.AccountInfo.set(value: "", forKey: .age)
                                        UserDefaults.AccountInfo.set(value: "", forKey: .cityName)
                                        
                                        UserDefaults.adders.set(value: "", forKey: .addressCode)
                                        UserDefaults.adders.set(value: "", forKey: .addressRegion)
                                        UserDefaults.adders.set(value: "", forKey: .phone)
                                        UserDefaults.adders.set(value: "", forKey: .sex)
                                        UserDefaults.adders.set(value: "", forKey: .street)
                                        UserDefaults.adders.set(value: "", forKey: .type)
                                        
                                        let userDefault = UserDefaults.standard
                                        userDefault.setValue("", forKey: "AddersDictionary")
                                        NotificationCenter.default.post(name: NSNotification.Name(updeatAdders), object:nil)
                                        self.navigationController?.popViewController(animated:true)
                                        
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        if #available(iOS 13.0, *) {
            alertController.modalPresentationStyle = .fullScreen
        } else {
        }
        self.present(alertController, animated: true, completion: nil)
       
    }

}

extension YDSettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
//        if indexPath.row == 1{
//            let cell:YDSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDSettingTableViewCellID, for: indexPath) as! YDSettingTableViewCell
//            cell.stateLabel.text = "帮助与客服"
//            cell.cartImage.image = UIImage(named: "Customer_service")
//            return cell
//        }else if indexPath.row == 2{
//            let cell:YDSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDSettingTableViewCellID, for: indexPath) as! YDSettingTableViewCell
//            cell.stateLabel.text = "邀请好友"
//            cell.cartImage.image = UIImage(named: "invitation_Image")
//            return cell
//        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
            }
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.textLabel?.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
            cell?.detailTextLabel?.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            if indexPath.row==0{
                cell?.textLabel?.text = "登陆密码"
                cell?.detailTextLabel?.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
                if  UserDefaults.LoginInfo.string(forKey:.status) == "1"{
                    cell?.detailTextLabel?.text = "未填写"
                }else if UserDefaults.LoginInfo.string(forKey:.status) == "2"{
                    cell?.detailTextLabel?.text = "修改"
                }else{
                    cell?.detailTextLabel?.text = "未填写"
                }
                cell?.accessoryType = .disclosureIndicator
            }else if indexPath.row==1{
                cell?.textLabel?.text = "清除缓存"
                cell?.detailTextLabel?.text = getCacheSize()
            }else if indexPath.row==2{
                cell?.textLabel?.text = "关于系统"
                cell?.detailTextLabel?.text = self.versionStr
                cell?.accessoryType = .disclosureIndicator
            }
            return cell!
            
//        }
 
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if  UserDefaults.LoginInfo.string(forKey:.status) == "1"{
                let password = YDOneSetPasswordViewController()
                self.navigationController?.pushViewController(password, animated: true)
            }else if UserDefaults.LoginInfo.string(forKey:.status) == "2"{
                let password = YDUserEditPasswordViewController()
                self.navigationController?.pushViewController(password, animated: true)
            }
        }else if indexPath.row == 1{
             let alertController = UIAlertController(title: "是否清楚缓存？",
                                                                        message: "", preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {action in
            //                        self.navigationController?.popViewController(animated: true)
                                    
                                })
                                let okAction = UIAlertAction(title: "确定", style: .default,
                                                             handler: {action in
                                                                self.clearCache()
                                })
                                
                                alertController.addAction(cancelAction)
                                alertController.addAction(okAction)
                                if #available(iOS 13.0, *) {
                                    alertController.modalPresentationStyle = .fullScreen
                                } else {
                                }
                                self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getCacheSize()-> String {
            // 取出cache文件夹目录
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

            // 取出文件夹下所有文件数组
            let fileArr = FileManager.default.subpaths(atPath: cachePath!)

            //快速枚举出所有文件名 计算文件大小
            var size = 0
            for file in fileArr! {

                // 把文件名拼接到路径中
                let path = cachePath! + ("/\(file)")
                // 取出文件属性
                let floder = try! FileManager.default.attributesOfItem(atPath: path)
                // 用元组取出文件大小属性
                for (key, fileSize) in floder {
                    // 累加文件大小
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            }

            let totalCache = Double(size) / 1024.00 / 1024.00
            return String(format: "%.2fKB", totalCache)
    }
    func clearCache() {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
            // 遍历删除
            for file in fileArr! {

                let path = (cachePath! as NSString).appending("/\(file)")

                if FileManager.default.fileExists(atPath: path) {

                    do {

                        try FileManager.default.removeItem(atPath: path)

                    } catch {
                    }
                }
            }
            self.getCacheSize()
            self.tableView.reloadData()
        }
}
