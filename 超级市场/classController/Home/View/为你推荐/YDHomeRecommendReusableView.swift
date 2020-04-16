//
//  YDHomeRecommendReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
/// 添加按钮点击代理方法
protocol YDHomeRecommendReusableViewDelegate:NSObjectProtocol {
    //    查看详情
    func addSelectYouLikeIndexTableViewCell(selectIndex:String,goodsCode:String)
    //    添加到购物车
    func addSelectYouLikeIndexReusableView(selectButton: UIButton,goodListModel:YDHomeYouLikeListModel, cell: YDHomeRecommendReusableView, cellExcellent: YDHomeRecommendCollectionViewCell, iconImage: UIImageView)
}
class YDHomeRecommendReusableView: UICollectionViewCell {
    weak var delegate : YDHomeRecommendReusableViewDelegate?
    var likeGoodsModel = [YDHomeYouLikeListModel]()
    var cartCount = Int()
    let YDHomeRecommendCollectionViewCellID = "YDHomeRecommendCollectionViewCell"
    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = "猜你喜欢"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    private lazy var lineLabel1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return label
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        // 轮播图
        collection.register(YDHomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: YDHomeRecommendCollectionViewCellID)
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout()  {
        self.addSubview(self.collectionView)
    }
    var heightFloat:CGFloat = 0.00{
        didSet {
        self.collectionView.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY+15, width: LBFMScreenWidth, height: heightFloat)
        }
    }
    var youLikeGoodsModel:[YDHomeYouLikeListModel]? {
        didSet {
            guard let model = youLikeGoodsModel else {return}
            self.likeGoodsModel = model
            self.collectionView.reloadData()
        }
    }
}
extension YDHomeRecommendReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.likeGoodsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDHomeRecommendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDHomeRecommendCollectionViewCellID, for: indexPath) as! YDHomeRecommendCollectionViewCell
        cell.youLikeGoodsModel = self.likeGoodsModel[indexPath.row]
        cell.addGoods.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left:10, bottom: 5, right:10);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth - 30)/2,height:250)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let likeModel = self.likeGoodsModel[indexPath.row]
        delegate?.addSelectYouLikeIndexTableViewCell(selectIndex: likeModel.goodsId ?? "",goodsCode:likeModel.goodsCode ?? "")
    }
}
extension YDHomeRecommendReusableView:YDHomeRecommendCollectionViewCellDelegate{
    func addSelectYouLikeGoodsTableViewCell(selectBtn: UIButton, cell: YDHomeRecommendCollectionViewCell, icon: UIImageView) {
        
        if likeGoodsModel.count > 0{
            let listModel =  likeGoodsModel[selectBtn.tag]
            delegate?.addSelectYouLikeIndexReusableView(selectButton: selectBtn,goodListModel:listModel, cell: self, cellExcellent: cell, iconImage: icon)
        }
    
    }
}
