//
//  YDRecruitPersonnelViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDRecruitPersonnelViewController: YDBasicViewController {
    
    let YDRecruitPersonnelTableViewCellID = "YDRecruitPersonnelTableViewCell"
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
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
//        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData()}
        tableView.register(YDRecruitPersonnelTableViewCell.self, forCellReuseIdentifier: YDRecruitPersonnelTableViewCellID)
//        tableView.register(YDEditAddersListFooterView.self, forHeaderFooterViewReuseIdentifier: YDEditAddersListFooterViewID)
        return tableView
    }()
    
    var headerImage:UIImageView = {
        let header = UIImageView()
        header.image = UIImage(named:"share_back_image")
        return header
    }()
    
    var headerTitle : UILabel = {
        let label = UILabel()
        label.text = "想 要"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.medium)
        return label
    }()

    var contentLabel : UILabel = {
        let label = UILabel()
        label.text = "高福利 | 高薪资 | 晋升空间 \n简历通通砸过来"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        label.textAlignment = .center
        return label
    }()
    var resumeLabel :UILabel = {
        let label = UILabel()
        label.text = "简历通通砸过来"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    
    var titleLabel :UILabel = {
        let label = UILabel()
        label.text = "招聘岗位"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    
    var lineLabel :UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    var cityBtn : UIButton = {
        let button = UIButton()
        button.setTitle("福州市", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectCityFuZhouShi), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        return button
    }()
    
    var cityBtn1 : UIButton = {
        let button = UIButton()
        button.setTitle("上海市", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectCityShangHaiShi), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        return button
    }()
    
    var cityBtn2 : UIButton = {
        let button = UIButton()
        button.setTitle("北京市", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectCityBeiJingShi), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.headerImage)
        if isIphoneX == true{
            self.headerImage.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth, height: 220)
        }else{
            self.headerImage.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth, height: 195)
        }
        
        self.view.addSubview(self.headerTitle)
        self.headerTitle.frame = CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: 50)
        
        
        self.view.addSubview(self.contentLabel)
        self.contentLabel.frame = CGRect(x: 0, y: self.headerTitle.frame.maxY+15, width: LBFMScreenWidth, height: 25)
        
        self.view.addSubview(self.resumeLabel)
        self.resumeLabel.frame = CGRect(x: 0, y:  self.contentLabel.frame.maxY+10, width: LBFMScreenWidth, height: 25)
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 0, y: self.headerImage.frame.maxY+15, width: LBFMScreenWidth, height: 25)
        
        self.view.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY+15, width: LBFMScreenWidth, height: 55)
        
        
        self.view.addSubview(self.cityBtn)
        self.cityBtn.frame = CGRect(x: 60, y:self.titleLabel.frame.maxY+30, width: 65, height: 25)
        
        self.view.addSubview(self.cityBtn1)
        self.cityBtn1.frame = CGRect(x:self.cityBtn.frame.maxX+(LBFMScreenWidth-315)*0.5, y:self.titleLabel.frame.maxY+30, width: 65, height: 25)
        
        self.view.addSubview(self.cityBtn2)
        self.cityBtn2.frame = CGRect(x:self.cityBtn1.frame.maxX+(LBFMScreenWidth-315)*0.5, y:self.titleLabel.frame.maxY+30, width: 65, height: 25)
        
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRect(x: 0, y: self.lineLabel.frame.maxY, width: LBFMScreenWidth, height: LBFMScreenHeight-self.lineLabel.frame.maxY)
        
    }
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    // - 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
       
        
    }
    
    @objc func selectCityFuZhouShi(){
        self.cityBtn.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        self.cityBtn1.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
        self.cityBtn2.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
    }
    @objc func selectCityShangHaiShi(){
        self.cityBtn1.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        self.cityBtn.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
        self.cityBtn2.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
    }
    @objc func selectCityBeiJingShi(){
        self.cityBtn2.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        self.cityBtn.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
        self.cityBtn1.setTitleColor(YMColor(r: 0, g: 0, b: 0, a: 1), for: UIControl.State.normal)
    }
}
extension YDRecruitPersonnelViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDRecruitPersonnelTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDRecruitPersonnelTableViewCellID, for: indexPath) as! YDRecruitPersonnelTableViewCell
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recruitInfo = YDRecruitInfoViewController()
        self.navigationController?.pushViewController(recruitInfo, animated: true)
    }

}
