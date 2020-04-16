//
//  YDShopGoodsListAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
/// 我的商品订单信息
let YDShopGoodsListProvider = MoyaProvider<YDShopGoodsListAPI>()

enum YDShopGoodsListAPI {
    // 
    case getHomeSearchHotsInfo(deviceNumber:String)
//    优惠劵
    case getMainCouponGoodsListInfo(status:String,token:String,memberPhone:String)
//       积分查询
    case getMainIntegralListName(status:String,token:String,memberPhone:String)
//     商品评论
    case getOrderGoodsCommentDetailsInfo(orderNum:String,level:String,able:String,estimateList:AnyObject,token:String,memberPhone:String)
//      再次购买
    case getOrderBuyAgainCartGoodsLikeList(orderNum:String,deviceNumber:String,token:String,memberPhone:String)
    
//    评价标签查询
    case getOrderGoodsCommentLabelList(orderNum:String,level:String,token:String,memberPhone:String)
//    申请退款
    case getOrderGoodsPayRefundList(orderNum:String,problemId:Int,token:String,memberPhone:String)
//    申请退款详情查看
    case getOrderGoodsPayLookRefundListInfo(orderNum:String,token:String,memberPhone:String)
//   多个商品申请退款提交
    case setsubmitApplicationRefundGoodsLiset(orderNum:String,problemId: Int,goodsCode:String,refundImg:String,refundAble:String,refundPrice:Double,token:String,memberPhone:String)
//    客服
    case getMeServerLinkmanList(supplierId:String,token:String,memberPhone:String)
//    邀请有礼
    case getInvitationFriendActionList(token:String,memberPhone:String)
//  招募员工
    case getRecruitPersonneCityList(name:String,phone:String,city:String,token:String,memberPhone:String)
}
extension YDShopGoodsListAPI: TargetType {
    
    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getHomeSearchHotsInfo: return "/search/search"
        case .getMainCouponGoodsListInfo: return "/coupon/couponList"
        case .getMainIntegralListName:return "/integral/integralList"
        case .getOrderBuyAgainCartGoodsLikeList:return "/order/againBuy"
        case .getOrderGoodsCommentLabelList: return "/order/estimateList"
        case .getOrderGoodsCommentDetailsInfo:return "/order/addestimate"
        case .getOrderGoodsPayRefundList:return "/order/applyRefund"
        case .getOrderGoodsPayLookRefundListInfo:return "/order/refundInfo"
        case .setsubmitApplicationRefundGoodsLiset:return "/order/moreRefund"
        case .getMeServerLinkmanList:return "/help/helpInfo"
        case .getInvitationFriendActionList:return "/invite/inviteLog"
        case .getRecruitPersonneCityList:return "/join/joinUs"
        }
    }
    
    var method: Moya.Method {
        
        return .post
        
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getHomeSearchHotsInfo(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .getMainCouponGoodsListInfo(let status ,let token,let memberPhone):
            parmeters["status"] = status
        case .getMainIntegralListName(let status ,let token,let memberPhone):
            parmeters["status"] = status
        case .getOrderGoodsCommentDetailsInfo(let orderNum,let level,let able,let estimateList,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["level"] = level
            parmeters["able"] = able
            parmeters["estimateList"] = estimateList
        case .getOrderBuyAgainCartGoodsLikeList(let orderNum,let deviceNumber, let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["deviceNumber"] = deviceNumber
        case .getOrderGoodsCommentLabelList(let orderNum,let level,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["level"] = level
        case .getOrderGoodsPayRefundList(let orderNum,let problemId, _ , _ ):
            parmeters["orderNum"] = orderNum
            parmeters["problemId"] = problemId
        case .getOrderGoodsPayLookRefundListInfo(let orderNum, let token, let memberPhone):
            parmeters["orderNum"] = orderNum
        case .setsubmitApplicationRefundGoodsLiset(let orderNum, let problemId,let goodsCode,let refundImg,let refundAble,let refundPrice, _ , _ ):
            parmeters["orderNum"] = orderNum
            parmeters["problemId"] = problemId
            parmeters["goodsCode"] = goodsCode
            parmeters["refundImg"] = refundImg
            parmeters["refundAble"] = refundAble
            parmeters["refundPrice"] = refundPrice
        case .getMeServerLinkmanList(let supplierId,let token, let memberPhone):
            parmeters["supplierId"] = supplierId
        case .getInvitationFriendActionList(let token, let memberPhone): break
        case .getRecruitPersonneCityList(let name,let phone,let city,let token, let memberPhone):
            parmeters["name"] = name
            parmeters["phone"] = phone
            parmeters["city"] = city
        }
        
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)!}
    var headers: [String : String]? {
        switch self {
        case .getHomeSearchHotsInfo(let deviceNumber):
            return ["deviceNumber":deviceNumber]
        case .getMainCouponGoodsListInfo(let status,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getMainIntegralListName(let status ,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getOrderGoodsCommentDetailsInfo(let orderNum,let level,let able,let estimateList,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getOrderBuyAgainCartGoodsLikeList(let orderNum, let deviceNumber,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getOrderGoodsCommentLabelList(let orderNum,let level,let token,let memberPhone):
            return ["token":token as String,"memberPhone":memberPhone as String]
        case .getOrderGoodsPayRefundList(_ , _,let token,let memberPhone):
            return ["token":token ,"memberPhone":memberPhone]
        case .getOrderGoodsPayLookRefundListInfo(let orderNum, let token, let memberPhone):
            return ["token":token ,"memberPhone":memberPhone]
        case .setsubmitApplicationRefundGoodsLiset( _ , _ , _ , _ , _ , _ ,let token, let memberPhone):
            return ["token":token ,"memberPhone":memberPhone]
        case .getMeServerLinkmanList(let supplierId,let token, let memberPhone):
            return ["token":token ,"memberPhone":memberPhone]
        case .getInvitationFriendActionList(let token, let memberPhone):
             return ["token":token ,"memberPhone":memberPhone]
        case .getRecruitPersonneCityList(let name,let phone,let city,let token, let memberPhone):
            return ["token":token ,"memberPhone":memberPhone]
        }
    }
}
