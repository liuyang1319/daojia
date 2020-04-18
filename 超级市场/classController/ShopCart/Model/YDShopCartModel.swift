//
//  YDShopCartModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON

struct YDShopCartGoodsModel: HandyJSON {
    var supplierId:String?
    var supplierName:String?
    var supplierImg:String?
    var list:[YDShopCartGoodsListModel]?
}

//搜索商品
struct YDShopCartGoodsListModel: HandyJSON {
    //是否全选
    var allSelectBtn :Bool = false
    //商品购买的数量, 默认0
    var count: Int = 0
    //是否选中，默认选中的
    var selected: Bool = false
//    总价
    var priceSum:Double?
    var goodsId:String?
    var supplierName:String?
    var deviceNumber:String?
    var creatAt:String?
    var name:String?
    var id:String?
    var salePrice:Double?
    var imageUrl:String?
    var goodsCode :String?
    var memberId :String?
    var addressId :String?
    var unitName :String?
    var weight :String?
}
struct YDGoodsOrderModel: HandyJSON {
    var count:Int = 0
    var orders:YDGoodsOrderordersModel?
    var orderGood:[YDOrderGoodListModel]?
    var couponList:[YDCouponDetailGoodsModel]?
}
struct YDGoodsOrderordersModel: HandyJSON {
    var addressRegion:String?
    var street:String?
    var doorNumber:String?
    var username:String?
    var phone:String?
    var supplierName:String?
    var supplierImg:String?
    var sendPrice:Double?
    var countSum:Double?
    var invoicePayable:String?
    var userContent:String?
    var weightPrice:Double?
    var packPrice:Double?
}
struct YDOrderGoodListModel: HandyJSON {
    var goodsName:String?
    var unitName:String?
    var goodsCode:String?
    var salePrice:Float?
    var count:Int?
    var weight:String?
    var imageUrl:String?
}
struct YDOrderCouponListModel: HandyJSON {
    var goodsName:String?
    var unitName:String?
    var goodsCode:String?
    var salePrice:Float?
    var count:String?
    var weight:String?
    var imageUrl:String?
}
struct YDSelectTimerModel: HandyJSON {
    var today:[YDSelectDataTimerModel]?
    var tomorrow:[YDSelectDataTimerModel]?
}
struct YDSelectDataTimerModel: HandyJSON {
    var startTime:String?
    var endTime:String?
}

