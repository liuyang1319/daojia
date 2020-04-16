//
//  YDGoodsThreeTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
protocol YDGoodsThreeTableViewCellDelegate:NSObjectProtocol {
    //    商品减
    func addSelectGoodsThreeTableViewCell(selectId:String,goodsCode:String)
    
}
class YDGoodsThreeTableViewCell: UITableViewCell {
    weak var delegate : YDGoodsThreeTableViewCellDelegate?
    var cartCount = Int()
    private let YDGoodsTwoCollectionViewCellID = "YDGoodsTwoCollectionViewCell"
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(YDGoodsTwoCollectionViewCell.self, forCellWithReuseIdentifier: YDGoodsTwoCollectionViewCellID)
        return collectionView
    }()

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
            self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
            setUpLayout()
    }
    func setUpLayout(){
        let count = (goodsCategoryModel?.count ?? 0)/3
        //        self.collectionView.frame = CGRect(x:0, y:0, width:Int(LBFMScreenWidth), height: 975)
        self.addSubview(self.collectionView)
    }
    var heightFloat:CGFloat = 0.00{
        didSet {
            self.collectionView.frame = CGRect(x: 15, y:0, width: LBFMScreenWidth-30, height: heightFloat)
        }
    }
    var goodsCategoryModel:[YDGoodsCategoryListModel]? {
        didSet {
            guard let model = goodsCategoryModel else {return}
            baerImageArray.removeAll()
            for (index,pageModel) in model.enumerated(){
                print("-++++++++=%@",pageModel.imageUrl)
                baerImageArray.append(pageModel.imageUrl ?? "")
            }
            self.collectionView.reloadData()
        }
    }
}

extension YDGoodsThreeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  baerImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDGoodsTwoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDGoodsTwoCollectionViewCellID, for: indexPath) as! YDGoodsTwoCollectionViewCell
//        cell.delegate = self
        cell.addGoods.tag = indexPath.row
        cell.youLikeGoodsModel = goodsCategoryModel?[indexPath.row]
        cell.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = goodsCategoryModel?[indexPath.row]
        delegate?.addSelectGoodsThreeTableViewCell(selectId: model?.id ?? "",goodsCode:model?.code ?? "")
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:2.5, bottom: 0, right: 2.5);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth - 40)/3,height:210)
    }
    
}
extension YDGoodsThreeTableViewCell:YDGoodsTwoCollectionViewCellDelegate{
    func addSelectGoodsCartTableViewCell(selectBtn: UIButton, cell: YDGoodsTwoCollectionViewCell, icon: UIImageView) {
        
        var rect : CGRect = cell.frame
        //获取当前cell的相对坐标
        rect.origin.y = rect.origin.y + 50
        //            - collectionView.contentOffset.y)
        
        var imageViewRect : CGRect = icon.frame
        imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y+44
        imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x
        
        ShoppingCarTool().startAnimation(view: icon, andRect: imageViewRect, andFinishedRect: CGPoint(x:(LBFMScreenWidth/4 * 3)-20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
            
            //            let tabBtn : UIView = (self.tabBarController?.tabBar.subviews[2])!
            //            ShoppingCarTool().shakeAnimation(shakeView: tabBtn)
        })
        //添加到已购买数组之中
        //        self.addGoodArray.append(classifyGoodsModel.classfiyListGoodsModel![button.tag])
        //        var goodsModel = classifyGoodsModel.classfiyListGoodsModel![button.tag]
        
        let goodsModel = goodsCategoryModel?[selectBtn.tag]
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let userDeviceNumber = uuid ?? ""
        let userMemberId = UserDefaults.LoginInfo.string(forKey:.id) ?? ""
        
        YDClassifyViewProvider.request(.getClassifyPlusGoodsList(supplierId:UserDefaults.warehouseManagement.string(forKey:.supplierId) ?? "", goodsCode: goodsModel?.id ?? "", count:1,deviceNumber: userDeviceNumber,memberId:userMemberId,status:1)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    self.cartCount = Int(UserDefaults.cartCountInfo.string(forKey:.countCart) ?? "0")!
                    self.cartCount += 1
                    
                    UserDefaults.cartCountInfo.set(value: String(self.cartCount), forKey: .countCart)
                    NotificationCenter.default.post(name: NSNotification.Name(YDCartSumNumber), object: self, userInfo: ["namber":self.cartCount])
                    NotificationCenter.default.post(name: NSNotification.Name("requestCartGoodsData"), object: self, userInfo: nil)
                }
            }
            }
        }
        
    }
}
