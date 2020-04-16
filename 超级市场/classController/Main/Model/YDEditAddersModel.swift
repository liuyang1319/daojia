//
//  YDEditAddersModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON
struct YDAddAddersModel: HandyJSON {
    var name:String?
    var phone:String?
    var type:String?   //地址类型 1.公司 2.家  3.学校
    var addressRegion:String?
    var isDefault:String? //是否默认1.是   2.否
    var memberId:String?
    var address:String?
    var longitude:String?
    var latitude:String?
    var creatAt:String?
    var sex:String? // 1.男 2.女
    var addressId:String?
    var doorNumber:String?
    var addressCode:String?
    var street:String?
    var id:String?

}
struct YDSelectProvinceModel: HandyJSON {
    var regName:String?
    var regCode:String?
}
