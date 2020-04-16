//
//  YDUserAddersAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
/// 首页推荐主接口
let YDUserAddersProvider = MoyaProvider<YDUserAddersAPI>()
enum YDUserAddersAPI {
    // 查询地址
    case getAddressInfo(token: String,memberPhone:String)
    // 添加新地址
    case setAddNewAdderssIfo(
        name:String,
        type:String,
        isDefault:String,
        addressRegion:String,
        memberId:String,
        sex:String,
        phone:String,
        doorNumber:String,
        addressCode:String,
        longitude:String,
        latitude:String,
        street:String,
        token:String,
        memberPhone:String)
    //修改收货地址
    case setUpdateEditAdders(
        name:String,
        type:String,
        isDefault:String,
        addressRegion:String,
        addressId:String,
        sex:String,
        token:String,
        memberPhone:String,
        addressCode:String,
        longitude:String,
        latitude:String,
        phone:String,
        street:String,
        doorNumber:String)
    //    删除收获地址
    case setDeleteAdders(
        addressId:String,
        memberPhone:String,
        token:String)
    //    获取城市Code
    case getCityAddersCode(level:String, reg_code:String)
    
    //    预约时间
    case getGoodsSubscribeTimerListInfo(token:String,memberPhone:String)
}
extension YDUserAddersAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getAddressInfo: return "/address/addressInfo"
        case .setAddNewAdderssIfo: return "/address/insertAddress"
        case .setUpdateEditAdders: return "/address/updateaddress"
        case .setDeleteAdders: return "/address/delAddress"
        case .getCityAddersCode: return "/reg/list"
        case .getGoodsSubscribeTimerListInfo:return "/order/timeShow"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAddressInfo:
            return .post
        case .setAddNewAdderssIfo:
            return .post
        case .setUpdateEditAdders:
            return .post
        case .setDeleteAdders:
            return .post
        case .getCityAddersCode:
            return .get
        case .getGoodsSubscribeTimerListInfo:
            return .get
        }
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getAddressInfo(let token, let memberPhone): break

        case .setAddNewAdderssIfo(let name,
                           let type,
                           let isDefault,
                           let addressRegion,
                           let memberId,
                           let sex,
                           let phone,
                           let doorNumber,
                           let addressCode,
                           let longitude,
                           let latitude,
                           let street,
                           let token,
                           let memberPhone):
            parmeters["name"] = name
            parmeters["type"] = type
            parmeters["isDefault"] = isDefault
            parmeters["addressRegion"] = addressRegion
            parmeters["memberId"] = memberId
            parmeters["sex"] = sex
            parmeters["doorNumber"] = doorNumber
            parmeters["phone"] = phone
            parmeters["addressCode"] = addressCode
            parmeters["longitude"] = longitude
            parmeters["latitude"] = latitude
            parmeters["street"] = street
        case .setUpdateEditAdders(let name,
                                  let type,
                                  let isDefault,
                                  let addressRegion,
                                  let addressId,
                                  let sex,
                                  let token,
                                  let memberPhone,
                                  let addressCode,
                                  let longitude,
                                  let latitude,
                                  let phone,
                                  let street,
                                  let doorNumber):
            parmeters["name"] = name
            parmeters["type"] = type
            parmeters["isDefault"] = isDefault
            parmeters["addressRegion"] = addressRegion
            parmeters["addressId"] = addressId
            parmeters["sex"] = sex
            parmeters["addressCode"] = addressCode
            parmeters["longitude"] = longitude
            parmeters["latitude"] = latitude
            parmeters["phone"] = phone
            parmeters["street"] = street
            parmeters["doorNumber"] = doorNumber
        case .setDeleteAdders(let addressId, let memberPhone,let token):
            parmeters["addressId"] = addressId
        case .getCityAddersCode(let level,let reg_code):
            parmeters["level"] = level
            parmeters["reg_code"] = reg_code
        case .getGoodsSubscribeTimerListInfo(let token,let memberPhone): break
        }
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .getAddressInfo(let token, let memberPhone):
            return ["token":token as String,
                    "memberPhone":memberPhone as String
            ]
        case .setAddNewAdderssIfo(let name,
                                  let type,
                                  let isDefault,
                                  let addressRegion,
                                  let memberId,
                                  let sex,
                                  let phone,
                                  let doorNumber,
                                  let addressCode,
                                  let longitude,
                                  let latitude,
                                  let street,
                                  let token,
                                  let memberPhone):
            return [
                    "token":token as String,
                    "memberPhone":memberPhone as String]
            
        case .setUpdateEditAdders(let name,
                                  let type,
                                  let isDefault,
                                  let addressRegion,
                                  let address,
                                  let sex,
                                  let token,
                                  let memberPhone,
                                  let addressCode,
                                  let longitude,
                                  let latitude,
                                  let phone,
                                  let street,
                                  let doorNumber):
            return [
                    "token":token as String,
                    "memberPhone":memberPhone as String]
        case .setDeleteAdders(
            let addressId,
            let memberPhone,
            let token):
            return ["memberPhone": memberPhone as String,"token": token as String]
        case .getCityAddersCode(let level,let reg_code):
            return ["Content-type": "application/json"]
            
        case .getGoodsSubscribeTimerListInfo(let token,let memberPhone):
            
            return ["token":token as String,"memberPhone":memberPhone as String]
            
            //        default:
            //            return ["Content-type": "application/json"]
        }
    }
}
