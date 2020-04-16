//
//  YDGoodCouponViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/17.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
class YDGoodCouponViewController: YDBasicViewController {
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:60, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        button.setTitle("优惠劵说明", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 102, g: 120, b: 102, a: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let oneVc = YDUnusedCouponViewController()
    private let twoVc = YDEmployCouponViewController()
    private let threeVc = YDPastCouponViewController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc, threeVc]
    }()
    
    private lazy var titles: [String] = {
        return ["未使用", "已使用", "已过期"]
    }()
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.isNeedScale = false
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 102, g: 102, b: 102)
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
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem]
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageView)
    
    }
    @objc func rightBarButtonClick(){
        
    }
}

