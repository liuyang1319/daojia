//
//  YDTreasureChestCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/30.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol YDTreasureChestCollectionViewCellDelegate:NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String)
}
class YDTreasureChestCollectionViewCell: UICollectionViewCell {
    weak var delegate : YDTreasureChestCollectionViewCellDelegate?
    var activityNameArray = [YDHomeAllGoodListModel]()
    var pageImage = [String]()
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    var categoryIdArray = [String]()
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(YDHomeHeaderGridCell.self, forCellWithReuseIdentifier: "YDHomeHeaderGridCell")
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 设置布局
        setupLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayOut(){
        // 九宫格
        self.addSubview(self.gridView)
        self.gridView.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth, height: 160)
    }
    
    var functionGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = functionGoodsModel else {return}
            self.activityNameArray = model
//            baerImageArray.removeAll()
//            baerNameArray.removeAll()
//            for (index,pageModel) in model.enumerated(){
//                print("-++++++++=%@",pageModel.activityImage)
//                baerImageArray.append(pageModel.activityImage ?? "")
//                baerNameArray.append(pageModel.activityName ?? "")
//                categoryIdArray.append(pageModel.categoryId ?? "")
//            }
            self.gridView.reloadData()
        }
    }
}

extension YDTreasureChestCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activityNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDHomeHeaderGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YDHomeHeaderGridCell", for: indexPath) as! YDHomeHeaderGridCell
            cell.baerNameImage = self.activityNameArray[indexPath.row]
//        cell.baerImage = baerImageArray[indexPath.row]
//        cell.baerName = baerNameArray[indexPath.row]
//        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:LBFMScreenWidth/4, height:80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.activityNameArray.count > 0{
            let categoryId = self.activityNameArray[indexPath.row]
            delegate?.recommendHeaderBtnClick(categoryId:categoryId.categoryId ?? "", title: "123", url: "haha")
        }
    }
}
