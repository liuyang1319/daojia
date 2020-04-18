//
//  YDShopCartViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
protocol YDShopCartViewCellDelegate:NSObjectProtocol {
//    去结算
    func paySelectIndexGoodsListCollectionViewCell(goodsCount:YDShopCartViewCell,goodsIdArray:Array<String>,goodsCountArray:Array<String>,priceSum:CGFloat)
//    查看商品详情
    func selectLoockGoodsInfo(selectSecton:Int,selectRow:Int)
    
    // 删除单个商品
    func deleteGoodsInfo(selectSection: Int, selectRow: Int)
}
class YDShopCartViewCell: UICollectionViewCell {
    weak var delegate : YDShopCartViewCellDelegate?
    
    var selectArray: [YDShopCartGoodsListModel] = []
    
    var goodSArray:[YDShopCartGoodsListModel]?
    var addGoodArray: [YDShopCartGoodsListModel] = []
//    商品ID
    var goodsIdArray = [String]()
    var IdArray = [String]()
    var goodsCountArray = [String]()
//    购物车数量
    var cartCount = Int()
//    cell
    let YDShopCollectionViewCellID = "YDShopCollectionViewCell"
//    headerView
    let YDShopHeaderReusableViewID = "YDShopHeaderReusableView"
//    footerView
    let YDShopFooterReusableViewID = "YDShopFooterReusableView"
//    总件数
    var sumNumber : NSInteger =  0
    var allSelect : Bool = false
//    总价
    var price: Double = 0.00
    
//    是否全选
    var isAllSelect: Int = 0
    
    //    Footer的高
    var FooterH = Int()
    
//    仓名
    var supplierName = String()
//    仓头像
    var supplierImg = String()
//    仓ID
    var supplierId = String()
    
//    var footerView:YDShopFooterReusableView = {
//         return YDShopFooterReusableView()
//    }()
    var shopCartViewModel: YDShopCartViewModel = {
        return YDShopCartViewModel.share()
    }()
    var focusModel:[YDShopCartGoodsListModel]? {
        didSet{
            guard let model = focusModel else { return }
            self.selectArray = model
//            let defaults = UserDefaults.standard
//            defaults.set(self.selectArray, forKey: "ShopCartGoodsList")
            self.tableView.frame = CGRect(x: 0, y: 0, width:LBFMScreenWidth, height:(CGFloat(self.selectArray.count) * 130) + 120);

            reCalculateGoodCount()
        }
    }
    var setFooterH:Int = 0{
        didSet{
            FooterH = setFooterH
        }
    }
    
    private lazy var tableView: YDTableView = {
        let tableView = YDTableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false

        return tableView
    }()
    
//    private lazy var collectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout.init()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor.white
//        collectionView.isScrollEnabled = false
//        // - 注册头视图和尾视图
//        collectionView.register(YDShopHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShopHeaderReusableViewID)
//
//        collectionView.register(YDShopFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDShopFooterReusableViewID)
//        // - 注册不同分区cell
//        collectionView.register(YDShopCollectionViewCell.self, forCellWithReuseIdentifier: YDShopCollectionViewCellID)
//        return collectionView
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        FooterH = 70
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGoodsLisetCart(nofit:)), name: NSNotification.Name(rawValue:"refreshGoodsLisetCart"), object: nil)
        self.addSubview(self.tableView)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    全选刷新
    @objc func refreshGoodsLisetCart(nofit:Notification) {
        allSelect = false
        for (index, addmodel) in self.selectArray.enumerated(){
            var model = self.selectArray[index]
            model.selected = false
            if addmodel.goodsCode == model.goodsCode{
                self.selectArray[index] = model
            }
        }
        reCalculateGoodCount()
        
    }
    
}
extension YDShopCartViewCell {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.selectArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell:YDShopCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YDShopCollectionViewCell", for: indexPath) as! YDShopCollectionViewCell
//        cell.shopCartGoodList = self.selectArray[indexPath.row]
//        cell.delegate = self
//        cell.minusBtn.tag = indexPath.row
//        cell.plusBtn.tag = indexPath.row
//        cell.selectBtn.tag = indexPath.row
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: LBFMScreenWidth, height:120)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize.init(width: LBFMScreenWidth, height:50)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize.init(width: LBFMScreenWidth, height:CGFloat(FooterH))
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView : YDShopHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YDShopHeaderReusableViewID, for: indexPath) as! YDShopHeaderReusableView
//            headerView.shopName = supplierName
//            headerView.shopImage = supplierImg
//            return headerView
//        }else if kind == UICollectionView.elementKindSectionFooter {
//            let footerView : YDShopFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: YDShopFooterReusableViewID, for: indexPath) as! YDShopFooterReusableView
//            footerView.priceSum = Float(price)
//            footerView.sumNumber = sumNumber
//            footerView.allSelect = allSelect
//            footerView.delegate = self
//            return footerView
//        }
//        return UICollectionReusableView()
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.selectLoockGoodsInfo(selectSecton: indexPath.section, selectRow: indexPath.row)
//    }
    
    fileprivate func reCalculateGoodCount() {
        //遍历模型
        price = 0
        sumNumber = 0
        goodsCountArray.removeAll()
        goodsIdArray.removeAll()
        for model in self.selectArray{
            //计算选中的商品
            if model.selected == true {
                price += Double(model.count)*Double(model.salePrice ?? 0.0)
                sumNumber += model.count
                goodsCountArray.append(String(model.count))
                goodsIdArray.append(model.goodsId ?? "")
                IdArray.append(model.id ?? "")
            }
            print("=================%.2f",price)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsCountLisetCart"), object:sumNumber)
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsIdArrayCart"), object:IdArray)
        IdArray.removeAll()
        self.tableView.reloadData()
    }

}

extension YDShopCartViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YDShopCollectionViewCell.dequeueReusableCell(tableView: tableView)
        if selectArray.count > indexPath.row {
            cell.shopCartGoodList = self.selectArray[indexPath.row]
        }
        
        cell.delegate = self
        cell.minusBtn.tag = indexPath.row
        cell.plusBtn.tag = indexPath.row
        cell.selectBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectLoockGoodsInfo(selectSecton: indexPath.section, selectRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = YDShopHeaderReusableView.init(frame: CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 50))
        header.shopName = supplierName
        header.shopImage = supplierImg
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = YDShopFooterReusableView.init(frame: CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: CGFloat(FooterH)))
        footer.priceSum = Float(price)
        footer.sumNumber = sumNumber
        footer.allSelect = allSelect
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(FooterH)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        delegate?.deleteGoodsInfo(selectSection: indexPath.section, selectRow: indexPath.row)
    }

}

//
extension YDShopCartViewCell: YDShopCollectionViewCellDelegate,YDShopFooterReusableViewDelegate{
    
//  去结算
    func payAllGoodsListFooterReusableView() {
        if goodsCountArray.count > 0  {
            delegate?.paySelectIndexGoodsListCollectionViewCell(goodsCount: self, goodsIdArray:goodsIdArray, goodsCountArray:goodsCountArray,priceSum:CGFloat(price))
        }else{
            let hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "请选择商品"
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
        }
        
    }
//    全选
    func selectAllGoodsListFooterReusableView(sumCount: YDShopFooterReusableView, selectAll: UIButton, sumPrice: UILabel, originalPrice: UILabel, sunButton: UIButton) {
//        selectAll.isSelected = !selectAll.isSelected

                for (index, addmodel) in self.selectArray.enumerated(){
                    var model = self.selectArray[index]
                    model.selected = !selectAll.isSelected
                    allSelect = !selectAll.isSelected
                    if addmodel.goodsCode == model.goodsCode{
                        self.selectArray[index] = model
                    }
                }
            self.reCalculateGoodCount()
    }
//    数量加
    func selectGoodsListPlusCollectionViewCell(goodsCount: YDShopCollectionViewCell, countBtn: UIButton,minusBtn:UIButton, label: UILabel) {
        var model = selectArray[countBtn.tag]
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: model.goodsCode!, count:1,deviceNumber:uuid ?? "",memberId: model.memberId ?? "",status:1)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    model.count += 1
                    if model.count > 1{
                        minusBtn.setImage(UIImage(named: "selectMiusImage_h"), for: UIControl.State.normal)
                    }
                    label.text = "\(model.count)"
                    for (index, addmodel) in self.selectArray.enumerated(){
                        if addmodel.goodsCode == model.goodsCode{
                            self.selectArray[index] = model
                        }
                    }
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount += 1
                    
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                     NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                }
                self.reCalculateGoodCount()
            }
        }
    }
    
//    单选
    func selectIndexGoodsListCollectionViewCell(selectBtn: UIButton) {
//        selectBtn.isSelected = !selectBtn.isSelected
            var model = self.selectArray[selectBtn.tag]
            model.selected = !selectBtn.isSelected
            for (index, addmodel) in self.selectArray.enumerated(){
                if addmodel.goodsCode == model.goodsCode{
                    self.selectArray[index] = model
                    
                }
            }
        for (index, addmodel) in self.selectArray.enumerated(){
                allSelect = true
            if addmodel.selected != true{
                allSelect = false
                self.isAllSelect = 1
                break
            }
            self.isAllSelect = 2
        }
        if self.isAllSelect == 1 {
            NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsCountLisetAllSelect"), object:nil)
        }else if self.isAllSelect == 2{
             NotificationCenter.default.post(name: NSNotification.Name.init("refreshGoodsISAllSelect"), object:nil)
        }
        reCalculateGoodCount()
    }

//    减
    func selectGoodsListMinusCollectionViewCell(minusCount: YDShopCollectionViewCell, minusBtn: UIButton, numberLabel: UILabel) {
        var model = selectArray[minusBtn.tag]
        if model.count <= 1{
            return
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: model.goodsCode!, count:1,deviceNumber:uuid ?? "",memberId: model.memberId ?? "",status:2)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    model.count -= 1
                    if model.count <= 1{
                         minusBtn.setImage(UIImage(named:"selectMiusImage"), for: UIControl.State.normal)
                    }
                    numberLabel.text = "\(model.count)"
                    for (index, addmodel) in self.selectArray.enumerated(){
                        if addmodel.goodsCode == model.goodsCode{
                            self.selectArray[index] = model
                        }
                    }
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount -= 1
                    
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                }
                self.reCalculateGoodCount()
            }
        }
    }
}

