//
//  YDClassAllGoodsViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/17.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class YDClassAllGoodsViewModel: NSObject {
    var categoryAllListModel:[YDSearchcategorylistModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDClassAllGoodsViewModel {
    
    func refreshClassifyGoodsDataSource(id:String,sort:String){
        YDClassifyViewProvider.request(.getSearchClassLookAllGoodsListSortInfo(id:id,sort:sort)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil {
                    let json = JSON(data!)
                    print("分类全部内容---------%@",json)
                    if json["success"] == true{
                        if json["data"].isEmpty != true{
                            if let mappedObject = JSONDeserializer<YDSearchcategorylistModel>.deserializeModelArrayFrom(json: json["data"].description) {
                                self.categoryAllListModel = mappedObject as? [YDSearchcategorylistModel]
                                self.updateDataBlock?()
                            }
                        }else{
                            self.updateDataBlock?()
                        }
                    }
                }
            }
        }
    }
    func refreshClassfiyRankGoodsDataSource(rank:String,id:String){
        YDClassifyViewProvider.request(.getClassifyRankGoodsList(id:id, sort:rank)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil {
                    let json = JSON(data!)
                        if json["success"] == true{
                            print("排序---------%@",json)
                            if json["data"].isEmpty != true{
                                if let mappedObject = JSONDeserializer<YDSearchcategorylistModel>.deserializeModelArrayFrom(json: json["data"]["categorylist"].description) {
                                    self.categoryAllListModel = mappedObject as? [YDSearchcategorylistModel]
                                    self.updateDataBlock?()
                                }
                            }else{
                                self.updateDataBlock?()
                            }
                        }
                    }
                }
            }
        }
    func refreshDataSource(name:String,sort:String,deviceNumber:String) {
        YDHomeProvider.request(.setHomeSearchDescAscSaleNums(name:name, sort: sort, deviceNumber:deviceNumber)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                    let json = JSON(data!)
                    print("---------------%@",json)
                    if let mappedObject = JSONDeserializer<YDSearchcategorylistModel>.deserializeModelArrayFrom(json: json["data"]["goodsList"].description) {
                        self.categoryAllListModel = mappedObject as? [YDSearchcategorylistModel]
                    }
                    self.updateDataBlock?()
                }
            }
        }
    }

}
extension YDClassAllGoodsViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.categoryAllListModel?.count ?? 0
    }
}
