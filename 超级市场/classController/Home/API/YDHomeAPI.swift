//
//  YDHomeAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
/// 首页推荐主接口
let YDHomeProvider = MoyaProvider<YDHomeAPI>()

enum YDHomeAPI {
    // 搜索热词查询
    case getHomeSearchHotsInfo(deviceNumber:String)
//    搜索商品关键字
    case getHomeSearchGoodsInfo(name:String,deviceNumber:String)
//    删除最近搜索
    case setHomeSearchDeleteName(deviceNumber:String)
//    商品详情
    case getHomeGoodsDetailsInfo(id:String,code:String,deviceNumber:String)
//    收藏商品
    case setHomecollectionGoodsLikeList(goodsCode:String,deviceNumber:String)
//    删除收藏
    case setHomeDeleteCollectionGoodsList(goodsCode:String,deviceNumber:String)
//    收藏列表
    case getHomeCollectionGoodsLiset(deviceNumber:String)
//   评价列表
    case getHomeCommentGoodsList(code:String)
//   首页展示数据
    case getHomeCommentGoodsListPage(remarks:String)
//   首页仓储列表
    case getHomeShopMenuListPage(latitude:Double,longitude:Double,token:NSString,memberPhone:NSString)
//    为你推荐
    case getHomeGoodsRecommendList(deviceNumber:String)
//    搜索商品排序
    case setHomeSearchDescAscSaleNums(name:String,sort:String,deviceNumber:String)
//    可选删除收藏商品
    case setMainCollectionGoodsDeleteList(goodsCode:String,deviceNumber:String)
//    专题页读取分类
    case getReadCategoryGoodsNameList(categoryId:String)
//      专题页读取分类商品读取
    case getReadCategoryGoodsActivityList(id:String)
    
}
extension YDHomeAPI: TargetType {
    
    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getHomeSearchHotsInfo: return "/search/search"
        case .getHomeSearchGoodsInfo: return "/search/searchGoods"
        case .setHomeSearchDeleteName: return "/search/delsearch"
        case .getHomeGoodsDetailsInfo: return "/goods/goodsOneInfo"
        case .setHomecollectionGoodsLikeList: return "/collect/joinCollect"
        case .setHomeDeleteCollectionGoodsList: return "/collect/delshopCollect"
        case .getHomeCollectionGoodsLiset: return "/collect/selectCollect"
        case .getHomeCommentGoodsList: return "/goods/selectEstimate"
        case .getHomeCommentGoodsListPage:return "/activity/activityInfo"
        case .getHomeShopMenuListPage:return "/activity/siteAddress"
        case .getHomeGoodsRecommendList:return "/activity/lovelyGoods"
        case .setHomeSearchDescAscSaleNums:return "/search/searchableGoods"
        case .setMainCollectionGoodsDeleteList:return "/collect/delshopCollect"
        case .getReadCategoryGoodsNameList:return "/activity/cateInfo"
        case .getReadCategoryGoodsActivityList:return "/activity/categoryGoods"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHomeSearchHotsInfo:
            return .post
        case .getHomeSearchGoodsInfo:
        return .post
        case .setHomeSearchDeleteName:
            return .post
        case .getHomeGoodsDetailsInfo:
            return .post
        case .setHomecollectionGoodsLikeList:
            return .post
        case .setHomeDeleteCollectionGoodsList:
            return .post
        case .getHomeCollectionGoodsLiset:
            return .post
        case .getHomeCommentGoodsList:
            return .post
        case .getHomeCommentGoodsListPage:
            return .post
        case .getHomeShopMenuListPage:
            return .post
        case .getHomeGoodsRecommendList:
            return .get
        case .setHomeSearchDescAscSaleNums:
            return .post
        case .setMainCollectionGoodsDeleteList:
            return .post
        case .getReadCategoryGoodsNameList:
             return .post
        case .getReadCategoryGoodsActivityList:
             return .post
        }
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getHomeSearchHotsInfo(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .getHomeSearchGoodsInfo(let name,let deviceNumber):
            parmeters["name"] = name
            parmeters["deviceNumber"] = deviceNumber
        case .setHomeSearchDeleteName(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .getHomeGoodsDetailsInfo(let id,let code,let deviceNumber):
            parmeters["id"] = id
            parmeters["code"] = code
            parmeters["deviceNumber"] = deviceNumber
        case .setHomecollectionGoodsLikeList(let goodsCode,
                                                  let deviceNumber):
            parmeters["goodsCode"] = goodsCode
            parmeters["deviceNumber"] = deviceNumber
        case .setHomeDeleteCollectionGoodsList(let goodsCode,let deviceNumber):
            parmeters["goodsCode"] = goodsCode
            parmeters["deviceNumber"] = deviceNumber
        case .getHomeCollectionGoodsLiset(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber

        case .getHomeCommentGoodsList(let code):
            parmeters["code"] = code
        case .getHomeCommentGoodsListPage(let remarks):
            parmeters["remarks"] = remarks
        case .getHomeShopMenuListPage(let latitude,let longitude,let token,let memberPhone):
            parmeters["latitude"] = latitude
            parmeters["longitude"] = longitude
        case .getHomeGoodsRecommendList(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .setHomeSearchDescAscSaleNums(let name, let sort, let deviceNumber):
             parmeters["name"] = name
             parmeters["sort"] = sort
             parmeters["deviceNumber"] = deviceNumber
        case .setMainCollectionGoodsDeleteList(let goodsCode,let deviceNumber):
             parmeters["goodsCode"] = goodsCode
            parmeters["deviceNumber"] = deviceNumber
        case .getReadCategoryGoodsNameList(let categoryId):
            parmeters["categoryId"] = categoryId
        case .getReadCategoryGoodsActivityList(let id):
            parmeters["id"] = id
            
        }
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .getHomeSearchHotsInfo(let deviceNumber):
            return ["deviceNumber":deviceNumber]
        case .getHomeSearchGoodsInfo(let name, let deviceNumber):
            return ["name": name,"deviceNumber":deviceNumber]
        case .setHomeSearchDeleteName(let deviceNumber):
            return ["deviceNumber":deviceNumber]
        case .getHomeGoodsDetailsInfo(let id,let code,let deviceNumber):
            return nil
        case .setHomecollectionGoodsLikeList(let goodsCode,let deviceNumber):
            return nil
        case .setHomeDeleteCollectionGoodsList(let goodsCode,let deviceNumber):
            return nil
        case .getHomeCollectionGoodsLiset(let deviceNumber):
            return nil
        case .getHomeCommentGoodsList(let code):
            return nil
        case .getHomeCommentGoodsListPage(let remarks):
            return nil
        case .getHomeShopMenuListPage(let latitude,let longitude,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getHomeGoodsRecommendList(let deviceNumber):
            return nil
        case .setHomeSearchDescAscSaleNums(let name, let sort, let deviceNumber):
            return nil
        case .setMainCollectionGoodsDeleteList(let goodsCode,let deviceNumber):
            return nil
        case .getReadCategoryGoodsNameList(let categoryId):
            return nil
        case .getReadCategoryGoodsActivityList(let id):
            return nil
        }
    }
}
