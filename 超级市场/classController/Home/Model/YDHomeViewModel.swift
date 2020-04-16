//
//  YDHomeViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON
//搜索热词
struct YDHomeHotSearchModel: HandyJSON {
    var goodsList:[YDHomeHotListSearchModel]?
    var latelyList:[YDHomeNewListSearchModel]?
}
struct YDHomeHotListSearchModel: HandyJSON {
    var goodsName:String?
}
struct YDHomeNewListSearchModel: HandyJSON {
    var goodsName:String?
}
//搜索商品
struct YDHomeSearchGoodsListModel: HandyJSON {
    var name:String?
    var formalPrice:Double?
    var salePrice:Double?
    var imageUrl:String?
    var code:String?
    var id:String?
    var num :String?
    var title:String?
    var saleNums:String?
    var  unitName:String?
    var  weight:String?
    
}
//商品详情
struct YDHomeGoodsDetailsInfoModel: HandyJSON {
    var goodSpecs:[YDHomeGoodSpecsInfo]?
    var goodsEstimate:[YDHomeGoodsEstimateInfo]?
    var goodsImg:[YDHomeGoodsImageInfo]?
    var goodsList:YDHomeGoodsListInfo?
    var collectStatus:String?
    var selectEstimateCount:Int?
    var applauseRate:Double?
}
struct YDHomeGoodSpecsInfo: HandyJSON {
    var aname :String?
    var name :String?
}
struct YDHomeGoodsEstimateInfo: HandyJSON {
    var content :String?
    var headImg :String?
    var able :String?
    var name :String?
}
struct YDHomeGoodsImageInfo: HandyJSON {
    var imageUrl :String?
}
struct YDHomeGoodsListInfo: HandyJSON {
    var id :String?
    var offset :String?
    var imageUrl :String?
    var formalPrice :Double?
    var brandId :String?
    var salePrice:Double?
    var num :String?
    var code :String?
    var saleNums :String?
    var name :String?
    var sendTime :String?
    var weight :String?
    var content :String?
    var estimateCount:String?
    var praise:String?
    var unitName:String?
}
struct YDGoodsEvaluateList: HandyJSON {
    var username :String?
    var content :String?
    var headImg :String?
    var able :String?
    var imageUrl :String?
    var creatAt :String?
    var level :String?
    var cellHH:CGFloat?
}
struct YDShopMenuList: HandyJSON {
    var distance :Double?
    var siteName :String?
    var siteImg :String?
    var address :String?
    var supplierId:String?
}
