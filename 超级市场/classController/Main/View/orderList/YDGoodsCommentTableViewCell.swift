//
//  YDGoodsCommentTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/16.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import AliyunOSSiOS
//import CLImagePickerTool
protocol YDGoodsCommentTableViewCellDelegate:NSObjectProtocol {
    //    查看商品详情
    func selectLoockGoodsInfo(selectStar:Int, selectRow:Int)
}
class YDGoodsCommentTableViewCell: UITableViewCell {
    weak var delegate : YDGoodsCommentTableViewCellDelegate?
    
    let YDGoodsCommentCollectionViewCellID = "YDGoodsCommentCollectionViewCell"
    
    // 如果是单独访问相机，一定要声明为全局变量
    let imagePickTool = CLImagePickerTool()
//    fileprivate let contentScrollView = UIScrollView(frame: ScreenBounds)
    var titleArray = [String]()
    fileprivate var lastX: CGFloat = 10
    fileprivate var lastY: CGFloat = 20
    
    var selectStar = Int()
    //    输入意见
    var YDTextView = JHTextView()
    //    选择图片
    var photoScrollView = PhotoView()
    var uriArr = [String]()
//    订单号
    var orderNumber = String()
//    记录图片
    var indexImage = Int()
//    选中记录标签
    var selectTitleArray = [String]()
//    删除记录标签
    var deleteTitleArray = [String]()
//    商品code
    var goodsCode = String()
    
    var stratCount = String()
//    已选图片个数
    var selectCount = Int()
//    let orderView = YDOrderCommentView()
    var titleName = String()
    var addSelectArray = [YDSelectUpudatComment]()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(YDGoodsCommentCollectionViewCell.self, forCellWithReuseIdentifier:YDGoodsCommentCollectionViewCellID)
        return collectionView
    }()

    
    lazy var backWhite:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "商品评价"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return label
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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommentBtnStarSelectLoockGoodsInfo(nofit:)), name: NSNotification.Name(rawValue:"refreshCommentBtnStarSelectLoockGoodsInfo"), object: nil)
        stratCount = "3"
        setUpLayout()
        
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        YDTextView.resignFirstResponder()
//        
//    }
    @objc func refreshCommentBtnStarSelectLoockGoodsInfo(nofit:NSNotification){
        self.collectionView.reloadData()
//        self.collectionView.reloadItems(at: <#T##[IndexPath]#>)
    }
    func setUpLayout(){
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backWhite)
        self.backWhite.frame = CGRect(x: 15, y:5, width: LBFMScreenWidth-30, height: 360)
        
        self.backWhite.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: (LBFMScreenWidth-60)*0.5, y: 15, width: 60, height: 20)
        
        self.backWhite.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 10, y: self.titleLabel.frame.maxY+15, width: 60, height: 55)
        
        self.backWhite.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+15, y: self.titleLabel.frame.maxY+20, width: LBFMScreenWidth-130, height: 15)
        
        self.backWhite.addSubview(self.starImage1)
        self.starImage1.frame = CGRect(x: self.iconImage.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage2)
        self.starImage2.frame = CGRect(x: self.starImage1.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage3)
        self.starImage3.frame = CGRect(x: self.starImage2.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage4)
        self.starImage4.frame = CGRect(x: self.starImage3.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        self.backWhite.addSubview(self.starImage5)
        self.starImage5.frame = CGRect(x: self.starImage4.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        
        
        self.backWhite.addSubview(self.starBtn1)
        self.starBtn1.frame = CGRect(x: self.iconImage.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn2)
        self.starBtn2.frame = CGRect(x: self.starBtn1.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn3)
        self.starBtn3.frame = CGRect(x: self.starBtn2.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn4)
        self.starBtn4.frame = CGRect(x: self.starBtn3.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        self.backWhite.addSubview(self.starBtn5)
        self.starBtn5.frame = CGRect(x: self.starBtn4.frame.maxX+15, y:self.nameLabel.frame.maxY+10 , width: 15, height: 15)
        
        
        self.backWhite.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x: 10, y: self.iconImage.frame.maxY+15, width: LBFMScreenWidth-50, height: 80)
        
 
        self.backWhite.addSubview(self.YDTextView)
        self.YDTextView.frame = CGRect(x: 0, y: self.collectionView.frame.maxY+5, width: LBFMScreenWidth-30, height: 60)
        self.YDTextView.placeHolder = "请输入评论内容"
        self.YDTextView.placeHolderColor = YMColor(r: 226, g: 226, b: 226, a: 1)
        self.YDTextView.font = UIFont.systemFont(ofSize: 13)
        self.YDTextView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        self.YDTextView.MaxCount = 100
        self.YDTextView.delegate = self
        self.backWhite.addSubview(self.photoScrollView)
        self.photoScrollView.frame = CGRect(x:0, y: self.YDTextView.frame.maxY+5, width: LBFMScreenWidth-30, height: 295)

        self.photoScrollView.picArr.append(UIImage(named: "takePicture")!)
        
        // 点击了删除，更新界面
        self.photoScrollView.closeBtnClickClouse = {[weak self] (imageArr) in
            self?.photoScrollView.picArr = imageArr
            
        }
        // 访问相册,完成后将asset对象通过异步的方式转换为image对象，图片较清晰
        self.photoScrollView.visitPhotoBtnClickClouse = {[weak self] () in
            setupPhoto1()
        }
        
        // 异步原图
        func setupPhoto1() {
            imagePickTool.isHiddenVideo = true
            imagePickTool.isHiddenImage = false
            imagePickTool.cameraOut = true
            if self.photoScrollView.picArr.count > 0{
                self.selectCount = 5 - self.photoScrollView.picArr.count
            }else{
                self.selectCount = 4
            }
            imagePickTool.cl_setupImagePickerWith(MaxImagesCount:self.selectCount) { (asset,cutImage) in
                print("返回的asset数组是\(asset)")
                
                //获取缩略图，耗时较短
                let imageArr = CLImagePickerTool.convertAssetArrToThumbnailImage(assetArr: asset, targetSize: CGSize(width: 1000, height:2000))
                print(imageArr)
                
//                self.photoScrollView.picArr.removeAll()
                if self.photoScrollView.picArr.count > 0&&self.photoScrollView.picArr.count <= 4{
                    self.indexImage = 0
                    
                    for item in imageArr {
                        self.photoScrollView.picArr.append(item)
                    }
                }else{
                    if self.photoScrollView.picArr.count == 0{
                        self.photoScrollView.picArr.append(UIImage(named: "takePicture")!)
                        self.indexImage = 0
                        for item in imageArr {
                            self.photoScrollView.picArr.append(item)
                        }
                    }
                }
//                let uploadImage = OSSUploadManager()
                
               
                DispatchQueue.global().async {
//                    self.photoScrollView.picArr.remove(at:self.photoScrollView.picArr.count-1)
                    for (index,image) in imageArr.enumerated() {
//                        if index == self.photoScrollView.picArr.count-1{
//                            print("upload object 返回" )
//                            return
//                        }
                        print("upload object failed, error: %d" , self.photoScrollView.picArr.count)
                        self.indexImage += 1
                        let request = OSSPutObjectRequest()
                        request.uploadingData = image.pngData()!
                        request.bucketName = "huihui-app"
                        request.objectKey = self.OSSImageName()
                        request.uploadProgress = { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
                            print("bytesSent:\(bytesSent),totalBytesSent:\(totalBytesSent),totalBytesExpectedToSend:\(totalBytesExpectedToSend)");
                        };
                        let provider =  OSSStsTokenCredentialProvider.init(accessKeyId: AccessKey, secretKeyId: SecretKey, securityToken: "")
                        let client = OSSClient(endpoint: "http://oss-cn-beijing.aliyuncs.com", credentialProvider: provider)
                        let task = client.putObject(request)
                        task.continue({ (task) -> Any? in
                            if (!(task.error != nil)) {
                                let key = "http://huihui-app.oss-cn-beijing.aliyuncs.com/" + request.objectKey
                                print("upload object success%@",key);
//                                if self.indexImage > 1{
                                    self.uriArr.append(key)
//                                }
                                if self.uriArr.count == imageArr.count {
                                    var goodsModel = self.addSelectArray[self.collectionView.tag]
                                    let goodsImage = self.uriArr.joined(separator: ",")
                                    NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentImageListGoodsAble"), object:self, userInfo: ["goodsImage":goodsImage,"indexLabel":self.collectionView.tag])
                                    DispatchQueue.main.async {
                                        self.uriArr.removeAll()
                                    }
                                }
                            } else {
                                print("upload object failed, error: %@" , task.error);
                                self.uriArr.removeAll()
                                return nil
                            }
                            return nil
                        }).waitUntilFinished()
                    }
                }

            }
            PopViewUtil.share.stopLoading()
        }
       
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。

    }
    func OSSImageName()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMddhhmmssSSS"
        let date = formatter.string(from: Date())
        
        let formatterT = DateFormatter()
        formatterT.dateFormat = "yyyyMMdd"
        let dateT = formatterT.string(from: Date())
        //取出个随机数
        let last = arc4random() % 10000;
        let timeNow = String(format: "%@-%i", date,last)
        //print(timeNow);
        //以下可以自己拼接图片路径

            return String(format: "ios/estimate/%@/%@.png",self.orderNumber,timeNow);

    }
    var selectArray:YDSelectUpudatComment?{
        didSet {
            guard let model = selectArray else {return}
            self.selectTitleArray.removeAll()
            self.selectTitleArray = model.estimateId?.components(separatedBy:",") ?? []
            print("选中----------%d",self.selectTitleArray)
        }
    }
//    标签数量
    var nameArray:[String]?{
         didSet {
            guard let model = nameArray else {return}
            self.titleArray.removeAll()
            self.titleArray = model
            print("标签----------%d",self.selectTitleArray)
//            var goodsModel = self.addSelectArray[self.collectionView.tag]
//            let goodsDevel = self.titleArray.joined(separator: ",")
//            goodsModel.estimateId = goodsDevel
//            self.addSelectArray.insert(goodsModel, at: self.collectionView.tag)
//            print("----------%d",self.addSelectArray[self.collectionView.tag])
//            self.collectionView.reloadItems(at: [IndexPath(row: selectRow, section: 0)])
            self.collectionView.reloadData()
        }
    }
    var photoScrollViewTag:Int = 0{
        didSet {
            self.photoScrollView.scrollView.tag = photoScrollViewTag
        }
    }
//    订单号
    var orderNum:String = ""{
        didSet {
            self.photoScrollView.scrollView.tag = self.collectionView.tag
            self.orderNumber = orderNum
        }
    }
//    星星
    var selectStarIndex:String = ""{
        didSet {
            if selectStarIndex == "1"{
                self.starImage1.image = UIImage(named: "starImage_G")
                self.starImage2.image = UIImage(named: "starImage_N")
                self.starImage3.image = UIImage(named: "starImage_N")
                self.starImage4.image = UIImage(named: "starImage_N")
                self.starImage5.image = UIImage(named: "starImage_N")
            }else if selectStarIndex == "2"{
                self.starImage1.image = UIImage(named: "starImage_G")
                self.starImage2.image = UIImage(named: "starImage_G")
                self.starImage3.image = UIImage(named: "starImage_N")
                self.starImage4.image = UIImage(named: "starImage_N")
                self.starImage5.image = UIImage(named: "starImage_N")
            }else if selectStarIndex == "3"{
                self.starImage1.image = UIImage(named: "starImage_H")
                self.starImage2.image = UIImage(named: "starImage_H")
                self.starImage3.image = UIImage(named: "starImage_H")
                self.starImage4.image = UIImage(named: "starImage_N")
                self.starImage5.image = UIImage(named: "starImage_N")
            }else if selectStarIndex == "4"{
                self.starImage1.image = UIImage(named: "starImage_H")
                self.starImage2.image = UIImage(named: "starImage_H")
                self.starImage3.image = UIImage(named: "starImage_H")
                self.starImage4.image = UIImage(named: "starImage_H")
                self.starImage5.image = UIImage(named: "starImage_N")
            }else if selectStarIndex == "5"{
                self.starImage1.image = UIImage(named: "starImage_H")
                self.starImage2.image = UIImage(named: "starImage_H")
                self.starImage3.image = UIImage(named: "starImage_H")
                self.starImage4.image = UIImage(named: "starImage_H")
                self.starImage5.image = UIImage(named: "starImage_H")
            }
        }
    }
    @objc func selectButtonClick(selectBtn:UIButton){
        
        if selectBtn.isSelected == true{
            selectBtn.isSelected = false
            selectBtn.layer.borderColor = YMColor(r: 153, g: 153, b: 153, a: 1).cgColor
            selectBtn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State.normal)
        }else{
            selectBtn.isSelected = true
            selectBtn.layer.borderColor = YMColor(r: 255, g: 140, b: 43, a: 1).cgColor
            selectBtn.setTitleColor(YMColor(r: 255, g: 140, b: 43, a: 1), for: UIControl.State.normal)
        }

    }
//    点击第一颗星
    @objc func selectstarButtonClick(starBtn1:UIButton){
        delegate?.selectLoockGoodsInfo(selectStar: 1, selectRow: starBtn1.tag)
//        self.starImage1.image = UIImage(named: "starImage_G")
//        self.starImage2.image = UIImage(named: "starImage_N")
//        self.starImage3.image = UIImage(named: "starImage_N")
//        self.starImage4.image = UIImage(named: "starImage_N")
//        self.starImage5.image = UIImage(named: "starImage_N")
        stratCount = "1"
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStarListGoodsAble"), object:self, userInfo: ["goodsStar":"1","indexLabel":self.starBtn1.tag,"starIndex":"1"])

    }
    @objc func selectstarButtonClick1(starBtn2:UIButton){
         delegate?.selectLoockGoodsInfo(selectStar: 1, selectRow: starBtn2.tag)
//        self.starImage1.image = UIImage(named: "starImage_G")
//        self.starImage2.image = UIImage(named: "starImage_G")
//        self.starImage3.image = UIImage(named: "starImage_N")
//        self.starImage4.image = UIImage(named: "starImage_N")
//        self.starImage5.image = UIImage(named: "starImage_N")
        stratCount = "1"
         NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStarListGoodsAble"), object:self, userInfo: ["goodsStar":"2","indexLabel":self.starBtn3.tag,"starIndex":"2"])

    }
    @objc func selectstarButtonClick2(starBtn3:UIButton){
          delegate?.selectLoockGoodsInfo(selectStar: 2, selectRow: starBtn3.tag)
//        self.starImage1.image = UIImage(named: "starImage_H")
//        self.starImage2.image = UIImage(named: "starImage_H")
//        self.starImage3.image = UIImage(named: "starImage_H")
//        self.starImage4.image = UIImage(named: "starImage_N")
//        self.starImage5.image = UIImage(named: "starImage_N")
        stratCount = "2"
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStarListGoodsAble"), object:self, userInfo: ["goodsStar":"3","indexLabel":self.starBtn3.tag,"starIndex":"3"])

    }
    @objc func selectstarButtonClick3(starBtn4:UIButton){
          delegate?.selectLoockGoodsInfo(selectStar: 3, selectRow: starBtn4.tag)
//        self.starImage1.image = UIImage(named: "starImage_H")
//        self.starImage2.image = UIImage(named: "starImage_H")
//        self.starImage3.image = UIImage(named: "starImage_H")
//        self.starImage4.image = UIImage(named: "starImage_H")
//        self.starImage5.image = UIImage(named: "starImage_N")
        stratCount = "3"

        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStarListGoodsAble"), object:self, userInfo: ["goodsStar":"4","indexLabel":self.starBtn4.tag,"starIndex":"4"])
        print("----------%d",self.addSelectArray[self.collectionView.tag])
    }
    @objc func selectstarButtonClick4(starBtn5:UIButton){
          delegate?.selectLoockGoodsInfo(selectStar: 3, selectRow: starBtn5.tag)
//        self.starImage1.image = UIImage(named: "starImage_H")
//        self.starImage2.image = UIImage(named: "starImage_H")
//        self.starImage3.image = UIImage(named: "starImage_H")
//        self.starImage4.image = UIImage(named: "starImage_H")
//        self.starImage5.image = UIImage(named: "starImage_H")
        stratCount = "3"
//        var goodsModel = self.addSelectArray[self.starBtn5.tag]
//        goodsModel.goodsDevel = "3"
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentBtnStarListGoodsAble"), object:self, userInfo: ["goodsStar":"5","indexLabel":self.starBtn5.tag,"starIndex":"5"])

    }
    var goodsListModel:YDGoodsListCommentModel? {
        didSet {
            guard let model = goodsListModel else {return}
            self.iconImage.kf.setImage(with: URL(string:model.goodsImage ?? ""))
            self.nameLabel.text = model.goodsName
        }
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//编辑完成
extension YDGoodsCommentTableViewCell:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        print("----------%d",YDTextView.tag)
        var goodsModel = self.addSelectArray[self.YDTextView.tag]
        goodsModel.goodsContent = YDTextView.text
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshCommentListGoodsAble"), object:self, userInfo: ["goodsAble":YDTextView.text,"indexLabel":YDTextView.tag])
    }
}
//选中便签
extension YDGoodsCommentTableViewCell:YDGoodsCommentCollectionViewCellDelegate{
    func GoodsCommentListCollectionView(titleButton: UIButton) {
        print("选中便签----------%d",self.titleArray)
        NotificationCenter.default.post(name: NSNotification.Name.init("refreshOrderCommentGoodsAbleTableViewCell"), object:self, userInfo: ["horsemanLabel":self.titleArray[titleButton.tag],"isSelect":titleButton.isSelected,"selectTag":self.collectionView.tag])

    }
}
extension YDGoodsCommentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YDGoodsCommentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:YDGoodsCommentCollectionViewCellID, for: indexPath) as! YDGoodsCommentCollectionViewCell
        cell.titleBtn.tag = indexPath.row
        cell.delegate = self
        for (index,title) in self.selectTitleArray.enumerated() {
            if title == self.titleArray[indexPath.row]{
                cell.selectTitleArray = title
            }
        }
//        cell.selectTitleArray = ""
        cell.nameArray = self.titleArray[indexPath.row]

        
         print("每一行标签----------%d", cell.nameArray)
         print("每一行selectTitleArray----------%d", cell.selectTitleArray)
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
