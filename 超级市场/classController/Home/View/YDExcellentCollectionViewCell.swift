//
//  YDExcellentCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
// 添加cell点击代理方法
protocol YDExcellentCollectionViewCellDelegate:NSObjectProtocol {
    func recommendimageLeftCollectionViewCell(selectImage:UIButton)
    func recommendimageRightCollectionViewCell(selectImage:UIButton)
}
class YDExcellentCollectionViewCell: UICollectionViewCell {
    
     weak var delegate : YDExcellentCollectionViewCellDelegate?
     private let YDExcellentViewCellID = "YDExcellentViewCell"
    var baerImageArray = [String]()
    var baerNameArray = [String]()
    
     lazy var imageBackView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageLeftViewClick(selectImage:)))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var backBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(imageLeftViewButtonClick(selectIndex:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
     lazy var imageRedView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor =  UIColor.white
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageRightViewClick(selectImage:)))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var redImageBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(imageredImageButtonClick(selectIndex:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
//    private lazy var titleLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textAlignment = NSTextAlignment.center
//        label.textColor = YDLabelColor
//        label.text = "时令水果"
//        return label
//    }()
//    private lazy var priceLabel : UILabel = {
//        let label = UILabel()
//        let attrString = NSMutableAttributedString()
//        label.font = UIFont.systemFont(ofSize: 11)
//        label.textAlignment = NSTextAlignment.center
//        label.textColor = YDLabelColor
//        label.text = "英国芒果13.0元"
////        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "苹方-简 常规体", size: 11),.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
////        attrString.addAttributes(attr, range: NSRange(location:4, length: attrString.length-5))
//        return label
//    }()
    
//    private lazy var imageIconView : UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named:"tom")
//        return imageView
//    }()
//
//    private var moreBtn:UIButton = {
//        let button = UIButton.init(type: UIButton.ButtonType.custom)
//        button.setTitle("Go", for: UIControl.State.normal)
//        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
//        return button
//    }()
//
//    private lazy var collectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout.init()
//        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor.white
//        collectionView.alwaysBounceVertical = true
//        collectionView.register(YDExcellentViewCell.self, forCellWithReuseIdentifier: YDExcellentViewCellID)
//        return collectionView
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageBackView)
        self.imageBackView.frame = CGRect(x: 10, y:5, width: (LBFMScreenWidth-30)*0.5, height: 90)
        
        self.addSubview(self.backBtn)
        self.backBtn.frame = CGRect(x: 10, y:5, width: (LBFMScreenWidth-30)*0.5, height: 90)
        
        self.addSubview(self.imageRedView)
        self.imageRedView.frame = CGRect(x: self.imageBackView.frame.maxX+10, y:5, width: (LBFMScreenWidth-30)*0.5, height: 90)
        
        self.addSubview(self.redImageBtn)
        self.redImageBtn.frame =  CGRect(x: self.imageBackView.frame.maxX+10, y:5, width: (LBFMScreenWidth-30)*0.5, height: 90)
        
//        self.addSubview(self.imageGreenView)
//        self.imageGreenView.frame = CGRect(x: self.imageRedView.frame.maxX+5, y:self.imageBackView.frame.maxY+15, width: (LBFMScreenWidth-35)*0.5, height: 85)
//
        
//        self.addSubview(self.titleLabel)
//        self.titleLabel.frame = CGRect(x:25, y:self.imageBackView.frame.maxY+25, width: 100, height: 20)
//
//        self.addSubview(self.priceLabel)
//        self.priceLabel.frame = CGRect(x:25, y:self.titleLabel.frame.maxY+2, width:80, height: 15)
//
//
//        self.addSubview(self.imageIconView)
//        self.imageIconView.frame = CGRect(x:115, y:self.imageBackView.frame.maxY+25, width:60, height: 60)
//
//        self.addSubview(self.moreBtn)
//        self.moreBtn.frame = CGRect(x:25, y:self.priceLabel.frame.maxY+10, width:35, height: 15)
//
//        self.addSubview(self.collectionView)
//        self.collectionView.frame = CGRect(x:0, y:self.imageRedView.frame.maxY+2.5, width:LBFMScreenWidth, height: 280)

    }
    var excellentGoodsModel:[YDHomeAllGoodListModel]? {
        didSet {
            guard let model = excellentGoodsModel else {return}
            baerImageArray.removeAll()
            for (index,pageModel) in model.enumerated(){
                print("-++++++++=%@",pageModel.activityImage)
                baerImageArray.append(pageModel.activityImage!)
            }
            self.imageBackView.kf.setImage(with: URL(string:baerImageArray[0] ?? ""))
            self.imageRedView.kf.setImage(with: URL(string:baerImageArray[1] ?? ""))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//  时令水果
    @objc func imageLeftViewClick(selectImage:UIImageView){
//        delegate?.recommendimageLeftCollectionViewCell(selectImage:selectImage)
    }
    @objc func imageLeftViewButtonClick(selectIndex:UIButton){
         delegate?.recommendimageLeftCollectionViewCell(selectImage:selectIndex)
    }
//    牛奶面包
    @objc func imageRightViewClick(selectImage:UIImageView){
//        delegate?.recommendimageRightCollectionViewCell(selectImage:selectImage)
    }
    @objc func imageredImageButtonClick(selectIndex:UIButton){
        delegate?.recommendimageRightCollectionViewCell(selectImage:selectIndex)
    }
    
    
}
//extension YDExcellentCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//            return 8;
//
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell:YDExcellentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YDExcellentViewCellID, for: indexPath) as! YDExcellentViewCell
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.recommendGuessLikeCellItemClick()
//    }
//
//    //每个分区的内边距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left:5, bottom: 0, right: 5);
//    }
//
//    //最小 item 间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2.5;
//    }
//
//    //最小行间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5;
//    }
//
//    //item 的尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width:(LBFMScreenWidth - 30) / 4,height:135)
//    }
//}

