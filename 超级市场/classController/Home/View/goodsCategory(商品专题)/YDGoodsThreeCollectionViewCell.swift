//
//  YDGoodsThreeCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDGoodsThreeCollectionViewCell: UICollectionViewCell {
    
    let YDSpecialCollectionViewCellID = "YDSpecialCollectionViewCell"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(YDSpecialCollectionViewCell.self, forCellWithReuseIdentifier: YDSpecialCollectionViewCellID)
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 435)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension YDGoodsThreeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDSpecialCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDSpecialCollectionViewCellID, for: indexPath) as! YDSpecialCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.recommendGuessLikeCellItemClick()
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left:10, bottom: 5, right: 10);
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
        return CGSize.init(width:(LBFMScreenWidth-55)/3,height:200)
    }
}
