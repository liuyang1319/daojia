//
//  YDShoppingInfoViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/2.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
class YDShoppingInfoViewModel: NSObject {
    var HomeGoodSpecsInfo:[YDHomeGoodSpecsInfo]?
    var HomeGoodsEstimateInfo:[YDHomeGoodsEstimateInfo]?
    var HomeGoodsImageInfo:[YDHomeGoodsImageInfo]?
    var HomeGoodsListInfo:YDHomeGoodsListInfo?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDShoppingInfoViewModel {
    func refreshDataSource(id:String,goodsCode:String) {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        YDHomeProvider.request(.getHomeGoodsDetailsInfo(id:id, code:goodsCode, deviceNumber: uuid ?? "")) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsImage = JSONDeserializer<YDHomeGoodsDetailsInfoModel>.deserializeFrom(json: json["data"].description) {
                    self.HomeGoodsImageInfo = goodsImage.goodsImg
                    self.HomeGoodSpecsInfo = goodsImage.goodSpecs
                    self.HomeGoodsEstimateInfo = goodsImage.goodsEstimate
                    self.HomeGoodsListInfo = goodsImage.goodsList
                }
                 self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDShoppingInfoViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.HomeGoodsEstimateInfo?.count ?? 0
    }
}
