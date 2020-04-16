//
//  YDSelectShopMenuViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/11.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSelectShopMenuViewController: UIViewController {
    let YDSelectShopMenuTableViewCellID = "YDSelectShopMenuTableViewCell"
    var shopMenu = [YDShopMenuList]()
    var height = Int()
    private lazy var backImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"back_image_menu")
        return imageView
    }()
    private lazy var nullImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"bin_image")
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        title.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        return title
    }()
    
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:30, y:LBFMNavBarHeight+40, width:LBFMScreenWidth-60, height:CGFloat(height*70)), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(YDSelectShopMenuTableViewCell.self, forCellReuseIdentifier: YDSelectShopMenuTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom

        if shopMenu.count > 0{

            self.view.addSubview(self.backImage)
            self.backImage.frame = CGRect(x: 15, y: LBFMNavBarHeight-10, width: LBFMScreenWidth-30, height: CGFloat(height*70)+60)
            self.view.addSubview(self.titleLabel)
            self.titleLabel.text = String(height) + "个仓可为您配送"
            self.titleLabel.frame = CGRect(x: 30, y: LBFMNavBarHeight+10, width: LBFMScreenWidth-60, height: 20)
            self.view.addSubview(self.tableView)
            self.tableView.reloadData()
        }else{
            
            self.view.addSubview(self.backImage)
            self.backImage.frame = CGRect(x: 15, y: LBFMNavBarHeight-10, width: LBFMScreenWidth-30, height:140)
            
            self.view.addSubview(self.titleLabel)
            self.titleLabel.text = "您当前位置没有仓可配送"
            self.titleLabel.frame = CGRect(x: 30, y: LBFMNavBarHeight+10, width: LBFMScreenWidth-60, height: 20)
            
            self.view.addSubview(self.nullImage)
            self.nullImage.frame = CGRect(x: (LBFMScreenWidth-70)*0.5, y: self.titleLabel.frame.maxY+10, width: 70, height: 70)
        }
       
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension YDSelectShopMenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return shopMenu.count
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
            return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:YDSelectShopMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDSelectShopMenuTableViewCellID, for: indexPath) as! YDSelectShopMenuTableViewCell
        cell.shopMenuListModel = self.shopMenu[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = self.shopMenu[indexPath.row]
         NotificationCenter.default.post(name: NSNotification.Name(rawValue:"refreshMenuLisetIcon"), object: menu.siteImg)
        UserDefaults.warehouseManagement.set(value:menu.supplierId, forKey:.supplierId)
        self.dismiss(animated: true, completion: nil)
    }
    
}
