//
//  YDHomeRecommendView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/18.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
/// 添加按钮点击代理方法
protocol YDHomeRecommendViewDelegate:NSObjectProtocol {
    //    查看详情
    func addSelectYouLikeIndexTableViewCell(selectModel:YDHomeYouLikeListModel)
//    添加到购物车
    func addSelectYouLikeGoodsTableViewCell(goodListModel:YDHomeYouLikeListModel)
}
class YDHomeRecommendView: UIView {
    weak var delegate : YDHomeRecommendViewDelegate?
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
    func setUpLayout()  {
        
        self.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: (LBFMScreenWidth-300)*0.5, y: 35, width: 90, height: 1)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: self.lineLabel.frame.maxX+25, y: 25, width: 70, height: 25)
        
        self.addSubview(self.lineLabel1)
        self.lineLabel1.frame = CGRect(x: self.titleLabel.frame.maxX+25, y: 35, width: 90, height: 1)
        
        
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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}
extension YDHomeRecommendView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if(self.likeGoodsModel.count > 0){
            let likeModel = self.likeGoodsModel[indexPath.row]
            delegate?.addSelectYouLikeIndexTableViewCell(selectModel:likeModel)
        }
    }
}
extension YDHomeRecommendView:YDHomeRecommendCollectionViewCellDelegate{
    func addSelectYouLikeGoodsTableViewCell(selectBtn: UIButton, cell: YDHomeRecommendCollectionViewCell, icon: UIImageView) {
        if(self.likeGoodsModel.count > 0){
            let goodsModel = self.likeGoodsModel[selectBtn.tag]
            delegate?.addSelectYouLikeGoodsTableViewCell(goodListModel:goodsModel)
        }
    }
}
