//
//  YDUnderwayRefundViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/26.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class YDUnderwayRefundViewModel: NSObject {
    var goodsPayRefundModel:YDGoodsPayRefundInfo?
    var goodsRefundModel:[YDGoodsAliRefundRecordInfoModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.goodsRefundModel?.count ?? 0
        
    }
}
extension YDUnderwayRefundViewModel {
    func refreshOrderGoodsPayLookRefundList(orderNum:String,token:String,memberPhone:String)  {
        YDShopGoodsListProvider.request(.getOrderGoodsPayLookRefundListInfo(orderNum: orderNum, token: token, memberPhone: memberPhone)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        print("---------------%@",json)
                        if let mappedObject = JSONDeserializer<YDGoodsRefundInfo>.deserializeFrom(json: json["data"].description) {
                            self.goodsPayRefundModel = mappedObject.orderInfo
                            self.goodsRefundModel = mappedObject.aliRefundRecordInfo
                            self.updateDataBlock?()
                        }
                    }
                }
                }
            }
        }
    }
}
