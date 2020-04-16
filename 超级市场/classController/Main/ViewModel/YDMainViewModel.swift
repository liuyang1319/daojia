//
//  YDMainViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/20.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDMainViewModel: NSObject {
    var orderListModel:[YDOrderAllGoodsListModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.orderListModel?.count ?? 0
        
    }
}
extension YDMainViewModel {
    func refreshDataSource(typeState:String) {
        YDShopCartViewProvider.request(.getOrderGoodOrderList(menu:typeState, token: (UserDefaults.LoginInfo.string(forKey: .token)! as NSString) as String, memberPhone: (UserDefaults.LoginInfo.string(forKey: .phone)! as NSString) as String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let mappedObject = JSONDeserializer<YDOrderAllGoodsListModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.orderListModel = mappedObject as? [YDOrderAllGoodsListModel]
                    self.updateDataBlock?()
                }
            }
            }
        }
    }
}
//extension YDEditAddersViewModel {
////    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
////        return self.ydAdderModel?.count ?? 0
////    }
//
//
//}
