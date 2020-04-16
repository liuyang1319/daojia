//
//  YDClassifyListModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON

struct YDClassifyListOneModel: HandyJSON {
    var id:String?
    var name:String?
}
struct YDClassifyListTwoModel: HandyJSON {
    var id:String?
    var name:String?
    var parentId:String?
    var isOpen:String?
}
//二级分类
struct YDClassfiyGoodModel: HandyJSON {
    var banners:String?
    var allMenu:[YDClassfiyTwoListModel]?
}
struct YDClassfiyTwoListModel: HandyJSON {
    var id:String?
    var name:String?
    var imageUrl:String?
}
//根据分类查分类商品
struct YDSearchcategorylistModel:  HandyJSON {
    var id:String?
    var name:String?
    var title:String?
    var imageUrl:String?
    var salePrice:Double?
    var formalPrice:Double?
    var saleNums:String?
    var weight:String?
    var code:String?
    var unitName:String?
}
//搜索商品
struct YDClassfiyGoodsListModel: HandyJSON {
    //是否已经加入购物车
    var alreadyAddShoppingCArt :Bool = false
    //商品购买的数量, 默认0
    var count: Int = 0
    //是否选中，默认没有选中的
    var selected: Bool = true
    var name:String?
    var formalPrice:Double?
    var salePrice:Double?
    var imageUrl:String?
    var code:String?
    var id:String?
    var title:String?
    var num :String?
    var saleNums:String?
}
//分类商品名称
struct YDCategoryNameModel: HandyJSON {
    var id:String?
    var name:String?
}
