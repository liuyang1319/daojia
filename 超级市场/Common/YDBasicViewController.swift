//
//  YDBasicViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MBProgressHUD

class YDBasicViewController: UIViewController,UIGestureRecognizerDelegate {
    
    lazy var bbBackBarItem : UIBarButtonItem = {
        
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "bb_navigation_back"), for: .normal)
        backBtn.imageView?.contentMode = .center
        backBtn.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        backBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        
        let bbBackBarItem = UIBarButtonItem(customView: backBtn)
        return bbBackBarItem
    }()
    
    deinit {
        print("deinit: ", type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationItem.leftBarButtonItem = bbBackBarItem
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
        }
       openSwipe()
        
    
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    func openSwipe(){
        
        if(self.navigationController != nil){
            
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
            
        }
        
    }
   
    @objc private func dismissSelf(){
      self.navigationController?.popViewController(animated: false)
     
        
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.navigationController?.viewControllers.count == 1{
            
            return false;
            
        }
        
        return true;
        
    }
    func goMeViewController()  {
        self.navigationController?.popToRootViewController(animated: true)
        guard let delegate = UIApplication.shared.delegate as? AppDelegate,let tabBarController = delegate.window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers  else {
            return
        }
        
        for item in viewControllers {
            guard let navController = item as? UINavigationController, let rootViewController = navController.viewControllers.first else { continue }
            if rootViewController is YDBasicViewController {
                tabBarController.selectedViewController = navController
                break
            }
        }
    }
    
    /// toast
    func toast(title: String) {
        toast(title: title, afterDelay: 2)
    }
    
    func toast(title: String, afterDelay: TimeInterval) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    func toast(error: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = error
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
    }
}


