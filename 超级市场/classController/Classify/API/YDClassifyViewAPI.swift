//
//  YDClassifyViewAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
/// 首页推荐主接口
let YDClassifyViewProvider = MoyaProvider<YDClassifyViewAPI>()

enum YDClassifyViewAPI {
    // 分类list
    case getClassifyListInfo
    //    分类商品
    case getClassifyGoodsListInfo(id:String)
//    根据分类查分类下的商品
    case getSearchLookClassGoodsListInfo(id:String)
//    分类商品排序
    case getSearchLookClassGoodsListSortInfo(id:String,sort:String)
//    根据以及分类查询分类下的所有商品
    case getSearchClassLookAllGoodsListSortInfo(id:String,sort:String)
    //    删除最近搜索
    case setHomeSearchDeleteName(deviceNumber:String)
    //    添加到购物车
    case getClassifyPlusGoodsList(supplierId:String,goodsCode:String,count:NSInteger,deviceNumber:String,memberId:String,status:NSInteger)
    case getClassifyRankGoodsList(id:String,sort:String)

    //  微信支付
    case getGoodsOrderCartWeChatPay(orderNum:String,countsum:Double,body:String,memberId:String,token:String,memberPhone:String)
}
extension YDClassifyViewAPI: TargetType {
    
    
    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getClassifyListInfo: return "category/categoryOne"
        case .getClassifyGoodsListInfo: return "/category/categoryChildren"
        case .getSearchLookClassGoodsListInfo: return "/category/categoryGoods"
        case .getSearchLookClassGoodsListSortInfo: return "/category/categoryOrderGoods"
        case .getSearchClassLookAllGoodsListSortInfo: return "/category/allCategory"
        case .setHomeSearchDeleteName: return "/search/delsearch"
        case .getClassifyPlusGoodsList:return "/shoppingCart/shoppingCart"
        case .getClassifyRankGoodsList:return "/category/categoryOrderGoods"
        case .getGoodsOrderCartWeChatPay:return "/wxpay/unifiedOrder"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getClassifyListInfo:
        return .get
        case .getClassifyGoodsListInfo:
        return .post
        case .getSearchLookClassGoodsListInfo(let id):
            return .post
        case .getSearchLookClassGoodsListSortInfo(let id,let sort):
            return .post
        case .getSearchClassLookAllGoodsListSortInfo(let id,let sort):
             return .post
        case .setHomeSearchDeleteName(let deviceNumber):
            return .post
        case .getClassifyPlusGoodsList(let supplierId,let goodsCode,let count,let deviceNumber,let memberId,let status):
            return .post
        case .getClassifyRankGoodsList(let id,let sort):
            return .post
        case .getGoodsOrderCartWeChatPay(let orderNum,let countsum,let body,let memberId, let token,let memberPhone):
            return .get
        }
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getClassifyListInfo:break
        case .getClassifyGoodsListInfo(let id):
             parmeters["id"] = id
        case .getSearchLookClassGoodsListInfo(let id):
            parmeters["id"] = id
        case .getSearchLookClassGoodsListSortInfo(let id,let sort):
            parmeters["id"] = id
            parmeters["sort"] = sort
        case .getSearchClassLookAllGoodsListSortInfo(let id,let sort):
            parmeters["id"] = id
            parmeters["sort"] = sort
        case .setHomeSearchDeleteName(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .getClassifyPlusGoodsList(let supplierId,let goodsCode,let count,let deviceNumber,let memberId,let status):
            parmeters["supplierId"] = supplierId
            parmeters["goodsCode"] = goodsCode
            parmeters["count"] = count
            parmeters["deviceNumber"] = deviceNumber
            parmeters["memberId"] = memberId
            parmeters["status"] = status
            
        case .getClassifyRankGoodsList(let id,let sort):
            parmeters["id"] = id
            parmeters["sort"] = sort
        case .getGoodsOrderCartWeChatPay(let orderNum,let countsum,let body,let memberId, let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["countsum"] = countsum
            parmeters["body"] = body
            parmeters["memberId"] = memberId
        }
        
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .getClassifyListInfo:
            return nil
        case .getClassifyGoodsListInfo(let id):
            return nil
        case .getSearchLookClassGoodsListInfo(let id):
            return nil
        case .getSearchLookClassGoodsListSortInfo(let id,let sort):
            return nil
        case .getSearchClassLookAllGoodsListSortInfo(let id,let sort):
             return nil
        case .setHomeSearchDeleteName(let deviceNumber):
            return ["deviceNumber":deviceNumber]
        case .getClassifyPlusGoodsList(let supplierId,let goodsCode,let count,let deviceNumber,let memberId,let status):
            return nil
        case .getClassifyRankGoodsList(let id,let sort):
            return nil
        case .getGoodsOrderCartWeChatPay(let orderNum,let countsum,let body, let memberId,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        }
    }
}
