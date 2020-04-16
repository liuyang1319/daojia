//
//  YDGoodsEvaluateTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol YDGoodsEvaluateTableViewCellDelegate:NSObjectProtocol {
    func getSelectLookGoodsImage(selectImage:UIImageView)
    func get1SelectLookGoodsImage(selectImage:UIImageView)
    func get2SelectLookGoodsImage(selectImage:UIImageView)
    func get3SelectLookGoodsImage(selectImage:UIImageView)
}
class YDGoodsEvaluateTableViewCell: UITableViewCell {
    weak var delegate : YDGoodsEvaluateTableViewCellDelegate?
    var splitedArray = [String]()
    var titleArray = [String]()
    var imageArray = [String]()
    var searchHeight: CGFloat = 0
    fileprivate var lastX: CGFloat = 60
    fileprivate var lastY: CGFloat = 35
    let YDGoodsEvaluateCollectionViewCellID = "YDGoodsEvaluateCollectionViewCell"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(YDGoodsEvaluateCollectionViewCell.self, forCellWithReuseIdentifier:YDGoodsEvaluateCollectionViewCellID)
        return collectionView
    }()
//    let starIamge = UIImageView()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    lazy var titleView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()

    lazy var iconImage : UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "evaluateImage")
        iconImage.layer.cornerRadius = 18
        iconImage.clipsToBounds = true
        return iconImage
    }()
    
    lazy var nikName : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var timerLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        return label
    }()
    

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.backgroundColor = YMColor(r: 245, g: 245, b: 245, a: 1)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.text = ""
        return label
    }()
    
    lazy var  goodsImage1 : UIImageView = {
        let goodImage = UIImageView()
        goodImage.contentMode =  .scaleAspectFill
        goodImage.clipsToBounds = true
        goodImage.layer.cornerRadius = 5
        goodImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapSelectLookGoodImage(ges:)))
        goodImage.addGestureRecognizer(tapGes)
        return goodImage
    }()
    lazy var  goodsImage2 : UIImageView = {
        let goodImage = UIImageView()
        goodImage.contentMode =  .scaleAspectFill
        goodImage.clipsToBounds = true
        goodImage.layer.cornerRadius = 5
        goodImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tap1SelectLookGoodImage(ges:)))
        goodImage.addGestureRecognizer(tapGes)
        return goodImage
    }()
    lazy var  goodsImage3 : UIImageView = {
        let goodImage = UIImageView()
        goodImage.contentMode =  .scaleAspectFill
        goodImage.clipsToBounds = true
        goodImage.layer.cornerRadius = 5
        goodImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tap2SelectLookGoodImage(ges:)))
        goodImage.addGestureRecognizer(tapGes)
        return goodImage
    }()
    lazy var  goodsImage4 : UIImageView = {
        let goodImage = UIImageView()
        goodImage.contentMode =  .scaleAspectFill
        goodImage.clipsToBounds = true
        goodImage.layer.cornerRadius = 5
        goodImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tap3SelectLookGoodImage(ges:)))
        goodImage.addGestureRecognizer(tapGes)
        return goodImage
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
    
    lazy var titleLbael1:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    lazy var titleLbael2:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    lazy var titleLbael4:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
       setUpdeatInit()
    }
  
    func setUpdeatInit(){
        self.removeFromSuperview()
        self.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 36, height: 36)

        self.addSubview(self.nikName)
        self.nikName.frame = CGRect(x: self.iconImage.frame.maxX+5, y: 17, width: 300, height: 20)
        
        self.addSubview(self.timerLabel)
        self.timerLabel.frame = CGRect(x:LBFMScreenWidth-85, y: 20, width: 70, height: 15)
        
        self.addSubview(self.starImage1)
        self.starImage1.frame = CGRect(x: self.iconImage.frame.maxX+5, y: 40, width: 10, height: 10)
        self.addSubview(self.starImage2)
        self.starImage2.frame = CGRect(x: self.starImage1.frame.maxX+5, y: 40, width: 10, height: 10)
        self.addSubview(self.starImage3)
        self.starImage3.frame = CGRect(x: self.starImage2.frame.maxX+5, y: 40, width: 10, height: 10)
        self.addSubview(self.starImage4)
        self.starImage4.frame = CGRect(x: self.starImage3.frame.maxX+5, y: 40, width: 10, height: 10)
        self.addSubview(self.starImage5)
        self.starImage5.frame = CGRect(x: self.starImage4.frame.maxX+5, y: 40, width: 10, height: 10)
    
  
        self.addSubview(self.titleLabel)
        self.addSubview(self.titleView)
        
        self.addSubview(self.collectionView)
        
        self.addSubview(self.contentLabel)
        self.contentLabel.frame = CGRect(x: 56, y:self.collectionView.frame.maxY+10, width: LBFMScreenWidth-75, height: heightForView(text: self.contentLabel.text!, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular), width: LBFMScreenWidth-75))
        
        self.addSubview(self.goodsImage1)
        self.addSubview(self.goodsImage2)
        self.addSubview(self.goodsImage3)
        self.addSubview(self.goodsImage4)
    }
    
    var goodEvaluateModel:YDGoodsEvaluateList? {
        didSet{
            guard var model = goodEvaluateModel else { return }
            self.iconImage.kf.setImage(with:URL(string: model.headImg ?? ""),placeholder: UIImage(named:"evaluateImage"))
            self.nikName.text = String(format:"%@", model.username ?? "").unicodeStr
            if model.creatAt?.isEmpty == false{
                self.timerLabel.text = String(describing: model.creatAt!.prefix(10))
            }else{
                self.timerLabel.text = ""
            }

            self.starImage1.image = UIImage(named: "")
            self.starImage2.image = UIImage(named: "")
            self.starImage3.image = UIImage(named: "")
            self.starImage4.image = UIImage(named: "")
            self.starImage5.image = UIImage(named: "")
            if model.level == "1"{
                self.starImage1.image = UIImage(named:"starImage_G")
                self.starImage2.image = UIImage(named:"starImage_N")
                self.starImage3.image = UIImage(named:"starImage_N")
                self.starImage4.image = UIImage(named:"starImage_N")
                self.starImage5.image = UIImage(named:"starImage_N")
            }else if model.level == "2"{
                self.starImage1.image = UIImage(named:"starImage_G")
                self.starImage2.image = UIImage(named:"starImage_G")
                self.starImage3.image = UIImage(named:"starImage_N")
                self.starImage4.image = UIImage(named:"starImage_N")
                self.starImage5.image = UIImage(named:"starImage_N")
            }else if model.level == "3"{
                self.starImage1.image = UIImage(named:"starImage_H")
                self.starImage2.image = UIImage(named:"starImage_H")
                self.starImage3.image = UIImage(named:"starImage_H")
                self.starImage4.image = UIImage(named:"starImage_N")
                self.starImage5.image = UIImage(named:"starImage_N")
            }else if model.level == "4"{
                self.starImage1.image = UIImage(named:"starImage_H")
                self.starImage2.image = UIImage(named:"starImage_H")
                self.starImage3.image = UIImage(named:"starImage_H")
                self.starImage4.image = UIImage(named:"starImage_H")
                self.starImage5.image = UIImage(named:"starImage_N")
            }else if model.level == "5"{
                self.starImage1.image = UIImage(named:"starImage_H")
                self.starImage2.image = UIImage(named:"starImage_H")
                self.starImage3.image = UIImage(named:"starImage_H")
                self.starImage4.image = UIImage(named:"starImage_H")
                self.starImage5.image = UIImage(named:"starImage_H")
            }
            if model.able?.isEmpty != true
            {
                self.collectionView.frame = CGRect(x: 50, y: self.iconImage.frame.maxY+15, width: LBFMScreenWidth-65, height: 30)
                self.contentLabel.text = model.content?.unicodeStr
                self.contentLabel.frame = CGRect(x: 56, y:self.collectionView.frame.maxY+5, width: LBFMScreenWidth-75, height: heightForView(text:self.contentLabel.text ?? "", font: UIFont.systemFont(ofSize:12, weight: UIFont.Weight.regular), width: LBFMScreenWidth-75))
            }else{
                self.collectionView.frame = CGRect.zero
                self.contentLabel.text = model.content?.unicodeStr
                self.contentLabel.frame = CGRect(x: 56, y:self.iconImage.frame.maxY+15, width: LBFMScreenWidth-75, height: heightForView(text: self.contentLabel.text ?? "", font: UIFont.systemFont(ofSize:12, weight: UIFont.Weight.regular), width: LBFMScreenWidth-75))
            }
            self.goodsImage1.image = UIImage(named: "")
            self.goodsImage2.image = UIImage(named: "")
            self.goodsImage3.image = UIImage(named: "")
            self.goodsImage4.image = UIImage(named: "")
        
            self.imageArray.removeAll()
            if model.imageUrl?.isEmpty != true && model.imageUrl != nil
            {
             self.imageArray = model.imageUrl!.components(separatedBy:",")
            }
            if self.imageArray.count == 1 {
                self.goodsImage1.frame = CGRect(x: 56, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage1.kf.setImage(with: URL(string:self.imageArray[0] ))
                model.cellHH = self.goodsImage1.frame.maxY
            }else if self.imageArray.count == 2{
                self.goodsImage1.frame = CGRect(x: 56, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage2.frame = CGRect(x:self.goodsImage1.frame.maxX+10, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage1.kf.setImage(with: URL(string:self.imageArray[0] ))
                self.goodsImage2.kf.setImage(with: URL(string:self.imageArray[1] ))
                model.cellHH = self.goodsImage1.frame.maxY
            }else if self.imageArray.count == 3{
                self.goodsImage1.frame = CGRect(x: 56, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage2.frame = CGRect(x:self.goodsImage1.frame.maxX+10, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage3.frame = CGRect(x:self.goodsImage2.frame.maxX+10, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage1.kf.setImage(with: URL(string:self.imageArray[0] ))
                self.goodsImage2.kf.setImage(with: URL(string:self.imageArray[1] ))
                self.goodsImage3.kf.setImage(with: URL(string:self.imageArray[2] ))
                model.cellHH = self.goodsImage1.frame.maxY
            }else if self.imageArray.count >= 4{
                self.goodsImage1.frame = CGRect(x: 56, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage2.frame = CGRect(x:self.goodsImage1.frame.maxX+10, y:self.contentLabel.frame.maxY+10, width: 95, height: 95)
                self.goodsImage3.frame = CGRect(x:56, y:self.goodsImage1.frame.maxY+10, width: 95, height: 95)
                self.goodsImage4.frame = CGRect(x:self.goodsImage3.frame.maxX+10, y:self.goodsImage1.frame.maxY+10, width: 95, height: 95)
                self.goodsImage1.kf.setImage(with: URL(string:self.imageArray[0] ))
                self.goodsImage2.kf.setImage(with: URL(string:self.imageArray[1] ))
                self.goodsImage3.kf.setImage(with: URL(string:self.imageArray[2] ))
                self.goodsImage4.kf.setImage(with: URL(string:self.imageArray[3] ))
                model.cellHH = self.goodsImage4.frame.maxY
            } 
        }
    }
    //    标签数量
    var nameArray:[String]?{
        didSet {
//            guard let model = nameArray else {return}
            self.titleArray.removeAll()
            self.titleArray = nameArray!
            self.collectionView.reloadData()
        }
    }
//    查看图片
    @objc private func tapSelectLookGoodImage(ges:UIGestureRecognizer){
        delegate?.getSelectLookGoodsImage(selectImage: self.goodsImage1)
    }
    @objc private func tap1SelectLookGoodImage(ges:UIGestureRecognizer){
        delegate?.get1SelectLookGoodsImage(selectImage: self.goodsImage2)
    }
    @objc private func tap2SelectLookGoodImage(ges:UIGestureRecognizer){
        delegate?.get2SelectLookGoodsImage(selectImage: self.goodsImage3)
    }
    @objc private func tap3SelectLookGoodImage(ges:UIGestureRecognizer){
        delegate?.get3SelectLookGoodsImage(selectImage: self.goodsImage4)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension YDGoodsEvaluateTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.titleArray.count > 0 {
            return self.titleArray.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDGoodsEvaluateCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:YDGoodsEvaluateCollectionViewCellID, for: indexPath) as! YDGoodsEvaluateCollectionViewCell
        cell.nameArray = self.titleArray[indexPath.row]
        print("-------------标签",self.titleArray)
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
