//
//  YDPrivacyLookUrlViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import WebKit
class YDPrivacyLookUrlViewController: YDBasicViewController {
    var webView : WKWebView!
    
    private lazy var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var backBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"bb_navigation_back"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var tltleLabel : UILabel = {
        let label = UILabel()
        label.text = "辉鲜到家隐私政策"
        label.textAlignment = .center
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMNavBarHeight)
        
        if isIphoneX == true {
            self.backView.addSubview(self.backBtn)
            self.backBtn.frame = CGRect(x: 10, y: 44, width: 40, height: 40)
            
            self.backView.addSubview(self.tltleLabel)
            self.tltleLabel.frame = CGRect(x: 60, y: 54, width: LBFMScreenWidth-120, height: 20)
            
        }else{
            self.backView.addSubview(self.backBtn)
            self.backBtn.frame = CGRect(x: 10, y: 12, width: 40, height: 40)
            
            self.backView.addSubview(self.tltleLabel)
            self.tltleLabel.frame = CGRect(x: 60, y: 22, width: LBFMScreenWidth-120, height: 20)
        }
        
        
        webView = WKWebView(frame: CGRect(x: 0, y:LBFMNavBarHeight, width:LBFMScreenWidth, height:LBFMScreenHeight-LBFMNavBarHeight))
        let url = URL(string:"http://erp.yundazaixian.com/download/private.html")
        let request = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.load(request)
        self.view.addSubview(self.webView)
        
    }
//    返回
    @objc func backButtonClick(){
        self.dismiss(animated: true, completion: nil)
    }
}
extension YDPrivacyLookUrlViewController: WKNavigationDelegate
{
    
    // 监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
//        self.progressView.progress = Float(self.wkWebView.estimatedProgress)
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){

    }
}
