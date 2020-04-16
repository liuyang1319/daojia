//
//  YDClassGoodsViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/16.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class YDClassGoodsViewModel: NSObject {
    var categorylistModel:[YDSearchcategorylistModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDClassGoodsViewModel {
    
    func refreshClassifyGoodsDataSource(id:String){
        YDClassifyViewProvider.request(.getSearchLookClassGoodsListInfo(id:id)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil {
                    let json = JSON(data!)
                    print("二级分类内容---------%@",json)
                    if json["success"] == true{
                        if json["data"].isEmpty != true{
                            if let mappedObject = JSONDeserializer<YDSearchcategorylistModel>.deserializeModelArrayFrom(json: json["data"]["categorylist"].description) {
                                self.categorylistModel = mappedObject as? [YDSearchcategorylistModel]
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
                                    self.categorylistModel = mappedObject as? [YDSearchcategorylistModel]
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
                        self.categorylistModel = mappedObject as? [YDSearchcategorylistModel]
                    }
                    self.updateDataBlock?()
                }
            }
        }
    }
    

}
extension YDClassGoodsViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.categorylistModel?.count ?? 0
    }
}
