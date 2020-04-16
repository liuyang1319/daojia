//
//  YDApplicationRefundFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import AliyunOSSiOS
//import CLImagePickerTool
protocol YDApplicationRefundFooterViewViewDelegate:NSObjectProtocol {
    //    商品折叠
    func selectGoodsListFoldFooterView(goodsliset:UIButton)
//    选择问题
    func selectApplicationRefundIssueFooterView()
//    提交申请
    func submitApplicationRefundFooterView(refundImg:String,refundAble:String)
    
}
class YDApplicationRefundFooterView: UITableViewHeaderFooterView ,JNStarReteViewDelegate{
    
    // 如果是单独访问相机，一定要声明为全局变量
    let imagePickTool = CLImagePickerTool()
    //    选择图片
    var photoScrollView = PhotoView()
    //    记录图片
    var indexImage = Int()
//    上传图片
    var uriArr = [String]()
    var goodsImage = String()
    weak var delegate : YDApplicationRefundFooterViewViewDelegate?

//    退款图片URL
    var refundImgUrl = String()
//    退款说明
    var refundAbleStr = String()
    
    var YDTextView = JHTextView()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var listButton :UIButton = {
        let button = UIButton()
        button.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(lookSelectGoodslistButtonClick(GoodsList:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 15
        button.isSelected = false
        button.clipsToBounds = true
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "message_down"), for: UIControl.State.normal)
        button.setTitle("共0件", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        return button
    }()
    
    
    // 分割线
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    lazy var backView1 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    lazy var reasonLabel : UILabel = {
        let label = UILabel()
        label.text = "退款原因（必选)"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var conditionLabel : UILabel = {
        let label = UILabel()
        label.text = "请选择"
        label.textAlignment = .right
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var selectImage : UIImageView = {
        let select = UIImageView()
        select.image = UIImage(named:"arrowsImage")
        return select
    }()
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectApplicationRefundButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var backView2 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    lazy var prickTilte : UILabel = {
        let label = UILabel()
        label.text = "退款金额"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var prick : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = YMColor(r: 255, g: 140, b: 43, a: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var backView3 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    lazy var stateLabel : UILabel = {
        let label = UILabel()
        label.text = "退款说明"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    lazy var backView4 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    lazy var imageLabel : UILabel = {
        let label = UILabel()
        label.text = "上传图片(选填)"
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var submitBtn : UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitle("提交", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(submitApplicationRefundClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
//        self.YDTextView.delegate = self
        self.YDTextView.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(self.doneButtonClicked(textView:)))
        
         NotificationCenter.default.addObserver(self, selector: #selector(ApplicationRefundIssueName(nofit:)), name: NSNotification.Name(rawValue:"ApplicationRefundIssue"), object: nil)
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: 0, width: LBFMScreenWidth-30, height: 45)
        

        
        self.backView.addSubview(self.listButton)
        self.listButton.frame = CGRect(x: (LBFMScreenWidth-140)*0.5, y: 10, width: 110, height: 25)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.listButton.frame.maxY + 10, width: LBFMScreenWidth-60, height: 1)
        
        self.addSubview(self.backView1)
        self.backView1.frame = CGRect(x: 15, y: self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
        
        self.backView1.addSubview(self.reasonLabel)
        self.reasonLabel.frame = CGRect(x: 15, y: 15, width: 115, height: 20)
        
        self.backView1.addSubview(self.selectImage)
        self.selectImage.frame = CGRect(x: LBFMScreenWidth-55, y: 17.5, width: 10, height: 15)
        
        self.backView1.addSubview(self.conditionLabel)
        self.conditionLabel.frame = CGRect(x:self.reasonLabel.frame.maxX + 15, y: 15, width:self.selectImage.frame.minX - self.reasonLabel.frame.maxX - 20, height: 20)
        
        self.addSubview(self.selectBtn)
        self.selectBtn.frame = CGRect(x: 15, y: self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 50)
        
        self.addSubview(self.backView2)
        self.backView2.frame = CGRect(x: 15, y: self.backView1.frame.maxY+15, width: LBFMScreenWidth-30, height: 55)
        
        self.backView2.addSubview(self.prickTilte)
        self.prickTilte.frame = CGRect(x: 15, y: 17.5, width: 58, height: 20)
        
        self.backView2.addSubview(self.prick)
        self.prick.frame = CGRect(x: self.prickTilte.frame.maxX + 15, y: 15, width: 200, height: 25)
        
        
        self.addSubview(self.backView3)
        self.backView3.frame = CGRect(x: 15, y: self.backView2.frame.maxY+15, width: LBFMScreenWidth-30, height: 115)
        
        self.backView3.addSubview(self.stateLabel)
        self.stateLabel.frame = CGRect(x: 15, y: 15, width: 60, height: 20)
        
        
        self.backView3.addSubview(self.YDTextView)
        self.YDTextView.frame = CGRect(x:15, y: self.stateLabel.frame.maxY+10, width: LBFMScreenWidth-60, height: 60)
        self.YDTextView.placeHolder = "请输入退款说明"
        self.YDTextView.placeHolderColor = YMColor(r: 226, g: 226, b: 226, a: 1)
        self.YDTextView.font = UIFont.systemFont(ofSize: 13)
        self.YDTextView.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        self.YDTextView.layer.borderColor = YMColor(r: 227, g: 227, b: 227, a: 1).cgColor;
        self.YDTextView.layer.borderWidth = 1
        self.YDTextView.layer.cornerRadius = 5
        //        self.YDTextView.MaxCount = 30
//        self.YDTextView.tapTwiceDisapper = true
        
        self.addSubview(self.backView4)
        self.backView4.frame = CGRect(x: 15, y: self.backView3.frame.maxY + 15, width: LBFMScreenWidth-30, height: 125)
        
        self.backView4.addSubview(self.imageLabel)
        self.imageLabel.frame = CGRect(x: 15, y: 15, width: 115, height: 20)
        
        self.addSubview(self.submitBtn)
        self.submitBtn.frame = CGRect(x: 15, y: self.backView4.frame.maxY+15, width: LBFMScreenWidth-30, height: 40)
        
        self.backView4.addSubview(self.photoScrollView)
        self.photoScrollView.frame = CGRect(x:15, y: self.imageLabel.frame.maxY+5, width: LBFMScreenWidth-60, height: 140)
        
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
            imagePickTool.cl_setupImagePickerWith(MaxImagesCount:6) { (asset,cutImage) in
                print("返回的asset数组是\(asset)")
                
                //获取缩略图，耗时较短
                let imageArr = CLImagePickerTool.convertAssetArrToThumbnailImage(assetArr: asset, targetSize: CGSize(width: 800, height:800))
                print(imageArr)
                
                self.photoScrollView.picArr.removeAll()
                self.photoScrollView.picArr.append(UIImage(named: "takePicture")!)
                self.indexImage = 0
                for item in imageArr {
                    self.photoScrollView.picArr.append(item)
                }
                //                let uploadImage = OSSUploadManager()
                
                
                DispatchQueue.global().async {
                    for image in self.photoScrollView.picArr {
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
                                if self.indexImage > 1{
                                    self.uriArr.append(key)
                                }
                                if self.uriArr.count == imageArr.count - 1 {
//                                    var goodsModel = self.addSelectArray[self.collectionView.tag]
                                    self.goodsImage = self.uriArr.joined(separator: ",")
//                                    goodsModel.goodsImage = goodsImage
//                                    self.addSelectArray.insert(goodsModel, at: self.collectionView.tag)
//                                    print("----------%d",self.addSelectArray[self.collectionView.tag])
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
        
        return String(format: "ios/refundImages/%@.png",timeNow);
        
    }
    var prickName : Double = 0{
        didSet {
            self.prick.text = String(format: "¥%.2f",prickName)
        }
    }
    var goodsCount : Int = 0{
        didSet {
            self.listButton.setTitle("共\(goodsCount)件", for: UIControl.State.normal)
            
        }
    }
    
//    输入问题
    @objc func doneButtonClicked(textView:Any) {
        self.YDTextView = textView as! JHTextView
        self.refundAbleStr = self.YDTextView.text
    }
//  选择问题
    @objc func ApplicationRefundIssueName(nofit:Notification){
        self.conditionLabel.text = (nofit.userInfo?["Issue"] as! String)
        if self.conditionLabel.text?.isEmpty != true {
            self.submitBtn.backgroundColor = YMColor(r: 88, g: 202, b: 54, a: 1)
            self.submitBtn.isUserInteractionEnabled = true
        }else{
            self.submitBtn.backgroundColor = YMColor(r: 216, g: 216, b: 216, a: 1)
            self.submitBtn.isUserInteractionEnabled = false
        }
        
    }
    //    折叠商品
    @objc func lookSelectGoodslistButtonClick(GoodsList:UIButton){
        delegate?.selectGoodsListFoldFooterView(goodsliset:GoodsList)
    }
//    选择商品问题
    @objc func selectApplicationRefundButtonClick(){
        delegate?.selectApplicationRefundIssueFooterView()
    }
//   提交
    @objc func submitApplicationRefundClick(){
        delegate?.submitApplicationRefundFooterView(refundImg: self.goodsImage, refundAble: self.refundAbleStr)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension YDApplicationRefundFooterView :UITextViewDelegate{
    
}
