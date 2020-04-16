//
//  YDTabBarController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tabBar.isTranslucent = false
        setupLayout()
    }
    func setupLayout() {

        // 1.首页
        let onePageVC = YDHomeViewController()
        addChildController(onePageVC,
                           title: "首页",
                           image: UIImage(named: "HomeIcon"),
                           selectedImage: UIImage(named: "HomeIcon_H"))
        
        
        // 2.分类
        let classVC = YDClassifyViewController()
        addChildController(classVC,
                           title: "分类",
                           image: UIImage(named: "ClassifyIcon"),
                           selectedImage: UIImage(named: "ClassifyIcon_H"))
        
        
        // 3.购物车
        let bookVC = YDShopCartViewController()
        addChildController(bookVC,
                           title: "购物车",
                           image: UIImage(named: "CartIcon"),
                           selectedImage: UIImage(named: "CartIcon_H"))
        
        
        // 4.我的
        let mineVC = YDMainViewController()
        addChildController(mineVC,
                           title: "我的",
                           image: UIImage(named: "MainIcon"),
                           selectedImage: UIImage(named: "MainIcon_H"))
    }
    
    func addChildController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
//        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        }
        addChild(YDMainNavigationController(rootViewController: childController))
    }
    
}
extension YDTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
