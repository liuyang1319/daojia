//
//  YDGoodsCategoryMainController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/5.
//  Copyright © 2019 王林峰. All rights reserved.
//
private let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)

import UIKit
import SwiftyJSON
import HandyJSON
import LTScrollView
import FSPagerView
class YDGoodsCategoryMainController: YDBasicViewController {

    var titles = [String]()
    var titleId = [String]()
    var indexId:Int = 0
    var categoryNameArray = [YDCategoryNameModel]()
    var nameArray = [String]()
    var pageImage = [String]()
    private lazy var pagerView:FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3 //时间间隔
        pagerView.isInfinite = true //无限轮播
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.interitemSpacing = 15
        return pagerView
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named:"shareImage"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightShareBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        for _ in titles {
            vcs.append(YDGoodsCategoryViewController())
        }
        return vcs
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = false
        layout.isNeedScale = false
        layout.titleViewBgColor = UIColor.white
        layout.titleFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        layout.titleColor = UIColor(r: 153, g: 153, b: 153)
        layout.titleSelectColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        layout.bottomLineColor = YDLabelColor
        layout.sliderHeight = 44
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private func managerReact() -> CGRect {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let Y: CGFloat = statusBarH + 44
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - Y - 34) : view.bounds.height - Y
        return CGRect(x: 0, y: Y, width: view.bounds.width, height: H)
    }
    
    
    private lazy var simpleManager: LTSimpleManager = {
        let simpleManager = LTSimpleManager(frame: managerReact(), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout)
        /* 设置代理 监听滚动 */
        simpleManager.delegate = self
        return simpleManager
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.titles.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name("YDGoodsCategoryMainController"), object: self, userInfo: ["nameStr":self.titles[indexId],"nameId":self.titleId[indexId]])
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
 
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.pageImage = ["https://huihui-app.oss-cn-beijing.aliyuncs.com/homePage/banner/banner.png"]
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false

        simpleManagerConfig()
        self.view.addSubview(self.simpleManager)
    }
    func requestCategoryName(){
        YDHomeProvider.request(.getReadCategoryGoodsNameList(categoryId:"22")){ result  in
        if case let .success(response) = result {
            let data = try? response.mapJSON()
            if data != nil{
            let json = JSON(data!)
            print("-------%@",json)
            if json["success"] == true{
                if json["data"].isEmpty != true{
                        if let mappedObject = JSONDeserializer<YDCategoryNameModel>.deserializeModelArrayFrom(json: json["data"].description) {
                                self.categoryNameArray = mappedObject as! [YDCategoryNameModel]
                                for model in self.categoryNameArray.enumerated(){
                                    self.nameArray.append(model.element.name ?? "")
                                }
                            
                            }
                        }
                    }
                }
                }
            }
    }
    
//   分享
    @objc func rightShareBarButtonClick(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("LTSimpleManagerDemo < --> deinit")
    }
}


extension YDGoodsCategoryMainController {
    
    //MARK: 具体使用请参考以下
    private func simpleManagerConfig() {
        
        //MARK: headerView设置
        simpleManager.configHeaderView {[weak self] in
            guard let strongSelf = self else { return nil }
            let headerView = strongSelf.testLabel()
            return headerView
        }
        
        //MARK: pageView点击事件
        simpleManager.didSelectIndexHandle { (index) in
            self.indexId = index
            NotificationCenter.default.post(name: NSNotification.Name("YDGoodsCategoryMainController"), object: self, userInfo: ["nameStr":self.titles[index],"nameId":self.titleId[index]])
        }
        
    }
    
    @objc private func tapLabel(_ gesture: UITapGestureRecognizer)  {
        print("tapLabel☄")
    }
}

extension YDGoodsCategoryMainController: LTSimpleScrollViewDelegate {
    
    //MARK: 滚动代理方法
    func glt_scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("offset -> ", scrollView.contentOffset.y)
    }
    
    //MARK: 控制器刷新事件代理方法
//    func glt_refreshScrollView(_ scrollView: UIScrollView, _ index: Int) {
//        //注意这里循环引用问题。
//        scrollView.mj_header = MJRefreshNormalHeader {[weak scrollView] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                print("对应控制器的刷新自己玩吧，这里就不做处理了🙂-----\(index)")
//                scrollView?.mj_header.endRefreshing()
//            })
//        }
//    }
}

extension YDGoodsCategoryMainController {
    private func testLabel() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 220))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(self.pagerView)
        self.pagerView.frame = CGRect(x:0, y:0, width: LBFMScreenWidth, height: 220)
        return headerView
    }
}

extension YDGoodsCategoryMainController:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return pageImage.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:pageImage[index]))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        delegate?.recommendHeaderBannerClick(url: "haha")
    }
}
