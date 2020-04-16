//
//  YDApplicationRefundListViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/26.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MBProgressHUD
class YDApplicationRefundListViewController: YDBasicViewController {
    let YDYDApplicationRefundListTableViewCellID = "YDYDApplicationRefundListTableViewCell"
    var orderNumber = String()
//    商品列表
    var orderGoodsList = [YDorderDetailGoodsModel]()
//    需要退款的列表
    var selectGoodsList = [YDorderDetailGoodsModel]()
//    退款商品件数
    var countNum = Int()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.isHidden = true
        return backView
    }()
    lazy var selectAllBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noSelectCartImage"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "selectGoodsImage"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(selectAllGoodsListButtonClick(selectGoods:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var allLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.text = "全选"
        return label
    }()

    lazy var selectDelete : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "delete_iamge"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("退款", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(selectDeleteAllGoodsListButtonClick(selectDelete:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        button.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        button.setTitle("编辑", for: UIControl.State.normal)
        button.setTitle("完成", for: UIControl.State.selected)
        button.addTarget(self, action: #selector(rightBarButtonClick(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(YDYDApplicationRefundListTableViewCell.self, forCellReuseIdentifier: YDYDApplicationRefundListTableViewCellID)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "批量退款"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        self.view.addSubview(self.tableView)
        self.backView.addSubview(self.selectAllBtn)
        self.selectAllBtn.frame = CGRect(x: 10, y:10, width: 30, height: 30)
        
        self.backView.addSubview(self.allLabel)
        self.allLabel.frame = CGRect(x: self.selectAllBtn.frame.maxX+10, y:10, width: 25, height: 30)
        
        //        self.backView.addSubview(self.selectCollect)
        //        self.selectCollect.frame = CGRect(x: LBFMScreenWidth-195, y: 5, width: 90, height: 25)
        
        self.backView.addSubview(self.selectDelete)
        self.selectDelete.frame = CGRect(x:LBFMScreenWidth - 110, y: 10, width: 95, height: 30)
    
    }
//    编辑
    @objc func rightBarButtonClick(selectBtn:UIButton){
        selectBtn.isSelected = !selectBtn.isSelected
        if selectBtn.isSelected != true {
            self.backView.isHidden = true

//            self.deleteIdArray.removeAll()
        }else{
            self.view.addSubview(self.backView)
            self.backView.frame = CGRect(x: 0, y: LBFMScreenHeight-LBFMTabBarHeight, width: LBFMScreenWidth, height: 50)
            self.selectAllBtn.isSelected = false
            self.backView.isHidden = false
          
        }
        if orderGoodsList.count > 0 {
            for (index, model) in orderGoodsList.enumerated(){
                var listModel = self.orderGoodsList[index]
                listModel.isShow = !selectBtn.isSelected
                listModel.isSelectGoods = !selectBtn.isSelected
                self.orderGoodsList[index] = listModel
            }
            self.tableView.reloadData()
        }
        
    }
//    退款全选
    @objc func selectAllGoodsListButtonClick(selectGoods:UIButton){
        selectGoods.isSelected = !selectGoods.isSelected
        if orderGoodsList.count > 0 {
            for (index, model) in orderGoodsList.enumerated(){
                var listModel = self.orderGoodsList[index]
                listModel.isSelectGoods = selectGoods.isSelected
                self.orderGoodsList[index] = listModel
            }
            if selectGoods.isSelected == true {
                self.selectGoodsList = self.orderGoodsList
            }else{
                self.selectGoodsList.removeAll()
            }
            if self.selectGoodsList.count > 0{
                self.countNum = 0
                for (index,goodsModel) in self.selectGoodsList.enumerated(){
                    self.countNum += goodsModel.count ?? 0
                }
                self.selectDelete.setTitle("退款(\(self.countNum))", for: UIControl.State.normal)
            }else{
                self.selectDelete.setTitle("退款", for: UIControl.State.normal)
            }
            self.tableView.reloadData()
        }
    }
//    退款
    @objc func selectDeleteAllGoodsListButtonClick(selectDelete:UIButton){
        if self.selectGoodsList.count > 0{
            let alertController = UIAlertController(title: "辉鲜到家",
                                                    message:"每个用户只能提交一次退款申请，请您仔细核对需要退款的商品信息。", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:{action in

            })
            
            let okAction = UIAlertAction(title: "确定", style: .default,
                                         handler: {action in
                                            
                let refundVC = YDApplicationRefundViewController()
                refundVC.refundGoodsList = self.selectGoodsList
                refundVC.orderGoodsNumber = self.orderNumber
                self.navigationController?.pushViewController(refundVC, animated: true)
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            if #available(iOS 13.0, *) {
                alertController.modalPresentationStyle = .fullScreen
            } else {
            }
            self.present(alertController, animated: true, completion: nil)
        }else{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择退款商品"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
            return
        }
    }
}
extension YDApplicationRefundListViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderGoodsList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:YDYDApplicationRefundListTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDYDApplicationRefundListTableViewCellID, for: indexPath) as! YDYDApplicationRefundListTableViewCell
            cell.selectBtn.tag = indexPath.row
            cell.delegate = self
            cell.goodRefundModel = self.orderGoodsList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        
    }
    
   
}
extension YDApplicationRefundListViewController : YDYDApplicationRefundListTableViewCellDelegate{
//    选择退款商品
    func isSelectGoodsRefundListTableViewCell(isSelect: UIButton){
        isSelect.isSelected =  !isSelect.isSelected
        if orderGoodsList.count > 0 {
            for (index, model) in orderGoodsList.enumerated(){
                var listModel = self.orderGoodsList[isSelect.tag]
                if model.goodsCode == listModel.goodsCode {
                    listModel.isSelectGoods = isSelect.isSelected
                    self.orderGoodsList[index] = listModel
                    if isSelect.isSelected == true {
                        self.selectGoodsList.append(listModel)
                    }else{
                        for (index,goodsModel) in self.selectGoodsList.enumerated(){
                            if listModel.goodsCode == goodsModel.goodsCode{
                                self.selectGoodsList.remove(at: index)
                            }
                        }
                    }
                    
                }
            }
            if self.selectGoodsList.count > 0{
                self.countNum = 0
                for (index,goodsModel) in self.selectGoodsList.enumerated(){
                    self.countNum += goodsModel.count ?? 0
                }
                self.selectDelete.setTitle("退款\(self.countNum)", for: UIControl.State.normal)
            }else{
                self.selectDelete.setTitle("退款", for: UIControl.State.normal)
            }
            if orderGoodsList.count == self.selectGoodsList.count{
                self.selectAllBtn.isSelected = true
            }else{
                 self.selectAllBtn.isSelected = false
            }
            self.tableView.reloadData()
        }
    }
}
