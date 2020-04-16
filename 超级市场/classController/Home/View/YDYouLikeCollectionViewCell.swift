//
//  YDYouLikeCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/30.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MBProgressHUD
protocol YDYouLikeCollectionViewCellDelegate:NSObjectProtocol {
    //    查看详情
    func addSelectGoodsIndexTableViewCell(selectIndex:String,goodsCode:String)
    //    添加到购物车
    func addSelectGoodsCartCollectionViewCell(selectButton:UIButton,goodListModel:YDHomeAllGoodListModel,cell:YDYouLikeCollectionViewCell, cellExcellent:YDExcellentViewCell,iconImage: UIImageView)
}
    
class YDYouLikeCollectionViewCell: UICollectionViewCell {
    weak var delegate : YDYouLikeCollectionViewCellDelegate?
    var cartCount = Int()
    private let YDExcellentViewCellID = "YDExcellentViewCell"
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    private lazy var collectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = .vertical
            let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.white
            collectionView.bounces = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(YDExcellentViewCell.self, forCellWithReuseIdentifier: YDExcellentViewCellID)
            return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        let count = (youLikeGoodsModel?.count ?? 0)/3
//        self.collectionView.frame = CGRect(x:0, y:0, width:Int(LBFMScreenWidth), height: 975)
        self.addSubview(self.collectionView)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var heightFloat:CGFloat = 0.00{
        didSet {
            self.collectionView.frame = CGRect(x:5, y:0, width: LBFMScreenWidth-10, height: heightFloat)
        }
    }
    var youLikeGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = youLikeGoodsModel else {return}
            baerImageArray.removeAll()
            for (index,pageModel) in model.enumerated(){
                print("-++++++++=%@",pageModel.activityImage)
                baerImageArray.append(pageModel.goodsImg ?? "")
            }
            self.collectionView.reloadData()
        }
    }
}

extension YDYouLikeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return  baerImageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDExcellentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDExcellentViewCellID, for: indexPath) as! YDExcellentViewCell
        cell.delegate = self
        cell.addGoods.tag = indexPath.row
        cell.youLikeGoodsModel = youLikeGoodsModel?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = youLikeGoodsModel?[indexPath.row]
        print("------------------%d",indexPath.row)
        delegate?.addSelectGoodsIndexTableViewCell(selectIndex: model?.goodsId ?? "",goodsCode:model?.goodsCode ?? "")
    }

    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:5, bottom: 0, right: 5);
    }

    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }

    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth - 30)/3,height:195)
    }

}
extension YDYouLikeCollectionViewCell:YDExcellentViewCellDelegate{
    func addSelectGoodsCartTableViewCell(selectBtn: UIButton, cell: YDExcellentViewCell, icon: UIImageView) {
        if youLikeGoodsModel?.count ?? 0 > 0{
            let listModel =  youLikeGoodsModel?[selectBtn.tag]
            delegate?.addSelectGoodsCartCollectionViewCell(selectButton: selectBtn,goodListModel:listModel!, cell: self, cellExcellent: cell, iconImage: icon)
        }
    }
}
