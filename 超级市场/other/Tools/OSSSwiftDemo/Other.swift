//
//  Other.swift
//  OSSUploadPic
//
//  Created by 杨静云 on 2018/8/3.
//  Copyright © 2018年 NiBoDaDao. All rights reserved.
//

import Foundation

let AccessKey = "LTAI0Kocdjr5d0vM"
let SecretKey = "xQmUo73oRSiY2PcdgGDibUi2N1zc1l"
let endpoint = "http://oss-cn-beijing.aliyuncs.com"
let bucketName = "huihui-app"
let cname = "cname"

//枚举(文件路径)可以自定义
enum EnumPicType:String{
    case login
    case auth = "auth"
    case demand = "ios"
    case skill = "skill"
}

//返回文件路径
func OSSImageName(type:EnumPicType) -> String {
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
    if type == EnumPicType.auth {
//        let uid = UserAccountManager.sharedManager.user?.id ?? ""
//        return String(format: "auth/%@/%@", uid,timeNow);
    }
    if type == EnumPicType.demand {
        return String(format: "ios/%@.png",timeNow);
    }
    if type == EnumPicType.skill {
        return String(format: "skill/%@/%@", dateT,timeNow);
    }
    return "error";
}

func OSSCnameUri(uri:String) -> String {
    return uri;
}
