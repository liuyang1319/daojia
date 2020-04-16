//
//  YDGoodsCommentViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/15.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import Photos
import SwiftyJSON
import HandyJSON
import MBProgressHUD
class YDGoodsCommentViewController: YDBasicViewController,UIScrollViewDelegate,JNStarReteViewDelegate {


    private let YDOrderCommentHeaderViewID  = "YDOrderCommentHeaderView"
    private let YDOrderCommentFooterViewID  = "YDOrderCommentFooterView"
    
//    订单号
    var orderNum = String()
//    评价等级
    var develStr = String()
    var commentArray = [AnyObject]()
//    骑手星级
    var levelStar = String()
    var starCont = String()
    
    var selectCount = Int()
    
    let YDGoodsCommentTableViewCellID = "YDGoodsCommentTableViewCell"
    let commentTableViewCell = YDGoodsCommentTableViewCell()
    
    var goodsCommentModel:YDCommentListGoodsModel?
    var driverInfoModel:YDDriverInfoCommentModel?
    var driverAbleModel:[YDDriverAbleCommentModel]?
    var goodsListModel:[YDGoodsListCommentModel]?
    var goodsAbleModel:[YDGoodsAbleCommentModel]?
//  添加评论
    lazy var AddGoodsComment: YDSelectUpudatComment = {
        return YDSelectUpudatComment()
    }()
    var commentModel = [YDSelectUpudatComment]()
//    商品标签
    var nameStr = [String]()
//    骑手标签
    var titleName = [String]()
//    临时标签
    var starName = [Array<String>]()
//    var commentArray = [String]()
    var  selectImage = [String]()
    var imageCount = [String]()
//    选星数量
    var selectStar = [String]()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight - LBFMNavBarHeight-50), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(YDGoodsCommentTableViewCell.self, forCellReuseIdentifier: YDGoodsCommentTableViewCellID)
        // 注册头尾视图
        tableView.register(YDOrderCommentHeaderView.self, forHeaderFooterViewReuseIdentifier: YDOrderCommentHeaderViewID)
        tableView.register(YDOrderCommentFooterView.self, forHeaderFooterViewReuseIdentifier: YDOrderCommentFooterViewID)

        return tableView
    }()
    
    lazy var submitBtn : UIButton = {
        let button = UIButton()
        button.setTitle("提交评价", for: UIControl.State.normal)
        button.backgroundColor = YDLabelColor
        button.addTarget(self, action: #selector(submitGoodsCommentListButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单评价"
        self.develStr = "3"
        self.levelStar = "3"
        self.selectCount = 1
//        商品评价通知
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommentListGoodsAble(nofit:)), name: NSNotification.Name(rawValue:"refreshCommentListGoodsAble"), object: nil)
//       商品评价图片通知
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommentImageListGoodsAble(nofit:)), name: NSNotification.Name(rawValue:"refreshCommentImageListGoodsAble"), object: nil)
//      商品评价选择星星
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommentBtnStarListGoodsAble(nofit:)), name: NSNotification.Name(rawValue:"refreshCommentBtnStarListGoodsAble"), object: nil)
 
//       骑手选择标签通知
         NotificationCenter.default.addObserver(self, selector: #selector(refreshOrderCommentGoodsAbleHeaderView(nofit:)), name: NSNotification.Name(rawValue:"refreshOrderCommentGoodsAbleHeaderView"), object: nil)
//      商品选择标签通知
        NotificationCenter.default.addObserver(self, selector: #selector(refreshOrderCommentGoodsAbleTableViewCell(nofit:)), name: NSNotification.Name(rawValue:"refreshOrderCommentGoodsAbleTableViewCell"), object: nil)
//        删除图片通知
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommentBtnStaPhotoDeleteImage(nofit:)), name: NSNotification.Name(rawValue:"refreshCommentBtnStaPhotoView"), object: nil)


        refreshCollectGoodsListDataSource()
        self.view.addSubview(self.tableView)
        
        self.view.addSubview(self.submitBtn)
        self.submitBtn.frame = CGRect(x: 0, y: LBFMScreenHeight-50, width: LBFMScreenWidth, height: 50)
    }
    
    func refreshCollectGoodsListDataSource() {
        YDShopGoodsListProvider.request(.getOrderGoodsCommentLabelList(orderNum:orderNum, level: self.develStr, token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
//                self.goodsListModel?.removeAll()
                if let mappedObject = JSONDeserializer<YDCommentListGoodsModel>.deserializeFrom(json: json["data"].description) {
                     print("---------------%@",mappedObject)
                    self.goodsCommentModel = mappedObject
//                    配送员标签
                    self.driverAbleModel = mappedObject.driverAble
//                    商品内容
                    self.goodsListModel = mappedObject.goodsLists
//                    商品标签
                    self.goodsAbleModel = mappedObject.goodsAble
//                    配送员信息
                    self.driverInfoModel = mappedObject.driverInfo
                    for model in self.goodsAbleModel!  {
                        self.nameStr.append(model.estimateName ?? "")
                    }
                    for modelName in self.driverAbleModel!{
                        self.titleName.append(modelName.estimateName ?? "")
                    }
                    for goodsModel in self.goodsListModel!{
                        self.selectStar.append("5")
                        self.starName.append(self.nameStr)
                        let goodsDevel = self.nameStr.joined(separator: ",")
                        self.AddGoodsComment.estimateId = goodsDevel
                        self.AddGoodsComment.goodsDevel = "3"
                        self.AddGoodsComment.goodsCode = String(goodsModel.goodsCode ?? "")
                        self.commentModel.append(self.AddGoodsComment)
                    }
                    self.tableView.reloadData()
                }
                }
            }
        }
    }
//    评论选择评星
    @objc func refreshCommentBtnStarListGoodsAble(nofit:NSNotification) {
        print("------------%@",nofit.userInfo?["goodsAble"] as Any)
        let indexLabel = nofit.userInfo?["indexLabel"] as! Int
        let starIndex = nofit.userInfo?["starIndex"]
        self.selectStar.remove(at: indexLabel)
        self.selectStar.insert(starIndex as! String, at: indexLabel)
        for (index,var comment) in commentModel.enumerated() {
            if index == indexLabel {
                comment.estimateId = ""
                comment.goodsDevel = nofit.userInfo?["goodsStar"] as? String
                commentModel[index] = comment
            }
        }
        print("评星+++++++++++++++++++++%@",self.selectStar)
    }
//   修改评论的通知
    @objc func refreshCommentListGoodsAble(nofit:NSNotification) {
        print("------------%@",nofit.userInfo?["goodsAble"] as Any)
        let indexLabel = nofit.userInfo?["indexLabel"] as! Int
        for (index,var comment) in commentModel.enumerated() {
            if index == indexLabel {
                comment.goodsContent = (nofit.userInfo?["goodsAble"] as? String)?.unicodeStr
                commentModel[index] = comment
            }
        }
         print("+++++++++++++++++++++%@",commentModel)
    }
//    修改评论图片的通知
    @objc func refreshCommentImageListGoodsAble(nofit:NSNotification){
        let indexLabel = nofit.userInfo?["indexLabel"] as! Int
        imageCount.removeAll()
        selectImage.removeAll()
//        for (index,var comment) in commentModel.enumerated() {
        var commentImage = commentModel[indexLabel]
        imageCount = commentImage.goodsImage?.components(separatedBy:",") ?? []
        if imageCount.count < 4{
            let stringimage = nofit.userInfo?["goodsImage"] as? String ?? ""
            selectImage = stringimage.components(separatedBy:",")
            imageCount += selectImage
            let imageStr = imageCount.joined(separator: ",")
            commentImage.goodsImage = imageStr
            commentModel[indexLabel] = commentImage
        }


//        }
        print("---------------%@",commentModel)
    }
//    删除图片的通知
    @objc func refreshCommentBtnStaPhotoDeleteImage(nofit:NSNotification){
        let indexLabel = nofit.userInfo?["scrollViewTag"] as! Int
        let deletIndex = nofit.userInfo?["deleteButton"] as! Int
        var commentImage = commentModel[indexLabel]
        var imageArray = commentImage.goodsImage?.components(separatedBy:",")
        imageArray?.remove(at: deletIndex-1)
        commentImage.goodsImage = imageArray?.joined(separator: ",")
        commentModel[indexLabel] = commentImage
        print("+++++++++++++++++++++%@",commentModel)
    }
//    骑手选择标签
    @objc func refreshOrderCommentGoodsAbleHeaderView(nofit:NSNotification){
        let indexLabel = nofit.userInfo?["horsemanLabel"] as! String
        let isselect = nofit.userInfo?["isSelect"] as! Bool
        print("+isselect===============000",isselect)
        if isselect == true{
            self.titleName.append(indexLabel)
        }else if isselect == false{
            for (index,goods) in self.titleName.enumerated(){
                if  goods == indexLabel{
                    self.titleName.remove(at:index)
                    break
                }
            }
        }
        print("+===============000",self.titleName)
    }
    
//    商品选择标签
    @objc func refreshOrderCommentGoodsAbleTableViewCell(nofit:NSNotification){
        let indexLabel = nofit.userInfo?["horsemanLabel"] as! String
        let isselect = nofit.userInfo?["isSelect"] as! Bool
        let selectTag = nofit.userInfo?["selectTag"] as! Int
        if isselect == true{
            var goodsMdoel = commentModel[selectTag]
            if goodsMdoel.estimateId?.isEmpty != true{
                var goodsArray =  goodsMdoel.estimateId?.components(separatedBy:",")
                var count = Int()
                for (index,title) in (goodsArray?.enumerated())!{
                    if  goodsArray?[index] == indexLabel {
                        count = 1
                    }
                }
                if count != 1{
                    goodsArray?.append(indexLabel)
                    goodsMdoel.estimateId = goodsArray?.joined(separator: ",")
                    commentModel[selectTag] = goodsMdoel
                }
            }else{
                var goodsArray = [String]()
                goodsArray.append(indexLabel)
                goodsMdoel.estimateId = goodsArray.joined(separator: ",")
                commentModel[selectTag] = goodsMdoel
            }

        }else if isselect == false{
            var goodsMdoel = commentModel[selectTag]
            var goodsArray =  goodsMdoel.estimateId?.components(separatedBy:",")
            if goodsArray?.count ?? 0 > 0{
                for (index,goods) in (goodsArray?.enumerated())!{
                    if  goods == indexLabel{
                        goodsArray?.remove(at:index)
                        goodsMdoel.estimateId = goodsArray?.joined(separator: ",")
                        commentModel[selectTag] = goodsMdoel
                        break
                    }
                }
            }
        }
        print("+===============000",commentModel)
    }

//      提交评论
    
    @objc func submitGoodsCommentListButtonClick(){
        let usersArray:[[String: Any]]  = commentModel.toJSON() as! [[String : Any]]
         print("+++++++++++%@++++++++++%@---------%@",commentModel,self.levelStar,self.titleName)
        YDGoodsCommentProvider.request(.getOrderGoodsCommentDetailsInfo(orderNum:orderNum, level:self.levelStar, able:self.titleName.joined(separator: ","), estimateList:usersArray as AnyObject,token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = json["error"]["errorMessage"].description
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                }

            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension YDGoodsCommentViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.goodsListModel?.count ?? 0 < 2{
            return self.goodsListModel?.count ?? 0
        }else{
            return selectCount
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 365
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:YDGoodsCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDGoodsCommentTableViewCellID, for: indexPath) as! YDGoodsCommentTableViewCell
        cell.goodsListModel = self.goodsListModel?[indexPath.row]
        cell.addSelectArray = self.commentModel
        cell.selectArray = self.commentModel[indexPath.row]
        cell.selectStar = indexPath.row
        cell.orderNum = self.orderNum
        cell.selectStarIndex = self.selectStar[indexPath.row]
        cell.nameArray = self.starName[indexPath.row]
        cell.collectionView.tag = indexPath.row
        cell.YDTextView.tag = indexPath.row
        cell.photoScrollViewTag = indexPath.row
        cell.delegate = self
        cell.starBtn1.tag = indexPath.row
        cell.starBtn2.tag = indexPath.row
        cell.starBtn3.tag = indexPath.row
        cell.starBtn4.tag = indexPath.row
        cell.starBtn5.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:YDOrderCommentHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDOrderCommentHeaderViewID) as! YDOrderCommentHeaderView
        headerView.driverInfoModel = self.driverInfoModel
        headerView.titleArray = self.titleName
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:YDOrderCommentFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: YDOrderCommentFooterViewID) as! YDOrderCommentFooterView
        footerView.delegate = self
        footerView.goodsCount = self.goodsListModel?.count ?? 0
        return footerView
    }
 
}
//评价商品折叠
extension YDGoodsCommentViewController :YDOrderCommentFooterViewDelegate{
    func selectGoodsListFoldFooterView(goodsliset: UIButton) {
        if goodsliset.isSelected == true{
            goodsliset.isSelected = false
            goodsliset.setImage(UIImage(named:"message_down"), for: UIControl.State.normal)
            self.selectCount = 1
            self.tableView.reloadData()
            
        }else{
            goodsliset.isSelected = true
            goodsliset.setImage(UIImage(named:"message_top"), for: UIControl.State.normal)
            self.selectCount =  self.goodsListModel?.count ?? 0
            self.tableView.reloadData()
        }
    }  
}
//获取骑手选星评价标签
extension YDGoodsCommentViewController :YDOrderCommentHeaderViewDelegate{
    func selectLoockGoodsInfoHeaderView(selectStar: Int,starCount:Int) {
        self.levelStar = String(format: "%d", starCount)
        self.starCont = String(format: "%d", selectStar)
        print("-------+++--------%@",self.levelStar)
        YDShopGoodsListProvider.request(.getOrderGoodsCommentLabelList(orderNum:orderNum, level: String(selectStar), token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                        self.driverAbleModel?.removeAll()
                    if let mappedObject = JSONDeserializer<YDCommentListGoodsModel>.deserializeFrom(json: json["data"].description) {
                        self.driverAbleModel = mappedObject.driverAble
                         self.titleName.removeAll()
                        if self.driverAbleModel?.count ?? 0 > 0 {
                            for modelGoode in (self.driverAbleModel?.enumerated())!{
                                self.titleName.append(modelGoode.element.estimateName ?? "")
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
// 获取商品选星评价标签
extension YDGoodsCommentViewController :YDGoodsCommentTableViewCellDelegate{
    func selectLoockGoodsInfo(selectStar: Int, selectRow: Int) {
        
        YDShopGoodsListProvider.request(.getOrderGoodsCommentLabelList(orderNum:orderNum, level: String(selectStar), token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                    //                self.goodsListModel?.removeAll()
                    if let mappedObject = JSONDeserializer<YDCommentListGoodsModel>.deserializeFrom(json: json["data"].description) {
                        self.goodsAbleModel = mappedObject.goodsAble
                        self.goodsListModel = mappedObject.goodsLists
                        
                        self.nameStr.removeAll()
                        self.starName.remove(at: selectRow)
                        for model in self.goodsAbleModel!  {
                            self.nameStr.append(model.estimateName ?? "")
                        }
                        self.starName.insert(self.nameStr, at: selectRow)
                        
                        var goodsModel = self.commentModel[selectRow]
                        goodsModel.estimateId = self.nameStr.joined(separator: ",")
                        self.commentModel[selectRow] = goodsModel
                        UIView.performWithoutAnimation {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
