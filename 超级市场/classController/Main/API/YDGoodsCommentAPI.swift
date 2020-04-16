//
//  YDGoodsCommentAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/25.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 我的商品订单信息
let YDGoodsCommentProvider = MoyaProvider<YDGoodsCommentAPI>()

enum YDGoodsCommentAPI {
    //     商品评论
    case getOrderGoodsCommentDetailsInfo(orderNum:String,level:String,able:String,estimateList:AnyObject,token:String,memberPhone:String)
  
}
extension YDGoodsCommentAPI: TargetType {
    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getOrderGoodsCommentDetailsInfo:return "/order/addestimate"
        }
    }
    
    var method: Moya.Method {
        
        return .post
        
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getOrderGoodsCommentDetailsInfo(let orderNum,let level,let able,let estimateList,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["level"] = level
            parmeters["able"] = able
            parmeters["estimateList"] = estimateList
        }
         let gooDsArr = dataTypeTurnJson(element: parmeters as AnyObject)
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters:parmeters, encoding: JSONEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)!}
    var headers: [String : String]? {
        switch self {
        case .getOrderGoodsCommentDetailsInfo(let orderNum,let level,let able,let estimateList,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String,"Content-Type":"application/json"]
        }
    }
}
