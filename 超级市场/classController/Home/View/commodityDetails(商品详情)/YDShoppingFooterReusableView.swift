//
//  YDShoppingFooterReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import WebKit
class YDShoppingFooterReusableView: UICollectionReusableView {
    var webView : WKWebView!
    var linlabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    
    
    //    绿色竖条
    private var greenLin2Label:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = YMColor(r: 77, g: 195, b: 45, a: 1)
        return label
    }()
    
    //    规格
    private var parameterLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        label.textAlignment = .left
        label.text = "商品详情"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        self.addSubview(self.linlabel)
        self.linlabel.frame = CGRect(x: 0, y: 2, width: LBFMScreenWidth, height: 10)
        
        self.greenLin2Label.frame = CGRect(x: 15, y:self.linlabel.frame.maxY + 17, width: 2, height: 10)
        self.addSubview(self.greenLin2Label)
        
        self.addSubview(self.parameterLabel)
        self.parameterLabel.frame = CGRect(x: self.greenLin2Label.frame.maxX+5, y:self.linlabel.frame.maxY + 12 , width: 80, height: 20)
        
       
    }
    
    var contentName : String = ""{
        didSet {
            webView = WKWebView(frame: CGRect(x: 0, y:60, width:LBFMScreenWidth, height:1320))
            if contentName != ""{
                let url = URL(string:contentName)
                let request = URLRequest(url: url!)
                webView.navigationDelegate = self
                webView.load(request)
                self.addSubview(self.webView)
            }
        }
    }
    
}
extension YDShoppingFooterReusableView: WKNavigationDelegate
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
