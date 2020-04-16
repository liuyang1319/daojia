//
//  YDCancelCauseModel.swift
//  超级市场
//
//  Created by 云达 on 2020/4/14.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit
import HandyJSON

struct YDCancelCauseModel: HandyJSON {

    var id = 0      // 取消订单 超时固定13
    var name = ""
    var type = 0    // 问题类型 1售前 2售后 3取消订单
}
