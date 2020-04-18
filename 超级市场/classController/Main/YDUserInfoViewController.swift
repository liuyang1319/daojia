//
//  YDUserInfoViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import MobileCoreServices
import SwiftyJSON
import HandyJSON
import MBProgressHUD
import AliyunOSSiOS

class YDUserInfoViewController: YDBasicViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var sex = String()
    var sexInfo = String()
    var selectDate = String()
    var nakname = NSString()
    var phone = String()
    var headImg = String()
    var birthday = String()
    var alipayStatus = String()
    var wechatStatus = String()
    
    var  pickImageController:UIImagePickerController?

    let YDUserInfoTableViewCellID = "YDUserInfoTableViewCell"
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:LBFMScreenWidth, height:LBFMScreenHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YDUserInfoTableViewCell.self, forCellReuseIdentifier: YDUserInfoTableViewCellID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        self.view.addSubview(self.tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(returnNameValue(nofit:)), name: NSNotification.Name(rawValue:YDUserUpdateName), object: nil)
        requestUserDate()
        
    }
//    请求用户信息
    @objc func requestUserDate(){
        YDUserCenterProvider.request(.getUserCenterInfo(token:UserDefaults.LoginInfo.string(forKey: .token)! as NSString, memberPhone:UserDefaults.LoginInfo.string(forKey: .phone)! as NSString)){ result  in
            
            
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        if DYStringIsEmpty(value:json["data"]["headImg"].string as AnyObject? ) != true{
                            self.headImg = json["data"]["headImg"].string! as String
                        }
                    
                        if DYStringIsEmpty(value:json["data"]["name"].string as AnyObject?) != true{
                            self.nakname = json["data"]["name"].string! as NSString
                        }else{
                            self.nakname = "未填写"
                        }
                    
                        if json["data"]["sex"] == 1{
                            self.sex = "男士"
                        }else if json["data"]["sex"] == 2{
                            self.sex = "女士"
                        }else{
                            self.sex = "保密"
                        }
                  
                    
                        if DYStringIsEmpty(value:json["data"]["birthday"].string as AnyObject?) != true{
                            self.birthday = json["data"]["birthday"].string! as String
                        }else{
                            self.birthday = "未填写"
                        }
                    
                        if DYStringIsEmpty(value:json["data"]["phone"].string as AnyObject?) != true{
                            let iphone =  json["data"]["phone"].string ?? ""
                            let endStr1 = iphone.prefix(3)
                            let endStr2 = iphone.suffix(4)
                            self.phone = String(format:"%@****%@", endStr1 as CVarArg,endStr2 as CVarArg)
                        }else{
                            self.phone = "未绑定"
                        }
                        if json["data"]["wechatStatus"] == 1{
                            self.wechatStatus = "未绑定"
                        }else if json["data"]["wechatStatus"] == 2{
                            self.wechatStatus = "已绑定"
                        }
                    
                        if json["data"]["alipayStatus"] == 1{
                            self.alipayStatus = "未绑定"
                        }else if json["data"]["alipayStatus"] == 2{
                            self.alipayStatus = "已绑定"
                        }
                    
                        self.tableView.reloadData()
                    }
                }
                }
            }
        }
    }
//    修改昵称
    @objc func returnNameValue(nofit:Notification) {
        let str = nofit.userInfo!["name"]
        self.nakname = str as! NSString
        self.tableView.reloadData()
    }
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    //打开相册
    func openAblum(){
        
        // 获取相册权限
        let authStatus = PHPhotoLibrary.authorizationStatus()
        
        //用户尚未授权
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            PHPhotoLibrary.requestAuthorization({ [weak self] (states) in
                // 判断用户选择了什么
                
                guard let strongSelf = self else { return }
                
                if states == .authorized {
                    strongSelf.openPhoto()
                    
                } else if states == .restricted || states == .denied {
                    if #available(iOS 10.0, *) {
                        self?.gotoSetting()
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
            })
            
        } else if authStatus == .authorized {
            // 可以访问 去打开相册
            self.openPhoto()
            
        } else if authStatus == .restricted || authStatus == .denied {
            if #available(iOS 10.0, *) {
                self.gotoSetting()
            } else {
                // Fallback on earlier versions
            }
        }
//        weak var weakSelf=self
//
//        pickImageController = UIImagePickerController.init()
//        //savedPhotosAlbum是根据日期排列，photoLibrary是所有相册
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
//
//            //获取相册权限
//            PHPhotoLibrary.requestAuthorization({ (status) in
//                switch status {
//                case .notDetermined: break
//
//                case .restricted://此应用程序没有被授权访问的照片数据
//                    if #available(iOS 10.0, *) {
//                        self.gotoSetting()
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                    break
//                case .denied://用户已经明确否认了这一照片数据的应用程序访问
//                    if #available(iOS 10.0, *) {
//                        self.gotoSetting()
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                    break
//                case .authorized://已经有权限
//                    weakSelf!.pickImageController!.delegate = self
//                    weakSelf!.pickImageController!.allowsEditing = true
//                    weakSelf!.pickImageController!.sourceType = UIImagePickerController.SourceType.photoLibrary;
//                    //                    weakSelf?.pickImageController?.mediaTypes=[kUTTypeMovie as String]//只有视频
//                    weakSelf?.pickImageController?.mediaTypes=[kUTTypeImage as String]//只有照片
////                    weakSelf?.pickImageController?.mediaTypes=UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//包括照片和视频
//                    //弹出相册页面或相机
//                    self.present( weakSelf!.pickImageController!, animated: true, completion: {
//                    })
//
//                    break
//                }
//            })
//
//        }
//
        
    }
    func openPhoto() {
          if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
              DispatchQueue.main.async {
                  let picker = UIImagePickerController()
                  picker.delegate = self
                  picker.sourceType = .photoLibrary
                if #available(iOS 13.0, *) {
                    picker.modalPresentationStyle = .fullScreen
                } else {
                               // Fallback on earlier versions
                }
                  self.present(picker, animated: true)
              }
          }
          
      }
    //打开相机拍照或者录像
    func openCamera(){
        
        // 判断相机权限
              let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
              
              //用户尚未授权
              if authStatus == .notDetermined {
                  // 第一次触发授权 alert
                  PHPhotoLibrary.requestAuthorization({ [weak self] (states) in
                      // 判断用户选择了什么
                      
                      guard let strongSelf = self else { return }
                      
                      if states == .authorized {
                          strongSelf.openCamera1()
                          
                      } else if states == .restricted || states == .denied {
                        if #available(iOS 10.0, *) {
                            self?.gotoSetting()
                        } else {
                            // Fallback on earlier versions
                        }
                      }
                      
                  })
                  
              } else if authStatus == .authorized {
                  // 可以访问 去打开相册
                  self.openCamera1()
                  
              } else if authStatus == .restricted || authStatus == .denied {
                if #available(iOS 10.0, *) {
                    self.gotoSetting()
                } else {
                    // Fallback on earlier versions
                }
              }
//        weak var weakSelf=self
//        pickImageController = UIImagePickerController.init()
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
//
//            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (ist) in
//                //检查相机权限
//                let status:AVAuthorizationStatus=AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//                if status==AVAuthorizationStatus.authorized {// 有相机权限
//
//                    //跳转到相机或者相册
//                    weakSelf!.pickImageController!.delegate = self
//                    weakSelf!.pickImageController!.allowsEditing = true
//                    self.pickImageController!.sourceType = UIImagePickerController.SourceType.camera;
//                    weakSelf?.pickImageController?.mediaTypes=[kUTTypeImage as String]//拍照
//
//
//                    //弹出相册页面或相机
//                    self.present(self.pickImageController!, animated: true, completion: {
//
//                    })
//                }else if (status==AVAuthorizationStatus.denied)||(status==AVAuthorizationStatus.restricted) {
//                    if #available(iOS 10.0, *) {
//                        self.gotoSetting()
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                }else if(status==AVAuthorizationStatus.notDetermined){//权限没有被允许
//                    if #available(iOS 10.0, *) {
//                        self.gotoSetting()
//                    } else {
//                        // Fallback on earlier versions
//                    }
////                    //去请求权限
////                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { (genter) in
////                        if (genter){
////
////                        }else{
////                            if #available(iOS 10.0, *) {
////                                self.gotoSetting()
////                            } else {
////                                // Fallback on earlier versions
////                            }
////                        }
////                    }
//                }
//            })
//        }
    }
    // 打开相机
    func openCamera1() {
//        self.clearAllNotice()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            DispatchQueue.main.async {
                let  cameraPicker = UIImagePickerController()
                cameraPicker.delegate = self
                cameraPicker.allowsEditing = true
                cameraPicker.sourceType = .camera
                //在需要的地方present出来
                if #available(iOS 13.0, *) {
                    cameraPicker.modalPresentationStyle = .fullScreen
                } else {
                                                               // Fallback on earlier versions
                }
                self.present(cameraPicker, animated: true, completion: nil)
            }
            
        }
    }
    //去设置权限
    @available(iOS 10.0, *)
    func gotoSetting(){
        
        let alertController = UIAlertController(title: "照片/相机访问受限",message: "去开启权限，允许访问您的照片/相机", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {action in
            self.navigationController?.popViewController(animated: true)
            
        })
        
        let okAction = UIAlertAction(title: "去开启权限", style: .default,
                                     handler: {action in
                                        
                                        let url=URL.init(string: UIApplication.openSettingsURLString)
                                        if UIApplication.shared.canOpenURL(url!){
                                            
                                            UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                                                
                                                UIApplication.shared.openURL(url!)
                                                
                                            })
                                        }
                                        
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
//        let alertController:UIAlertController=UIAlertController.init(title: "照片/相机访问受限", message: "去开启权限，允许访问您的照片/相机", preferredStyle: UIAlertController.Style.alert)
//
//        let sure:UIAlertAction=UIAlertAction.init(title: "去开启权限", style: UIAlertAction.Style.default) { (ac) in
//            let url=URL.init(string: UIApplication.openSettingsURLString)
//            if UIApplication.shared.canOpenURL(url!){
//
//                UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
//
//                    UIApplication.shared.openURL(url!)
//
//                })
//            }
//        }
//        let cancel:UIAlertAction=UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (ac) in
//
//        }
//        alertController.addAction(cancel)
//        alertController.addAction(sure)
//        if #available(iOS 13.0, *) {
//            alertController.modalPresentationStyle = .automatic
//        } else {
//            alertController.modalPresentationStyle = .fullScreen
//        }
//        self.present(alertController, animated: true, completion: nil)
    }
    
    //    要将MobileCoreServices 框架添加到项目中,导入：#import <MobileCoreServices/MobileCoreServices.h> 。不然后出现错误使用未声明的标识符 'kUTTypeMovie'
    //    swift 中import MobileCoreServices
    
    //选中图片，保存图片或视频到系统相册
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        //取消选择
        picker.dismiss(animated: true) {
            
        }
        var image: UIImage?
        print("\(info)")

        let typ:String = (info[UIImagePickerController.InfoKey.mediaType]as!String)//类型
        // 图片类型"public.image"
            if(picker.allowsEditing){
                //裁剪后图片
                image=(info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
            }else{
                //原始图片
                image=(info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
            }
            
            //缩小图片
            let newSize=CGSize.init(width: 200, height:200)
            UIGraphicsBeginImageContext(newSize)
            
            image!.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext();
            //        这个是系统的方法，先来解释下各个参数:
            //        1.image:将要保存的图片
            //        2.completionTarget:保存完毕后，回调方法所在的对象
            //        3.completionSelector:保存完毕后，回调的方法
            //        4.contextInfo:可选参数
            UIImageWriteToSavedPhotosAlbum(newImage, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        
       
        
    }
    //保存到系统相册
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        print("保存相册成功")
        putObject(image: image)
    }
    
    @objc func putObject(image: UIImage) {
        let request = OSSPutObjectRequest()
        request.uploadingData = image.pngData()!
        request.bucketName = "huihui-app"
        request.objectKey = OSSImageName()
        request.uploadProgress = { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            print("bytesSent:\(bytesSent),totalBytesSent:\(totalBytesSent),totalBytesExpectedToSend:\(totalBytesExpectedToSend)");
        };
        let provider =  OSSStsTokenCredentialProvider.init(accessKeyId: AccessKey, secretKeyId: SecretKey, securityToken:"")
        let client = OSSClient(endpoint: "http://oss-cn-beijing.aliyuncs.com", credentialProvider: provider)
        let task = client.putObject(request)
        task.continue({ (task) -> Any? in
            if (!(task.error != nil)) {
                let key = "http://huihui-app.oss-cn-beijing.aliyuncs.com/" + request.objectKey
                print("upload object success%@",key);
              
                self.setUpdateUserCenterNewHeadImage(imageKey: key)
            
                //                success(objectKeys)
                //return urlString!;
            } else {
                print("upload object failed, error: %@" , task.error);
                //                success("")
            }
            return nil
        }).waitUntilFinished()
        

    }
    
    func OSSImageName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMddhhmmssSSS"
        let date = formatter.string(from: Date())
        
        let formatterT = DateFormatter()
        formatterT.dateFormat = "yyyyMMdd"
        let dateT = formatterT.string(from: Date())
        //取出个随机数
        let last = arc4random() % 10000;
        let timeNow = String(format: "%@-%i", date,last)

        return String(format: "ios/user/%@.png",timeNow);

    }
    func setUpdateUserCenterNewHeadImage(imageKey:String) {
        YDUserCenterProvider.request(.setUpdateUserCenterNewHeadImageVerifyInfo(headImg: imageKey as NSString, token: UserDefaults.LoginInfo.string(forKey:.token)! as NSString, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as NSString)){ result  in
            
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print("-------%@",json)
                if json["success"] == true{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"YDUserInfoViewControllerRequestUserImage"), object:nil ,userInfo:nil)
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = "修改成功"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                    self.headImg = imageKey
                    self.tableView.reloadData()
                }else{
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = MBProgressHUDMode.text
                    hud.label.text = json["error"]["errorMessage"].description
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(animated: true, afterDelay: 1)
                }
            }
            
        }
    }
    func showResult(task: OSSTask<AnyObject>?) -> Void {
        if (task?.error != nil) {
            let error: NSError = (task?.error)! as NSError
            self.ossAlert(title: "error", message: error.description)
        }else
        {
            let result = task?.result
            self.ossAlert(title: "notice", message: result?.description)
        }
    }
    func ossAlert(title: String?,message:String?) -> Void {
        DispatchQueue.main.async {
            let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alertCtrl.addAction(UIAlertAction(title: "confirm", style: UIAlertAction.Style.default, handler: { (action) in
                print("\(action.title!) has been clicked");
                alertCtrl.dismiss(animated: true, completion: nil)
            }))
            if #available(iOS 13.0, *) {
                alertCtrl.modalPresentationStyle = .fullScreen
            } else {
                                                                          // Fallback on earlier versions
            }
            self.present(alertCtrl, animated: true, completion: nil)
        }
    }
    
}
extension YDUserInfoViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }else{
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0&&indexPath.row==0{
            return 75
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "个人信息"
        }else{
            return "绑定账号"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row==0 {
            let cell:YDUserInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: YDUserInfoTableViewCellID, for: indexPath) as! YDUserInfoTableViewCell
            cell.delegate = self
            cell.imageName = self.headImg
            cell.selectionStyle = .none
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
                cell?.selectionStyle = .none
            }
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
            cell?.detailTextLabel?.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            
            
            if indexPath.section==0 && indexPath.row==1{
                cell?.textLabel?.text = "昵称"
                cell?.detailTextLabel?.text = (self.nakname as String).unicodeStr
            }else if indexPath.section==0 && indexPath.row==2{
                cell?.textLabel?.text = "性别"
                cell?.detailTextLabel?.text = self.sex as String
            }else if indexPath.section==0 && indexPath.row==3{
                cell?.textLabel?.text = "生日"
                cell?.detailTextLabel?.text = self.birthday as String
            }else if indexPath.section==0 && indexPath.row==4{
                cell?.textLabel?.text = "地址管理"
                cell?.detailTextLabel?.text = "选择地址"
            }else if indexPath.section==1 && indexPath.row==0{
                cell?.imageView?.image =  UIImage(named:"userPhone")
                cell?.textLabel?.text = "手机"
                cell?.detailTextLabel?.text = self.phone
            }else if indexPath.section==1 && indexPath.row==1{
                cell?.imageView?.image =  UIImage(named:"userWeChat")
                cell?.textLabel?.text = "微信"
                cell?.detailTextLabel?.text = self.wechatStatus
            }else if indexPath.section==1 && indexPath.row==2{
                cell?.imageView?.image =  UIImage(named:"userAlipay")
                cell?.textLabel?.text = "支付宝"
                cell?.detailTextLabel?.text = self.alipayStatus
            }
            
            
            
            
            return cell!
        }
        
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LBFMDownColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==0&&indexPath.row==1{
            let nameVC = YDUpdateNameViewController()
            self.navigationController?.pushViewController(nameVC, animated: true)
        }else if indexPath.section==0&&indexPath.row==2 {
            let sexData = ["男士", "女士"]
            UsefulPickerView.showSingleColPicker("", data: sexData, defaultSelectedIndex: 0) {[unowned self] (selectedIndex, selectedValue) in
                if selectedValue.isEqual("男士"){
                    self.sexInfo = "1"
                }else if selectedValue.isEqual("女士"){
                    self.sexInfo = "2"
                }
                print("%@==========%@",self.sexInfo,selectedValue)
                
                
                YDUserCenterProvider.request(.setUpdateUserCenterSexInfo(token: UserDefaults.LoginInfo.string(forKey: .token)! as NSString, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as NSString, sex: self.sexInfo)){ result  in
                    
                    if case let .success(response) = result {
                        let data = try? response.mapJSON()
                        let json = JSON(data!)
                        print("-------%@",json)
                        if json["success"] == true{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = "修改成功"
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
//                            self.birthday = self.selectDate as String
                            if self.sexInfo == "1"{
                                self.sex = "男士"
                            }else if self.sexInfo == "2"{
                                 self.sex = "女士"
                            }
                            self.tableView.reloadData()
                        }else{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = json["error"]["errorMessage"].description
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
                        }
                    }
                    
                }
            }
 
        }else if indexPath.section==0&&indexPath.row==3 {
            
            UsefulPickerView.showDatePicker("日期选择") {(selectedDate) in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let stringData = formatter.string(from: selectedDate)
                 print("%@==========",stringData)
                YDUserCenterProvider.request(.setUpdateUserCenterBirthdayInfo(token: UserDefaults.LoginInfo.string(forKey: .token)! as NSString, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)! as NSString, birthday:stringData)){ result  in
                    
                    if case let .success(response) = result {
                        let data = try? response.mapJSON()
                        let json = JSON(data!)
                        print("-------%@",json)
                        if json["success"] == true{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = "修改成功"
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
                            self.birthday = stringData
                            self.tableView.reloadData()
                        }else{
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = MBProgressHUDMode.text
                            hud.label.text = json["error"]["errorMessage"].description
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(animated: true, afterDelay: 1)
                        }
                    }
                    
                }
            }
            
           
        }else if indexPath.section==0&&indexPath.row==4{
            let adderVC = YDEditAddersViewController()
            self.navigationController?.pushViewController(adderVC, animated: true)
            
        }else if indexPath.section==1&&indexPath.row==0{
            let iphoneVC = YDUpdateIphoneViewController()
            self.navigationController?.pushViewController(iphoneVC, animated: true)
            
        }
    }
}

extension YDUserInfoViewController:YDUserInfoTableViewCellDelegate{
    func userphoneUpdateClick() {
        weak var weakSelf = self // 弱引用
        let alertController = UIAlertController()
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let directMessagesAction = UIAlertAction(title: "打开相册", style: .default) { (action) in
            self.openAblum()
        }
        let focusOnAction = UIAlertAction(title: "打开相机", style: .default) { (action) in
            self.openCamera()
        }
        alertController.addAction(directMessagesAction)
        alertController.addAction(focusOnAction)
        alertController.addAction(cancelAction)
        weakSelf!.present(alertController, animated: true, completion: nil)
    }
}
