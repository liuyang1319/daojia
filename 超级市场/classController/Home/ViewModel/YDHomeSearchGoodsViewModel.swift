//
//  YDHomeSearchGoodsViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
class YDHomeSearchGoodsViewModel: NSObject {
    var searchGoodsListModel:[YDHomeSearchGoodsListModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDHomeSearchGoodsViewModel {
    func refreshDataSource(name:String,sort:String,deviceNumber:String) {
        YDHomeProvider.request(.setHomeSearchDescAscSaleNums(name:name, sort: sort, deviceNumber:deviceNumber)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let mappedObject = JSONDeserializer<YDHomeSearchGoodsListModel>.deserializeModelArrayFrom(json: json["data"]["goodsList"].description) {
                    self.searchGoodsListModel = mappedObject as? [YDHomeSearchGoodsListModel]
                }
                self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDHomeSearchGoodsViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.searchGoodsListModel?.count ?? 0
    }
}
