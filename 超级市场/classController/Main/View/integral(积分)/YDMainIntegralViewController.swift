//
//  YDMainIntegralViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
class YDMainIntegralViewController: YDBasicViewController {
    
    private lazy var headerView:YDMainIntegralHeaderView = {
        let view = YDMainIntegralHeaderView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height:240))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let oneVc = YDUnusedIntegralViewController()
    private let twoVc = YDYetUseViewController()
//    private let threeVc = YDPastDueViewController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc]
    }()
    
    private lazy var titles: [String] = {
        return ["积分收入", "积分支出"]
    }()
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.isNeedScale = false
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 153, g: 153, b: 153)
        layout.titleSelectColor = YDLabelColor
        layout.bottomLineColor = YDLabelColor
        layout.sliderHeight = 44
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y:LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight + LBFMNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = 0
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         navBarBarTintColor = YDLabelColor
        requestSearchGoodsDate()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    lazy var integralListModel: YDMainIntegralViewModel = {
        return YDMainIntegralViewModel()
    }()
    func requestSearchGoodsDate(){
        // 加载数据
        integralListModel.updateDataBlock = { [unowned self] in
            self.headerView.integralString = self.integralListModel.integralListModel?.count ?? "0"
        }
        integralListModel.refreshCouponDataSource(status: "1", token:  (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)
    }

}
extension YDMainIntegralViewController : LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
}
