//
//  YDOrderViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
class YDOrderViewController: YDBasicViewController {
    private let oneVc = YDOrderAllViewController()
    private let twoVc = YDOrderPayViewController()
    private let threeVc = YDOrderHarvestViewController()
    private let fourVc = YDOrderCommentViewController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc, threeVc,fourVc]
    }()
    var index = Int()
    private lazy var titles: [String] = {
        return ["全部", "待支付", "待收货","待评价"]
    }()
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.isNeedScale = false
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        layout.titleFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        layout.titleSelectColor = YDLabelColor
        layout.bottomLineColor = YDLabelColor
        layout.sliderHeight = 44
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    private lazy var pageView: LTPageView = {
        let pageView = LTPageView(frame: CGRect(x: 0, y:LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight-LBFMNavBarHeight), currentViewController: self, viewControllers: viewControllers, titles: titles, layout: layout)
        pageView.isClickScrollAnimation = true
        return pageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageView)
        pageView.scrollToIndex(index:index)
    }
    @objc func rightBarButtonClick(){
        
    }
}
