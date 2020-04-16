//
//  YDSpecialViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDSpecialViewCellDelegate:NSObjectProtocol {
    func recommendGuessLikeCellItemClick()
}
class YDSpecialViewCell: UICollectionViewCell {
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    weak var delegate : YDSpecialViewCellDelegate?
    private let YDSpecialCollectionViewCellID = "YDSpecialCollectionViewCell"
    private lazy var backLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.text = "限时特价"
        return label
    }()
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(YDSpecialCollectionViewCell.self, forCellWithReuseIdentifier: YDSpecialCollectionViewCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backLabel)
        self.backLabel.frame = CGRect(x: 15, y: 10, width: 3, height: 15)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x:self.backLabel.frame.maxX+10, y: 10, width: 120, height: 25)
        
        self.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY, width: LBFMScreenWidth, height: 180)
    }
    var specialGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = specialGoodsModel else {return}
            baerImageArray.removeAll()
            for (index,pageModel) in model.enumerated(){
                print("-++++++++=%@",pageModel.activityImage)
                baerImageArray.append(pageModel.activityImage ?? "")
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension YDSpecialViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baerImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDSpecialCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDSpecialCollectionViewCellID, for: indexPath) as! YDSpecialCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick()
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:5, bottom: 0, right: 5);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:100,height:170)
    }
}
