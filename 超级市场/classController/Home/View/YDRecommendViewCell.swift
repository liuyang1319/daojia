//
//  YDRecommendViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/4.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit


protocol YDRecommendViewCellDelegate:NSObjectProtocol {
    func recommendGuessLikeCellItemClick(selectIndex:Int)
}
class YDRecommendViewCell: UICollectionViewCell {
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    weak var delegate : YDRecommendViewCellDelegate?
    private let YDRecommendCollectionViewCellID = "YDRecommendCollectionViewCell"

    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(YDRecommendCollectionViewCell.self, forCellWithReuseIdentifier: YDRecommendCollectionViewCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x:10, y: 5, width: LBFMScreenWidth-20, height: 285)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var recommendGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = recommendGoodsModel else {return}
            baerImageArray.removeAll()
            for (index,pageModel) in model.enumerated(){
                print("-++++++++=%@",pageModel.activityImage)
                baerImageArray.append(pageModel.activityImage ?? "")
            }
        }
    }
}
extension YDRecommendViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.baerImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDRecommendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDRecommendCollectionViewCellID, for: indexPath) as! YDRecommendCollectionViewCell
        cell.baerImage = baerImageArray[indexPath.row]
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick(selectIndex:indexPath.row)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth-50)*0.25,height:135)
    }
}
