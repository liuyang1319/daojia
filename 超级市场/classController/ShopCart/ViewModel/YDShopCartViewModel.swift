//
//  YDShopCartViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON

class YDShopCartViewModel: NSObject {
    private static let instance = YDShopCartViewModel()
    
    var shopCartListModel : [YDShopCartGoodsModel]?
    var shopCartGoodsListModel : [YDShopCartGoodsListModel]?
    // Mark: -数据源更新
//    typealias AddDataBlock = () ->Void
//    var updateDataBlock:AddDataBlock?
    
    static func share() -> YDShopCartViewModel {
        return instance
    }
    
}
extension YDShopCartViewModel {
    
    func refreshClassfiyDataSource(deviceNumber:String,memberId:String) {
        YDShopCartViewProvider.request(.getShoppingCartListInfo(deviceNumber: deviceNumber, memberId: memberId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                
                if let mappedObject = JSONDeserializer<YDShopCartGoodsModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.shopCartListModel = mappedObject as? [YDShopCartGoodsModel]
                }
                    
//                for (index,value) in json["data"]{
////                    self.areaArray.append(value["regName"].string!)
//                    var nameDict = json["data"]
//                    self.shopCartGoodsListModel?.append(nameDict[index]["list"].YDShopCartGoodsListModel)
////                    self.shopCartGoodsListModel?.append(json["data"]int.[index]["list"])
//                }
//                    if let shopCartGoodsObject = JSONDeserializer<YDShopCartGoodsListModel>.deserializeModelArrayFrom(json: json["data"][0]["list"].description) {
//                        self.shopCartGoodsListModel = shopCartGoodsObject as? [YDShopCartGoodsListModel]
//                    }
               NotificationCenter.default.post(name: NSNotification.Name.init(kShopCartDataRefresh), object: nil)
//                self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDShopCartViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.shopCartListModel?.count ?? 0
    }
//     每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.shopCartGoodsListModel?[section].count ?? 0
    }
}
