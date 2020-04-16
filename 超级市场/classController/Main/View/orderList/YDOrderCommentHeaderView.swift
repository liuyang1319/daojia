//
//  YDOrderCommentHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/16.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDOrderCommentHeaderViewDelegate:NSObjectProtocol {
    //    查看商品详情
    func selectLoockGoodsInfoHeaderView(selectStar:Int,starCount:Int)
}
class YDOrderCommentHeaderView: UITableViewHeaderFooterView{
    weak var delegate : YDOrderCommentHeaderViewDelegate?
    var searchHeight: CGFloat = 0
    fileprivate var lastX: CGFloat = 10
    fileprivate var lastY: CGFloat = 20
    var nameArray = [String]()
    let YDCommentHeaderCollectionViewCellID = "YDCommentHeaderCollectionViewCell"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(YDCommentHeaderCollectionViewCell.self, forCellWithReuseIdentifier:YDCommentHeaderCollectionViewCellID)
        return collectionView
    }()
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    lazy var greenView:UIView = {
        let backView = UIView()
        backView.backgroundColor = YMColor(r: 222, g: 249, b: 215, a: 1)
        return backView
    }()
    
    lazy var integral:UILabel = {
        let backView = UILabel()
        backView.text = "文字+照片评价任意商品最高获得30积分"
        backView.font = UIFont.systemFont(ofSize: 11)
        backView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return backView
    }()
    lazy var backWhite:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    lazy var integralLabel:UILabel = {
        let backView = UILabel()
        backView.text = "配送服务评价"
        backView.font = UIFont.systemFont(ofSize: 14)
        backView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return backView
    }()
    lazy var iconImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.backgroundColor = UIColor.white
        return iamgeView
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    lazy var anonymityLabel:UILabel = {
        let label = UILabel()
        label.text = "已对骑手匿名"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = YMColor(r: 204, g: 204, b: 204, a: 1)
        return label
    }()
    lazy var timerLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
    }()
    lazy var starImage1:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 100
        imageView.image = UIImage(named: "starImage_H")
        return imageView
    }()
    lazy var starImage2:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 101
        imageView.image = UIImage(named: "starImage_H")
        return imageView
    }()
    
    lazy var starImage3:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 102
        imageView.image = UIImage(named: "starImage_H")
        return imageView
    }()
    lazy var starImage4:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 103
        imageView.image = UIImage(named: "starImage_H")
        return imageView
    }()
    
    lazy var starImage5:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 104
        imageView.image = UIImage(named: "starImage_H")
        return imageView
    }()
    lazy var starBtn1:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectstarButtonClick(starBtn1:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var starBtn2:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectstarButtonClick1(starBtn2:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var starBtn3:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectstarButtonClick2(starBtn3:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var starBtn4:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectstarButtonClick3(starBtn4:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var starBtn5:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectstarButtonClick4(starBtn5:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    lazy var backBtn:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 60)
        
        self.addSubview(self.greenView)
        self.greenView.frame = CGRect(x: 15, y: 10, width: LBFMScreenWidth-30, height: 40)
        
        self.greenView.addSubview(self.integral)
        self.integral.frame = CGRect(x: 15, y: 14, width: 240, height: 15)
        
        self.addSubview(self.backWhite)
        self.backWhite.frame = CGRect(x: 15, y: self.backView.frame.maxY + 10, width: LBFMScreenWidth-30, height: 245)
        
        
        self.backWhite.addSubview(self.integralLabel)
        self.integralLabel.frame = CGRect(x:(LBFMScreenWidth-90)*0.5, y: 15, width: 90, height: 20)
        
        self.backWhite.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 10, y: self.integralLabel.frame.maxY+10, width: 50, height: 50)
        
        self.backWhite.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: self.integralLabel.frame.maxY+20, width: 150, height: 15)
        
        self.backWhite.addSubview(self.anonymityLabel)
        self.anonymityLabel.frame = CGRect(x: LBFMScreenWidth-100, y: self.integralLabel.frame.maxY+30, width: 70, height: 15)
        
        self.backWhite.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y:  self.nameLabel.frame.maxY+5, width: 200, height: 20)
        
        self.backWhite.addSubview(self.starImage1)
        self.starImage1.frame = CGRect(x:(LBFMScreenWidth-165)*0.5, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage2)
        self.starImage2.frame = CGRect(x: self.starImage1.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage3)
        self.starImage3.frame = CGRect(x: self.starImage2.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage4)
        self.starImage4.frame = CGRect(x: self.starImage3.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage5)
        self.starImage5.frame = CGRect(x: self.starImage4.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        
        self.backWhite.addSubview(self.starBtn1)
        self.starBtn1.frame = CGRect(x:(LBFMScreenWidth-165)*0.5 , y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn2)
        self.starBtn2.frame = CGRect(x: self.starBtn1.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn3)
        self.starBtn3.frame = CGRect(x: self.starBtn2.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn4)
        self.starBtn4.frame = CGRect(x: self.starBtn3.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn5)
        self.starBtn5.frame = CGRect(x: self.starBtn4.frame.maxX+15, y:self.timerLabel.frame.maxY+20 , width: 15, height: 15)
        
        
        self.backWhite.addSubview(self.collectionView)
//        self.collectionView.backgroundColor = UIColor.red
        self.collectionView.frame = CGRect(x: 10, y: self.starBtn5.frame.maxY+20, width: LBFMScreenWidth-50, height: 80)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var driverInfoModel:YDDriverInfoCommentModel? {
        didSet {
            guard let model = driverInfoModel else {return}
            self.nameLabel.text = model.deliveryName ?? ""
            self.iconImage.kf.setImage(with:URL(string:model.headImg ?? ""), placeholder:UIImage(named: "headerImage"))
            let sub1 = model.sendTime?.prefix(19)
            self.timerLabel.text = String(format:"%@",sub1 as CVarArg? ?? "")
        }
    }
    
    var titleArray:[String]?{
        didSet {
            guard var model = titleArray else {return}
            
            self.nameArray = model
            self.collectionView.reloadData()
//            var btnW: CGFloat = 0
//            let btnH: CGFloat = 30
//            let addW: CGFloat = 30
//            let marginX: CGFloat = 10
//            let marginY: CGFloat = 10
//            for i in 0..<model.count {
//                let btn = UIButton()
//                btn.setTitle(model[i] as? String, for: UIControl.State())
//                btn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State())
//                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//                btn.titleLabel?.sizeToFit()
//                btn.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
//                btn.layer.masksToBounds = true
//                btn.layer.cornerRadius = 15
//                //            btn.layer.borderWidth = 0.5
//                //            btn.layer.borderColor = YMColor(r: 200, g: 200, b: 200, a: 1).cgColor
//                btn.addTarget(self, action: #selector(starReteButtonClick), for: UIControl.Event.touchUpInside)
//                btnW = btn.titleLabel!.width + addW
//
//                if self.backWhite.frame.width - lastX > btnW {
//                    btn.frame = CGRect(x: lastX, y:lastY, width: btnW, height: btnH)
//                } else {
//                    btn.frame = CGRect(x: 10, y: lastY + marginY + btnH, width: btnW, height: btnH)
//                }
//
//                lastX = btn.frame.maxX + marginX
//                lastY = btn.y
//                searchHeight = btn.frame.maxY
//
//                self.backBtn.addSubview(btn)
//            }
//
//            self.backBtn.frame = CGRect(x: 0, y: self.iconImage.frame.maxY+50, width: LBFMScreenWidth-30, height: searchHeight)
//
            
            
        }
    }
//    选择星星
    @objc func selectstarButtonClick(starBtn1:UIButton){
        self.starImage1.image = UIImage(named: "starImage_G")
        self.starImage2.image = UIImage(named: "starImage_N")
        self.starImage3.image = UIImage(named: "starImage_N")
        self.starImage4.image = UIImage(named: "starImage_N")
        self.starImage5.image = UIImage(named: "starImage_N")
        delegate?.selectLoockGoodsInfoHeaderView(selectStar: 1 ,starCount:1)
    }
    @objc func selectstarButtonClick1(starBtn2:UIButton){
        self.starImage1.image = UIImage(named: "starImage_G")
        self.starImage2.image = UIImage(named: "starImage_G")
        self.starImage3.image = UIImage(named: "starImage_N")
        self.starImage4.image = UIImage(named: "starImage_N")
        self.starImage5.image = UIImage(named: "starImage_N")
        delegate?.selectLoockGoodsInfoHeaderView(selectStar: 1,starCount:2)
    }
    @objc func selectstarButtonClick2(starBtn3:UIButton){
        self.starImage1.image = UIImage(named: "starImage_H")
        self.starImage2.image = UIImage(named: "starImage_H")
        self.starImage3.image = UIImage(named: "starImage_H")
        self.starImage4.image = UIImage(named: "starImage_N")
        self.starImage5.image = UIImage(named: "starImage_N")
        delegate?.selectLoockGoodsInfoHeaderView(selectStar: 2,starCount:3)
    }
    @objc func selectstarButtonClick3(starBtn4:UIButton){
        self.starImage1.image = UIImage(named: "starImage_H")
        self.starImage2.image = UIImage(named: "starImage_H")
        self.starImage3.image = UIImage(named: "starImage_H")
        self.starImage4.image = UIImage(named: "starImage_H")
        self.starImage5.image = UIImage(named: "starImage_N")
        delegate?.selectLoockGoodsInfoHeaderView(selectStar: 3,starCount:4)
    }
    @objc func selectstarButtonClick4(starBtn5:UIButton){
        self.starImage1.image = UIImage(named: "starImage_H")
        self.starImage2.image = UIImage(named: "starImage_H")
        self.starImage3.image = UIImage(named: "starImage_H")
        self.starImage4.image = UIImage(named: "starImage_H")
        self.starImage5.image = UIImage(named: "starImage_H")
        delegate?.selectLoockGoodsInfoHeaderView(selectStar: 3,starCount:5)
    }
    @objc func starReteButtonClick(){
    }
    func starRate(view starRateView: JNStarRateView, count: Float) {
        print(count)
    }
}
extension YDOrderCommentHeaderView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDCommentHeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:YDCommentHeaderCollectionViewCellID, for: indexPath) as! YDCommentHeaderCollectionViewCell
        cell.titleBtn.tag = indexPath.row
        cell.delegate = self
        cell.nameArray = self.nameArray[indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (LBFMScreenWidth - 80)*0.25, height:30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
//选中便签
extension YDOrderCommentHeaderView:YDCommentHeaderCollectionViewCellDelegate{
    func GoodsCommentListCollectionView(titleButton: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshOrderCommentGoodsAbleHeaderView"), object:self, userInfo: ["horsemanLabel":self.nameArray[titleButton.tag],"isSelect":titleButton.isSelected])

    }
}
