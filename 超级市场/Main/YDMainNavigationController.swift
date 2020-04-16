//
//  YDNavigationController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
class YDMainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarAppearence()
    }
    func setupNavBarAppearence() {
        // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.white
    
        // 设置导航栏所有按钮的
        WRNavigationBar.defaultNavBarTintColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        // 统一设置导航栏样式
//                WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
        
    }
    
}


extension YDMainNavigationController{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
