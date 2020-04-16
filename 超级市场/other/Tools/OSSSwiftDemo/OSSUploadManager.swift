//
//  OSSUploadManager.swift
//  OSSUploadPic
//
//  Created by 杨静云 on 2018/8/3.
//  Copyright © 2018年 NiBoDaDao. All rights reserved.
//

import UIKit
import AliyunOSSiOS
typealias OSSUploadBlock = (_ result : String) -> Void
typealias OSSUploadImagesBlock = (_ resultArr : Array<String>) -> Void

class OSSUploadManager: NSObject {
    
//    static let instance = OSSUploadManager()
   var uriArr:Array<String> = [String]()
    
    override init() {
        super .init()
    }
    
    /**
     *  单个图片上传至oss,返回uri
     */
    func uploadImage(image:UIImage,type:EnumPicType,success:@escaping OSSUploadBlock){
        print(image);
        //将image转换成Data
        let objectKeys = OSSImageName(type: type)
        let put = ossPutWithImage(image: image, objectKeys: objectKeys)
        let client = OSSClientManager.createClient();
        let putTask = client.putObject(put)

        putTask.continue ({ (task:OSSTask) -> Any? in
            
            if (!(task.error != nil)) {
                print("upload object success!");
                success(objectKeys)
                //return urlString!;
            } else {
                print("upload object failed, error: %@" , task.error);
                success("")
            }
            return nil
        })
        //print(urlString);
    }
    
    func uploadImagesArr(imageArr:Array<UIImage>,type:EnumPicType,success:@escaping OSSUploadImagesBlock){
        
        DispatchQueue.global().async {
            for image:UIImage in imageArr {
//                TestLog(self.uriArr)
                let put = OSSPutObjectRequest()
                put.bucketName = bucketName
                put.objectKey = OSSImageName(type: type)
                put.uploadingData = image.pngData()!
                put.contentType = "image/png"
                let credential =  OSSStsTokenCredentialProvider.init(accessKeyId: "LTAI0Kocdjr5d0vM", secretKeyId: "xQmUo73oRSiY2PcdgGDibUi2N1zc1l", securityToken: "")
                let client = OSSClient(endpoint: "http://huihui-app.oss-cn-beijing.aliyuncs.com", credentialProvider: credential)
                let putTask = client.putObject(put)
                putTask.continue ({ (t) -> Any? in
                    if (!(t.error != nil))  {
                        print("upload object success!%@",put.objectKey);
                        self.uriArr.append(put.objectKey)
                        if self.uriArr.count == imageArr.count {
                            DispatchQueue.main.async {
                                success(self.uriArr)
                                self.uriArr.removeAll()
                            }
                        }
                    } else {
                        success([])
                        self.uriArr.removeAll()
                        return nil
                    }
                    return nil;
                }).waitUntilFinished()
            }
        }
    }
    
    private func ossPutWithImage(image:UIImage,objectKeys:String) -> OSSPutObjectRequest {
        //let newImage:UIImage?;
        let imageData:Data?
        imageData = image.pngData()!
        //创建OSSPutObjectRequest对象
        let put = OSSPutObjectRequest()
        
        print(objectKeys)
        put.bucketName = bucketName
        put.objectKey = objectKeys
        put.uploadingData = imageData!;
        put.contentType = "image/png";
        return put
    }
    
    private func imageCompression(image:UIImage,newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
}
