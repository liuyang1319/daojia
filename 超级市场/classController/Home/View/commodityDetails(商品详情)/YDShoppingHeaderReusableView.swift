//
//  YDShoppingHeaderReusableView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/5.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import FSPagerView
protocol YDShoppingHeaderReusableViewDelegate:NSObjectProtocol {
    //    商品减
    func goodsEvaluateMoreHeaderReusableView()

}
class YDShoppingHeaderReusableView: UICollectionReusableView {
    weak var delegate : YDShoppingHeaderReusableViewDelegate?
    public var goodsImageModel:[YDHomeGoodsImageInfo]?
    public var goodsListInfo:YDHomeGoodsListInfo?
    public var goodsEstimateModel:[YDHomeGoodsEstimateInfo]?
    var sumComment = Int()
    //    cell
    let YDShoppingCollectionViewCellID = "YDShoppingCollectionViewCell"
    // MARK: - 轮播图
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
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(YDShoppingCollectionViewCell.self, forCellWithReuseIdentifier: YDShoppingCollectionViewCellID)
        return collectionView
    }()
    // 轮播图片
    private var headerImage:UIImageView = {
        let subLabel = UIImageView.init()
        subLabel.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth, height: 377)
        return subLabel
    }()
    // 分割线
    private var linLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return subLabel
    }()
    //价格
    private var priceLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        subLabel.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        subLabel.textAlignment = .left
        return subLabel
    }()
    //销量
    private var volumeLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        subLabel.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        subLabel.textAlignment = .right
        return subLabel
    }()
    //原价
    private var originalLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        subLabel.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        subLabel.textAlignment = .left
        return subLabel
    }()
//    商品名
    private var nameLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        subLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        subLabel.numberOfLines = 2
        return subLabel
    }()
    //    背景
    private var backLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return subLabel
    }()
    //    绿色背景
    private var greenLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.backgroundColor = YMColor(r: 204, g: 238, b: 195, a: 1)
        return subLabel
    }()
    //    预计送达时间
    private var timerLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return subLabel
    }()
    
    //    灰色背景
    private var grayLabel:UILabel = {
        let subLabel = UILabel.init()
       subLabel.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return subLabel
    }()
    
    //    绿色竖条
    private var greenLinLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.backgroundColor = YMColor(r: 77, g: 195, b: 45, a: 1)
        return subLabel
    }()
    //    评价
    private var estimateLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        subLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        subLabel.textAlignment = .left
        return subLabel
    }()
    //    好评价
    private var goodsEstimateLabel:UILabel = {
        let Label = UILabel.init()
        Label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        Label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        Label.textAlignment = .right
        return Label
    }()
    //    好评价
    private var arrowsBtn:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "popImage"), for: UIControl.State.normal)

        return button
    }()

    private var evaluationBtn:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goodsEvaluateMoreButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private var backColorLabel:UILabel = {
        let Label = UILabel.init()
        Label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return Label
    }()
    //
    private var lin1Label:UILabel = {
        let Label = UILabel.init()
        Label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return Label
    }()
    
    private var InfoLabel:UILabel = {
        let Label = UILabel.init()
        Label.text = "图文详情"
        Label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        Label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        Label.textAlignment = .center
        return Label
    }()
    
    private var lin2Label:UILabel = {
        let Label = UILabel.init()
        Label.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        return Label
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
        label.text = "规格参数"
        return label
    }()
    
    var sumCommentCount:Int = 0{
        didSet{
            self.sumComment = sumCommentCount
        }
    }
    
    var focusModel:YDHomeGoodsListInfo? {
        didSet{
            guard let model = focusModel else { return }
            self.goodsListInfo = model
            self.linLabel.frame = CGRect(x: 0, y: self.pagerView.frame.maxY+2, width: LBFMScreenWidth, height: 1)
            self.priceLabel.text = String(format:"￥%.2f", self.goodsListInfo?.salePrice ?? "")
            self.priceLabel.frame = CGRect(x: 8, y: self.linLabel.frame.maxY+20, width: 200, height: 30);
            
            self.volumeLabel.text = String(format:"月销%@件", self.goodsListInfo?.saleNums ?? "")
            self.volumeLabel.frame = CGRect(x: LBFMScreenWidth-155, y: self.linLabel.frame.maxY+24, width: 140, height: 15)

            self.originalLabel.text = String(format:"价格:￥%.2f", self.goodsListInfo?.formalPrice ?? "")
            let attribtStr = NSAttributedString.init(string: self.originalLabel.text!, attributes: [ NSAttributedString.Key.foregroundColor: YMColor(r: 153, g: 153, b: 153, a: 1), NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
            self.originalLabel.attributedText = attribtStr
            self.originalLabel.frame = CGRect(x: 10, y: self.priceLabel.frame.maxY+10, width: 200, height: 15)
            
            self.nameLabel.text = String(format:"%@ %@%@", self.goodsListInfo?.name ?? "",self.goodsListInfo?.weight ?? "",self.goodsListInfo?.unitName ?? "")
//                String(format:"%@", self.goodsListInfo?.name ?? "")
            self.nameLabel.frame = CGRect(x: 10, y: self.originalLabel.frame.maxY+10, width:LBFMScreenWidth-20, height: heightForView(text: self.nameLabel.text!, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold), width: LBFMScreenWidth-20))
            
            self.backLabel.frame = CGRect(x: 0, y: self.nameLabel.frame.maxY+10, width: LBFMScreenWidth, height: 10)
            self.greenLabel.frame = CGRect(x: 15, y: self.backLabel.frame.maxY+5, width: LBFMScreenWidth-30, height: 25)
            
            
            self.timerLabel.text = "现在下单，预计30分钟送达"
            self.timerLabel.frame = CGRect(x: 30, y: self.backLabel.frame.maxY+10, width: 300, height: 15)
            
            self.grayLabel.frame = CGRect(x: 0, y: self.greenLabel.frame.maxY+5, width: LBFMScreenWidth, height: 10)
            self.greenLinLabel.frame = CGRect(x: 15, y: self.grayLabel.frame.maxY+20, width: 2, height: 10)
            
            
            self.estimateLabel.frame = CGRect(x: self.greenLinLabel.frame.maxX+5, y: self.grayLabel.frame.maxY+15, width: 250, height: 20)
            
            self.goodsEstimateLabel.frame = CGRect(x: LBFMScreenWidth-140, y: self.grayLabel.frame.maxY+15, width: 110, height: 20)
            self.arrowsBtn.frame = CGRect(x: LBFMScreenWidth-30, y: self.grayLabel.frame.maxY+10, width: 20, height: 30)
            self.evaluationBtn.frame = CGRect(x: 0, y: self.grayLabel.frame.maxY+10, width: LBFMScreenWidth, height: 30)
            
            if self.sumComment > 0{
                self.collectionView.frame = CGRect(x: 0, y: self.estimateLabel.frame.maxY+10, width: LBFMScreenWidth, height: 130)
                
                self.lin1Label.frame = CGRect(x: (LBFMScreenWidth-295)*0.5, y: self.collectionView.frame.maxY+25, width: 90, height: 1)
                
                self.InfoLabel.frame = CGRect(x: self.lin1Label.frame.maxX+20 , y: self.collectionView.frame.maxY+15, width: 75, height: 25)
                
                self.lin2Label.frame = CGRect(x:self.InfoLabel.frame.maxX+20, y: self.collectionView.frame.maxY+25, width: 90, height: 1)
                
                self.greenLin2Label.frame = CGRect(x: 15, y: self.InfoLabel.frame.maxY+20, width: 3, height: 10)
                
                self.parameterLabel.frame = CGRect(x: self.greenLin2Label.frame.maxX+5, y: self.InfoLabel.frame.maxY+15, width: 200, height: 20)
            }else{
//                self.collectionView.frame = CGRect(x: 0, y: self.estimateLabel.frame.maxY+10, width: LBFMScreenWidth, height: 130)
                
                self.backColorLabel.frame = CGRect(x: 0, y: self.estimateLabel.frame.maxY+10, width: LBFMScreenWidth, height: 8)
                
                self.lin1Label.frame = CGRect(x: (LBFMScreenWidth-295)*0.5, y:self.estimateLabel.frame.maxY+35, width: 90, height: 1)
                
                self.InfoLabel.frame = CGRect(x: self.lin1Label.frame.maxX+20 , y: self.estimateLabel.frame.maxY+25, width: 75, height: 25)
                
                self.lin2Label.frame = CGRect(x:self.InfoLabel.frame.maxX+20, y: self.estimateLabel.frame.maxY+35, width: 90, height: 1)
                
                self.greenLin2Label.frame = CGRect(x: 15, y: self.InfoLabel.frame.maxY+20, width: 3, height: 10)
                
                self.parameterLabel.frame = CGRect(x: self.greenLin2Label.frame.maxX+5, y: self.InfoLabel.frame.maxY+15, width: 200, height: 20)
            }
            
            
            
        }
    }
    
    var selectEstimateCount:Int = 0{
        didSet{
            self.estimateLabel.text = String(format:"商品评价(%d)",selectEstimateCount)
        }
    }
    
    var applauseRate:Double = 0 {
        didSet{
            self.goodsEstimateLabel.text = String(format: "好评率%.2f%@",applauseRate,"%")
            let attributeText = NSMutableAttributedString.init(string: self.goodsEstimateLabel.text!)
            let count = self.goodsEstimateLabel.text!.count
            attributeText.addAttributes([NSAttributedString.Key.foregroundColor: YMColor(r: 255, g: 140, b: 43, a: 1)], range: NSMakeRange(3, count-3))
            self.goodsEstimateLabel.attributedText = attributeText
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 720)
        setupHeaderView()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshRequestCartImageView(nofit:)), name: NSNotification.Name(rawValue:"requestCartImageView"), object: nil)
    }
//    轮播图图片动画
    @objc func refreshRequestCartImageView(nofit:Notification){
        var rect : CGRect = pagerView.frame
//           var rectExcellent : CGRect = cellExcellent.frame
//           rect.origin.x = rectExcellent.origin.x
           //获取当前cell的相对坐标
//           rect.origin.y = (rect.origin.y - collectionView.contentOffset.y)
           var imageViewRect : CGRect = pagerView.frame
           imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y
           imageViewRect.origin.x = rect.origin.x + imageViewRect.origin.x
           print("===================%@",rect.origin.y)
           print("++++++++++++++++%@",collectionView.contentOffset.y)
           print("---------------%@",imageViewRect.origin.y)
        self.headerImage.kf.setImage(with: URL(string:(self.goodsImageModel?[0].imageUrl) ?? ""))
                                     
        ShoppingCarTool().startAnimationBottom(view: self.headerImage, andRect: imageViewRect, andFinishedRect: CGPoint(x:20,  y:LBFMScreenHeight-LBFMTabBarHeight), andFinishBlock: { (finished : Bool) in
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func goodsEvaluateMoreButtonClick(){
        delegate?.goodsEvaluateMoreHeaderReusableView()
    }
    // 布局
    func setupHeaderView() {
        self.addSubview(self.pagerView)
        self.pagerView.frame = CGRect(x: 0, y:0, width: LBFMScreenWidth, height: 377)
        
        self.addSubview(self.linLabel)
        
        
        self.addSubview(self.priceLabel)
  
        self.addSubview(self.volumeLabel)
        
        self.addSubview(self.originalLabel)
       
        
        self.addSubview(self.nameLabel)
       
        
        self.addSubview(self.backLabel)
        
        
        self.addSubview(self.greenLabel)
        
        
        self.addSubview(self.timerLabel)
       
        
        self.addSubview(self.grayLabel)
        
        
        self.addSubview(self.greenLinLabel)
        
        
        self.addSubview(self.estimateLabel)
       
        
        self.addSubview(self.goodsEstimateLabel)
        
        self.addSubview(self.arrowsBtn)
        self.addSubview(self.evaluationBtn)
        
        self.addSubview(self.backColorLabel)
        self.addSubview(self.collectionView)
        
        self.addSubview(self.lin1Label)
        
       
        
        self.addSubview(self.InfoLabel)
        
        
        self.addSubview(self.lin2Label)
        
        self.addSubview(self.greenLin2Label)
        
        self.addSubview(self.parameterLabel)
        
    }
    
}

extension YDShoppingHeaderReusableView:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        print("+++++++++++++++%d",self.goodsImageModel?.count as Any)
        return self.goodsImageModel?.count ?? 0
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.goodsImageModel?[index].imageUrl)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        let url:String = self.focus?.data?[index].link ?? ""
//        delegate?.recommendHeaderBannerClick(url: url)
    }
}
extension YDShoppingHeaderReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goodsEstimateModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDShoppingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDShoppingCollectionViewCellID, for: indexPath) as! YDShoppingCollectionViewCell
        cell.goodsEstimate = self.goodsEstimateModel?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.recommendGuessLikeCellItemClick()
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:2.5, bottom: 0, right:2.5);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:280,height:130)
    }
}
