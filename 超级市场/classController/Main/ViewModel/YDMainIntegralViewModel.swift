//
//  YDMainIntegralViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/10.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

import SwiftyJSON
import HandyJSON
class YDMainIntegralViewModel: NSObject {
    var integralListModel:YDIntegralListGoodsModel?
    var integralList:[YDIntegralGoodsModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.integralList?.count ?? 0
        
    }
}
extension YDMainIntegralViewModel {
    func refreshCouponDataSource(status:String,token:String,memberPhone:String)  {
        YDShopGoodsListProvider.request(.getMainIntegralListName(status: status, token: token, memberPhone: memberPhone)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil {
                    let json = JSON(data!)
                    print("---------------%@",json)
                    if json["success"] == true{
                        if json["data"].isEmpty != true{
                            print("---------------%@",json)
                            if let mappedObject = JSONDeserializer<YDIntegralListGoodsModel>.deserializeFrom(json: json["data"].description) {
                                self.integralListModel = mappedObject
                                self.integralList = mappedObject.integralList
                                self.updateDataBlock?()
                            }
                        }
                    }
                }
            }
        }
    }
}
