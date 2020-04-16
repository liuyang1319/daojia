//
//  YDHomeGoodsInfo.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/30.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON
struct YDHomeGoodListModel: HandyJSON {
    var remarks:String?
    var postionName:String?
    var list:[YDHomeAllGoodListModel]?
}
//
struct YDHomeAllGoodListModel: HandyJSON {
    var salePrice:Double?
    var name:String?
    var activityImage:String?
    var formalPrice:Double?
    var goodsImg:String?
    var sort:String?
    var url:String?
    var tr:String?
    var specialremarks:String?
    var positionId:String?
    var activityName:String?
    var goodsTitle:String?
    var goodsName:String?
    var goodsId:String?
    var goodsCode:String?
    var categoryId:String?
    var unitName:String?
    var weight:String?
}
struct YDHomeYouLikeListModel: HandyJSON {
    var memberId:String?
    var goodsWeight:String?
    var creatAt:String?
    var goodsId:String?
    var salePrice:Double?
    var goodsImg:String?
    var goodsName:String?
    var deviceNumber:String?
    var goodsTitle:String?
    var goodsCode:String?
    var formalPrice:Double?
    var id:String?
    var unitName:String?
}
struct YDGoodsCategoryListModel: HandyJSON {
    var id:String?
    var name:String?
    var weight:String?
    var imageUrl:String?
    var salePrice:Double?
    var formalPrice:Double?
    var code:String?
    var saleNums:String?
    var supplierId:String?
    var title:String?
    var unitName:String?
}
