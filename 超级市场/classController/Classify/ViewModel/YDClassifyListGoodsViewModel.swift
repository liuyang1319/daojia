//
//  YDClassifyListGoodsViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON

class YDClassifyListGoodsViewModel: NSObject {
    var classfiyGoodsModel :YDClassfiyGoodModel?
    var allMenuModel:[YDClassfiyTwoListModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDClassifyListGoodsViewModel {
    
    func refreshClassifyGoodsDataSource(id:String){
        YDClassifyViewProvider.request(.getClassifyGoodsListInfo(id:id)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil {
                    let json = JSON(data!)
                    print("二级分类内容---------%@",json)
                    if json["success"] == true{
                        if json["data"].isEmpty != true{
                            if let mappedObject = JSONDeserializer<YDClassfiyGoodModel>.deserializeFrom(json: json["data"].description) {
                                self.classfiyGoodsModel = mappedObject
                                self.allMenuModel = mappedObject.allMenu
                                self.updateDataBlock?()
                            }
                        }else{
                            self.updateDataBlock?()
                        }
                    }else{
                        self.allMenuModel?.removeAll()
                        self.classfiyGoodsModel?.banners = ""
                        self.updateDataBlock?()
                    }
                }
            }
        }
    }
    
//    func refreshClassfiyRankGoodsDataSource(rank:String,id:String){
//        YDClassifyViewProvider.request(.getClassifyRankGoodsList(id:id, sort:rank)) { result in
//            if case let .success(response) = result {
//                //解析数据
//                let data = try? response.mapJSON()
//                if data != nil {
//                    let json = JSON(data!)
//
//                    if json["success"] == true{
//                        if json["data"]["total"] > 0 {
//                            if let mappedObject = JSONDeserializer<YDClassfiyGoodsListModel>.deserializeModelArrayFrom(json: json["data"]["categorylist"].description) {
//                                self.classfiyListGoodsModel = mappedObject as? [YDClassfiyGoodsListModel]
//                                self.updateDataBlock?()
//                            }
//                        }else{
//                            self.classfiyListGoodsModel?.removeAll()
//                            self.updateDataBlock?()
//                        }
//                    }else{
//                        self.updateDataBlock?()
//                    }
//                }
//            }
//        }
//    }
//
    
    
    
    
}
extension YDClassifyListGoodsViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.allMenuModel?.count ?? 0
    }
}
