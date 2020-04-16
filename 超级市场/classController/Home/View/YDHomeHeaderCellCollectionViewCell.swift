//
//  YDHomeHeaderCellCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import FSPagerView

/// 添加按钮点击代理方法
protocol YDHomeHeaderCellCollectionViewCellDelegate:NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String)
    func recommendHeaderBannerClick(url:String)
}
class YDHomeHeaderCellCollectionViewCell: UICollectionViewCell {
    
    weak var delegate : YDHomeHeaderCellCollectionViewCellDelegate?
    
    var pageImage = [String]()
    var baerImageArray = [String]()
    var baerNameArray = [String]()
     // MARK: - 轮播图
    private lazy var pagerView:FSPagerView = {
       let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self 
        pagerView.automaticSlidingInterval = 3 //时间间隔
        pagerView.isInfinite = true //无限轮播
//        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.interitemSpacing = 15
        return pagerView
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
        // 分页轮播图
        self.addSubview(self.pagerView)
        self.pagerView.frame = CGRect(x:0, y:0, width: LBFMScreenWidth, height: 220)
    }

    var seearchGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = seearchGoodsModel else {return}
            pageImage.removeAll()
            for (index,pageModel) in model.enumerated(){
                pageImage.append(pageModel.activityImage ?? "")
            }
            self.pagerView.reloadData()

        }
    }
   
}
extension YDHomeHeaderCellCollectionViewCell:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return pageImage.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:pageImage[index] ))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        delegate?.recommendHeaderBannerClick(url: "haha")
    }
}
