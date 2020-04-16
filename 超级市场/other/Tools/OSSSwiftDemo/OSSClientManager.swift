//
//  OSSClientManager.swift
//  OSSUploadPic
//
//  Created by 杨静云 on 2018/8/3.
//  Copyright © 2018年 NiBoDaDao. All rights reserved.
//

import UIKit
import AliyunOSSiOS
class OSSClientManager: NSObject {
    
    static func createClient() -> OSSClient {
         let credential =  OSSStsTokenCredentialProvider.init(accessKeyId: "LTAI0Kocdjr5d0vM", secretKeyId: "xQmUo73oRSiY2PcdgGDibUi2N1zc1l", securityToken: "")
        let client:OSSClient = OSSClient(endpoint: endpoint, credentialProvider: credential);
        return client;
    }
}
