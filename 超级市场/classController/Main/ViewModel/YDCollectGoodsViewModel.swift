//
//  YDCollectGoodsViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDCollectGoodsViewModel: NSObject {
    var goodsListModel:[YDCollectGoodsListModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.goodsListModel?.count ?? 0
        
    }
}
extension YDCollectGoodsViewModel {
    func refreshCollectGoodsListDataSource(deviceNumber:String) {
        YDHomeProvider.request(.getHomeCollectionGoodsLiset(deviceNumber: deviceNumber)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                self.goodsListModel?.removeAll()
                if let mappedObject = JSONDeserializer<YDCollectGoodsListModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.goodsListModel = mappedObject as? [YDCollectGoodsListModel]
                    self.updateDataBlock?()
                }
                }
            }
        }
    }
}
extension YDCollectGoodsListModel {
//    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
//        return self.ydAdderModel?.count ?? 0
//    }


}
