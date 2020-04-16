//
//  PhotoView.swift
//  paso-ios
//
//  Created by 陈亮陈亮 on 2017/6/19.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias CloseBtnClickClouse = ([UIImage])->()
typealias VisitPhotoBtnClickClouse = ()->()

class PhotoView: UIView {
    
    
    @objc var closeBtnClickClouse: CloseBtnClickClouse?
    @objc var visitPhotoBtnClickClouse: VisitPhotoBtnClickClouse?

    @objc var picStrArr = [String]()  // 在实际的项目中可能用于存储图片的url

    @objc var imgView: UIImageView!
    @objc var scrollView: UIScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.scrollView =  UIScrollView.init(frame:CGRect(x: 0, y:5, width: LBFMScreenWidth-60, height:140))
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView)
    }
    
    /// 设置图片数组
    @objc var picArr = [UIImage]() {
        didSet{

            for view in self.scrollView.subviews {
                view.removeFromSuperview()
            }
            
            let magin: CGFloat = 5
            let imageW: CGFloat = 65
            let imageH: CGFloat = imageW
            
            for i in 0..<picArr.count {
                let imageView = UIImageView()
                let imageX: CGFloat = magin + (magin + imageW)*CGFloat(i)
                let imageY: CGFloat = 0
                imageView.frame =  CGRect(x:imageX, y:imageY, width:imageW, height:imageH)
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled  = true
                if picArr.count > 1{
                    if picArr.count - 1 == i{
                        imageView.image = picArr[0]
                    }else{
                        imageView.image = picArr[i+1]
                    }
                    
                }else{
                    imageView.image = picArr[i]
                }
                
                self.imgView = imageView
                self.scrollView.addSubview(imageView)
                if picArr.count > 1{
                    if (i==picArr.count-1) {
                        imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickChooseImage)))
                    }
                }else{
                    imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickChooseImage)))
                }
                // 加一个关闭按钮self.imgView.cl_width
                let closeBtn = UIButton.init(frame: CGRect(x: self.imgView.cl_width-20, y: 0, width: 20, height: 20))
                closeBtn.tag = i+1
                if (i != picArr.count-1) {
                    closeBtn.setBackgroundImage(UIImage(named:"close"), for: .normal)
                    closeBtn.addTarget(self, action: #selector(clickCloseBtn(btn:)), for: .touchUpInside)
                    self.imgView.addSubview(closeBtn)
                }
            }
            if (picArr.count>=2) {
                self.scrollView.contentSize = CGSize(width:CGFloat(picArr.count)*imageW + CGFloat((picArr.count+1)*5), height:0);
            } else {
                self.scrollView.contentSize = CGSize(width:0, height:0);
            }
        }
    }
    
    /// 关闭按钮
    @objc func clickCloseBtn(btn:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStaPhotoView"), object:self, userInfo: ["scrollViewTag":self.scrollView.tag,"deleteButton":btn.tag])
        self.picArr.remove(at: btn.tag)
        if self.closeBtnClickClouse != nil {
            self.closeBtnClickClouse!(self.picArr)
        }
    }
    
    /// 选择相册
    @objc func clickChooseImage() {
        if self.visitPhotoBtnClickClouse != nil {
            self.visitPhotoBtnClickClouse!()
        }
    }
    
    /// 隐藏关闭按钮用于纯展示
    @objc var hiddenAllCloseBtn = false {
        didSet{
            if hiddenAllCloseBtn == true {
                for view in self.scrollView.subviews {
                    for btnView in view.subviews {
                        if btnView.classForCoder == UIButton.self {
                            btnView.isHidden = true
                        }
                    }
                }
                
            }
        }
    }

}
