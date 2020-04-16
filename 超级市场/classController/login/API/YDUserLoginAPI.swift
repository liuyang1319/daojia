//
//  YDUserLoginAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/19.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
/// 用户密码
let YDUserLoginProvider = MoyaProvider<YDUserLoginAPI>()

enum YDUserLoginAPI {
    // 获取验证码
    case getIphoneCode(phone: NSString)
    // 用户验证码登录
    case getUsetLogin(phone:NSString, phoneCode:NSString)
    // 用户密码登录
    case getUserPasswordLogin(password:String,phone:String)
    //    设置密码
    case setUserUpdatePassword(memberPhone:NSString, password:NSString,token:NSString)
    // 忘记密码
    case setUserForgetPassword(phone:String,phoneCode:String,password:String)
    // 忘记密码短信
    case getUserIphoneForgetPasswordCode(phone:NSString)
    // 更换直播
    case changeLiveList
    // 更换其他
    case changeOtherCategory(categoryId:Int)
//    快速登录第一次设置密码
    case setOneUserPassword(password:String,token:String,memberPhone:String)
//    登录修改密码
    case setUserLoginEditPassWord(password:String,newPassword:String,token:String,memberPhone:String)
//    微信登录授权
    case setWeChatLoginPasddWord(openid:String,unionid:String,nickname:String,province:String,city:String,country:String,headimgurl:String)
//    微信绑定-新用户
    case setBindingWeChatUserLogin(openid:String,unionid:String,nickname:String,province:String,city:String,country:String,headimgurl:String,phone:String,phoneCode:String)
}
extension YDUserLoginAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {

        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getIphoneCode: return "/member/accountLogin"
        case .getUsetLogin: return "/member/fastLogin"
        case .getUserPasswordLogin: return "/member/unameLogin"
        case .setUserUpdatePassword: return "/member/setPassword"
        case .setUserForgetPassword: return "/member/forget"
        case .getUserIphoneForgetPasswordCode: return "/member/sendMessage"
        case .changeLiveList: return "/lamia/v1/hotpage/exchange"
        case .changeOtherCategory: return "/mobile/discovery/v4/albums/ts-1535168024113"
        case .setOneUserPassword:return "/member/setPassword"
        case .setUserLoginEditPassWord:return "/member/updatePassword"
        case .setWeChatLoginPasddWord:return "/member/webCreatAuthorize"
        case .setBindingWeChatUserLogin:return "/member/weChatCreat"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getIphoneCode(let phone):
            return .post
        case .getUsetLogin(let phone, let phoneCode):
             return .post
        case .getUserPasswordLogin(let password, let phone):
            return .post
        case .setUserUpdatePassword(let memberPhone, let phoneCode, let password):
            return .post
        case .setUserForgetPassword(let phone, let password, let token):
            return .post
        case .getUserIphoneForgetPasswordCode(let phone):
            return .post
        case .changeLiveList:
            return .post
        case .changeOtherCategory(let categoryId):
            return .post
        case .setOneUserPassword(let password , let token, let memberPhone):
            return .post
        case .setUserLoginEditPassWord(let password ,let newPassword, let token, let memberPhone):
            return .post
        case .setWeChatLoginPasddWord(let openid, let unionid, let nickname, let province, let city, let country, let headimgurl):
            return .post
        case .setBindingWeChatUserLogin(let openid, let unionid, let nickname, let province, let city, let country, let headimgurl, let phone, let phoneCode):
            return .post
        }
        
        
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getIphoneCode(let phone):
            parmeters["phone"] = phone
       
        case .getUsetLogin(let phone, let phoneCode):
            parmeters["phone"] = phone
            parmeters["phoneCode"] = phoneCode
        case .getUserPasswordLogin(let password,let phone):
            parmeters["password"] = password
            parmeters["phone"] = phone
        case .setUserUpdatePassword(let memberPhone, let password,let token):
            parmeters["memberPhone"] = memberPhone
            parmeters["password"] = password
            parmeters["token"] = token
        case .setUserForgetPassword(let phone, let phoneCode,let password):
            parmeters["phone"] = phone
            parmeters["phoneCode"] = phoneCode
            parmeters["password"] = password
        case .getUserIphoneForgetPasswordCode(let phone):
            parmeters["phone"] = phone
        case .changeLiveList: break
            
        case .changeOtherCategory(let categoryId): break
        case .setOneUserPassword(let password,let token, let memberPhone):
            parmeters["password"] = password
        case .setUserLoginEditPassWord(let password ,let newPassword, let token, let memberPhone):
            parmeters["password"] = password
            parmeters["newPassword"] = newPassword
        case .setWeChatLoginPasddWord(let openid,let unionid,let nickname,let province,let city,let country,let headimgurl):
            parmeters["openid"] = openid
            parmeters["unionid"] = unionid
            parmeters["nickname"] = nickname
            parmeters["province"] = province
            parmeters["city"] = city
            parmeters["country"] = country
            parmeters["headimgurl"] = headimgurl
        case .setBindingWeChatUserLogin(let openid,let unionid,let nickname,let province,let city,let country,let headimgurl,let phone,let phoneCode):
            parmeters["openid"] = openid
            parmeters["unionid"] = unionid
            parmeters["nickname"] = nickname
            parmeters["province"] = province
            parmeters["city"] = city
            parmeters["country"] = country
            parmeters["headimgurl"] = headimgurl
            parmeters["phone"] = phone
            parmeters["phoneCode"] = phoneCode
        }
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
            case .getIphoneCode(let phone):
                return ["phone":phone as String]
        case .getUsetLogin(let phone, let phoneCode):
            return ["phone":phone as String,"phoneCode":phoneCode as String]
       
        case .getUserPasswordLogin(let password, let phone):
            return nil
        case .setUserUpdatePassword(let memberPhone, let password, let token):
             return ["memberPhone":memberPhone as String,"token":token as String]
        case .setUserForgetPassword(let phone, let phoneCode, let password):
             return nil
        case .getUserIphoneForgetPasswordCode(let phone):
            return nil
        case .changeLiveList:
            return ["Content-type": "application/json"]
        case .changeOtherCategory(let categoryId):
            return ["Content-type": "application/json"]
        case .setOneUserPassword(let password,let token,let memberPhone):
            return ["memberPhone":memberPhone as String,"token":token as String]
        case .setUserLoginEditPassWord(let password ,let newPassword, let token, let memberPhone):
            return ["memberPhone":memberPhone as String,"token":token as String]
        case .setWeChatLoginPasddWord(let openid,let unionid,let nickname,let province,let city,let country,let headimgurl):
            return nil
        case .setBindingWeChatUserLogin(let openid,let unionid,let nickname,let province,let city,let country,let headimgurl,let phone,let phoneCode):
            return nil
//        default:
//            return ["Content-type": "application/json"]
        }
    }
}

