//
//  YDShopCartViewAPI.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
///

enum GoodsRefundReseanType: Int {
    case before = 1
    case after = 2
    case cancelOrder = 3
}

let YDShopCartViewProvider = MoyaProvider<YDShopCartViewAPI>()

enum YDShopCartViewAPI {
    // 购物车list
    case getShoppingCartListInfo(deviceNumber:String,memberId:String)
    //    分类商品
    case getClassifyGoodsListInfo(id:String)
    //    删除最近搜索
    case setHomeSearchDeleteName(deviceNumber:String)
    //    添加到购物车
    case getClassifyPlusGoodsList(supplierId:String,goodsCode:String,count:NSInteger)
    //    去结算
    case getPayGoodsOrderList(addressId:String,goodsId:String,count:String,countSum:CGFloat,supplierId:String,token:String,memberPhone:String)
    //    订单信息
    case getPayGoodsOrderListInfo(orderNum:String,token:String,memberPhone:String)
    //    去支付
    case getPayAccountGoodsOrderListInfo(orderNum:String,expectedTime:String, addressId:String,invoicePayable:String,userContent:String,couponId:String,payPrice:Double,discountPrice:Double,token:String,memberPhone:String)
    //    订单列表
    case getOrderGoodOrderList(menu:String,token:String,memberPhone:String)
    //    订单详情
    case getOrderGoodOrderListInfo(orderNum:String,token:String,memberPhone:String)
    //    取消订单
    case getOrderGoodCancelListInfo(orderNum: String,problemId:Int,token:String,memberPhone:String)
    //    删除订单
    case getOrderGoodDeleteListInfo(orderNum:String,token:String,memberPhone:String)
    //    删除购物车商品
    case getGoodsDeleteCartListInfo(id:String)
    //  支付宝支付
    case getGoodsCartListAlipaySDK(orderNum:String,body:String,countsum:Double,token:String,memberPhone:String)
    //  支付宝退款
    case getGoodsCartAlipayReimburse(orderNum:String,token:String,memberPhone:String)
    // 微信退款
    case getGoodsCartWeChatPayReimburse(orderNo:String,memberId:String,token:String,memberPhone:String)
//    预计送达时间
    case getGoodsOrderCreateTimer(orderNum:String,token:String,memberPhone:String)
    
    // 获取退款原因
    /*
     1 售前
     2 售后
     3 取消订单
     */
    case getGoodsRefundResean(type: Int,token:String,memberPhone:String)
}
extension YDShopCartViewAPI: TargetType {
    
    // 服务器地址
    public var baseURL: URL {
        
        return URL(string:urlhttp)!
    }
    
    var path: String {
        switch self {
        case .getShoppingCartListInfo: return "/shoppingCart/selctShopCart"
        case .getClassifyGoodsListInfo: return "/category/categoryGoods"
        case .setHomeSearchDeleteName: return "/search/delsearch"
        case .getClassifyPlusGoodsList:return "/shoppingCart/shoppingCart"
        case .getPayGoodsOrderList:return "/order/getOrder"
        case .getPayGoodsOrderListInfo:return "/order/selectOrder"
        case .getPayAccountGoodsOrderListInfo: return "/order/updateOrder"
        case .getOrderGoodOrderList: return "/order/orderList"
        case .getOrderGoodOrderListInfo: return "/order/getOrderDetail"
        case .getOrderGoodCancelListInfo: return "/order/cancelOrder"
        case .getOrderGoodDeleteListInfo: return "/order/delOrder"
        case .getGoodsDeleteCartListInfo:return "/shoppingCart/delShoppingCart"
        case .getGoodsCartListAlipaySDK:return "/alipay/pay"
        case .getGoodsCartAlipayReimburse:return "/alipay/refund"
        case .getGoodsCartWeChatPayReimburse:return "/wxpay/refund"
        case .getGoodsOrderCreateTimer:return "/order/payComplete"
        case .getGoodsRefundResean: return "/help/problemList"
        }
    }
    
   var method: Moya.Method {
        switch self {
        case .getGoodsRefundResean: return .get
        default:
            return .post
        }
    }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .getShoppingCartListInfo(let deviceNumber,let memberId):
            parmeters["deviceNumber"] = deviceNumber
            parmeters["memberId"] = memberId
        case .getClassifyGoodsListInfo(let id):
            parmeters["id"] = id
        case .setHomeSearchDeleteName(let deviceNumber):
            parmeters["deviceNumber"] = deviceNumber
        case .getClassifyPlusGoodsList(let supplierId,let goodsCode,let count):
            parmeters["supplierId"] = supplierId
            parmeters["goodsCode"] = goodsCode
            parmeters["count"] = count
        case .getPayGoodsOrderList(let addressId,let goodsId,let count,let countSum,let supplierId,let token, let memberPhone):
            parmeters["addressId"] = addressId
            parmeters["goodsId"] = goodsId
            parmeters["count"] = count
            parmeters["countSum"] = countSum
            parmeters["supplierId"] = supplierId
        case .getPayGoodsOrderListInfo(let orderNum,let token, let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getPayAccountGoodsOrderListInfo(let orderNum,let expectedTime,let addressId,let invoicePayable,let userContent,let couponId,let payPrice,let discountPrice,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["expectedTime"] = expectedTime
            parmeters["addressId"] = addressId
            parmeters["invoicePayable"] = invoicePayable
            parmeters["userContent"] = userContent
            parmeters["couponId"] = couponId
            parmeters["payPrice"] = payPrice
            parmeters["discountPrice"] = couponId
        case .getOrderGoodOrderList(let menu,let token,let memberPhone):
            parmeters["menu"] = menu
        case .getOrderGoodOrderListInfo(let orderNum ,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getOrderGoodCancelListInfo(let orderNum, let problemId, _ , _ ):
            parmeters["orderNum"] = orderNum
            parmeters["problemId"] = problemId
        case .getOrderGoodDeleteListInfo(let orderNum,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getOrderGoodDeleteListInfo(let orderNum,let token,let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getGoodsDeleteCartListInfo(let id):
            parmeters["id"] = id
        case .getGoodsCartListAlipaySDK(let orderNum,let body,let countsum, let token,let memberPhone):
            parmeters["orderNum"] = orderNum
            parmeters["body"] = body
            parmeters["countsum"] = countsum
        case .getGoodsCartAlipayReimburse(let orderNum, let token,let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getGoodsCartWeChatPayReimburse(let orderNo,let memberId, let token,let memberPhone):
            parmeters["orderNo"] = orderNo
            parmeters["memberId"] = memberId
        case .getGoodsOrderCreateTimer(let orderNum, let token,let memberPhone):
            parmeters["orderNum"] = orderNum
        case .getGoodsRefundResean(let type, _, _):
            parmeters["type"] = type
        }
        print("++++++++++++%@",parmeters)
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .getShoppingCartListInfo(let deviceNumber,let memberId):
            return nil
        case .getClassifyGoodsListInfo(let id):
            return nil
        case .setHomeSearchDeleteName(let deviceNumber):
            return ["deviceNumber":deviceNumber]
        case .getClassifyPlusGoodsList(let supplierId,let goodsCode,let count):
            return nil
        case .getPayGoodsOrderList( let addressId, let goodsId, let count, let countSum, let supplierId, let token, let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getPayGoodsOrderListInfo(let orderNum,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getPayAccountGoodsOrderListInfo(let orderNum,let expectedTime,let addressId,let invoicePayable,let userContent,let couponId,let payPrice,let discountPrice,let token, let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getOrderGoodOrderList(let menu,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getOrderGoodOrderListInfo(let orderNum ,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getOrderGoodCancelListInfo(_ , _ ,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getOrderGoodDeleteListInfo(let orderNum,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getGoodsDeleteCartListInfo(let id):
            return nil
        case .getGoodsCartListAlipaySDK(let orderNum,let body,let countsum,let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getGoodsCartAlipayReimburse(let orderNum, let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getGoodsCartWeChatPayReimburse(let orderNo,let memberId, let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getGoodsOrderCreateTimer(let orderNum, let token,let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        case .getGoodsRefundResean( _ ,let token, let memberPhone):
            return ["token":token,"memberPhone":memberPhone]
        }
    }
}
