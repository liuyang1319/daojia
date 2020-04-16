//
//  YDUserCenterAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
let YDUserCenterProvider = MoyaProvider<YDUserCenterAPI>()
enum YDUserCenterAPI {
    // 查询个人信息
    case getUserCenterInfo(token: NSString,memberPhone:NSString)
//    更新用户信息,性别
    case setUpdateUserCenterSexInfo(token: NSString,
        memberPhone:NSString,sex:String)
    //    更新用户信息,生日
    case setUpdateUserCenterBirthdayInfo(token: NSString,
        memberPhone:NSString,birthday:String)
    //    更新用户信息,昵称
    case setUpdateUserCenterNameInfo(token: NSString,
        memberPhone:NSString,name:String)
    //    更改手机号，旧手机获取验证码
    case setUpdateUserCenterPhoneMessageInfo(token: String,
        memberPhone:String)
    //    更改手机号，旧手机验证
    case setUpdateUserCenterPhoneVerifyInfo(token: NSString,
        memberPhone:NSString,phoneCode:NSString)
    //    更改手机号，新手机号获取验证码
    case setUpdateUserCenterNewPhoneInfo(newPhone:NSString)
    //    更改手机号，新手机号验证
    case setUpdateUserCenterNewPhoneVerifyInfo(newPhone:String,newPhoneCode:String,token: String,
        memberPhone:String)
    //    更改头像
    case setUpdateUserCenterNewHeadImageVerifyInfo(headImg:NSString,token: NSString,
        memberPhone:NSString)
    
}
extension YDUserCenterAPI: TargetType {

    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getUserCenterInfo: return "/person/personCenter"
        case .setUpdateUserCenterSexInfo: return "/person/updatePerson"
        case .setUpdateUserCenterBirthdayInfo: return "/person/updatePerson"
        case .setUpdateUserCenterNameInfo: return "/person/updatePerson"
        case .setUpdateUserCenterPhoneMessageInfo: return "/member/updateMessage"
        case .setUpdateUserCenterPhoneVerifyInfo: return "/member/checkPhone"
        case .setUpdateUserCenterNewPhoneInfo: return "/member/updatePhoneMessage"
        case .setUpdateUserCenterNewPhoneVerifyInfo: return "/member/checkNewPhone"
        case .setUpdateUserCenterNewHeadImageVerifyInfo: return "/person/updatePerson"
        }
    }
    
    var method: Moya.Method {
        
        return .post
        
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
            case .getUserCenterInfo(let token, let memberPhone): break
          
            case .setUpdateUserCenterSexInfo(let token,
                                          let memberPhone,
                                          let sex):
                            parmeters["sex"] = sex
        case .setUpdateUserCenterBirthdayInfo(let token,
                                         let memberPhone,
                                         let birthday):
            parmeters["birthday"] = birthday
        case .setUpdateUserCenterNameInfo(let token,
                                              let memberPhone,
                                              let name):
            parmeters["name"] = name
        case .setUpdateUserCenterPhoneMessageInfo(let token,
                                                  let memberPhone): break
        case .setUpdateUserCenterPhoneVerifyInfo(let token,
                                                 let memberPhone,
                                                 let phoneCode):
            parmeters["phoneCode"] = phoneCode
        case .setUpdateUserCenterNewPhoneInfo(let newPhone):
             parmeters["newPhone"] = newPhone
            
        case .setUpdateUserCenterNewPhoneVerifyInfo(let newPhone,
                                                    let newPhoneCode,
                                                    let token,
                                                    let memberPhone):
            parmeters["newPhone"] = newPhone
            parmeters["newPhoneCode"] = newPhoneCode
        case .setUpdateUserCenterNewHeadImageVerifyInfo(let headImg,let token,let memberPhone):
            
             parmeters["headImg"] = headImg
            
            
        }
        
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .getUserCenterInfo(let token, let memberPhone):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterSexInfo(let token,
                                         let memberPhone,
                                         let sex):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterBirthdayInfo(let token,
                                         let memberPhone,
                                         let birthday):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterNameInfo(let token,
                                              let memberPhone,
                                              let name):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterPhoneMessageInfo(let token,
                                          let memberPhone):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
         case .setUpdateUserCenterPhoneVerifyInfo(let token,
                                                  let memberPhone,
                                                  let phoneCode):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterNewPhoneInfo(let newPhone):
            return nil
        case .setUpdateUserCenterNewPhoneVerifyInfo( let newPhone,
                                                     let newPhoneCode,
                                                     let token,
                                                     let memberPhone):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
        case .setUpdateUserCenterNewHeadImageVerifyInfo(let headImg,let token,let memberPhone):
            return ["token":token as String,
                    "memberPhone":memberPhone as String]
            
        }
    }
}
