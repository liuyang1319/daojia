//
//  YDHomeGoodsListViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/26.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDHomeGoodsListViewModel: NSObject {
    var homeGoodsListModel:[YDHomeGoodListModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
}
extension YDHomeGoodsListViewModel {
    func refreshDataSource() {
        YDHomeProvider.request(.getHomeCommentGoodsListPage(remarks:"homePage")) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let mappedObject = JSONDeserializer<YDHomeGoodListModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.homeGoodsListModel = mappedObject as? [YDHomeGoodListModel]
                }
                self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDHomeGoodsListViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.homeGoodsListModel?.count ?? 0
    }
//    func numberOfItemsIn(section: NSInteger) -> NSInteger {
//        return self.homeGoodsListModel?[section].list?.count ?? 0
//    }

}
