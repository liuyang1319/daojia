//
//  YDGoodCouponViewMdeol.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDGoodCouponViewMdeol: NSObject {
    var couponListModel:[YDCouponDetailGoodsModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.couponListModel?.count ?? 0
        
    }
}
extension YDGoodCouponViewMdeol {
    func refreshCouponDataSource(status:String,token:String,memberPhone:String)  {
        YDShopGoodsListProvider.request(.getMainCouponGoodsListInfo(status:status, token: token, memberPhone: memberPhone)) { result in
            if case let .success(response) = result {
                  let data = try? response.mapJSON()
                //解析数据
                if data != nil {
                    let json = JSON(data!)
                    print("---------------%@",json)
                    if let mappedObject = JSONDeserializer<YDCouponDetailGoodsModel>.deserializeModelArrayFrom(json: json["data"].description) {
                        self.couponListModel = mappedObject as? [YDCouponDetailGoodsModel]
                        self.updateDataBlock?()
                    }
                }
            }
        }
    }
}
