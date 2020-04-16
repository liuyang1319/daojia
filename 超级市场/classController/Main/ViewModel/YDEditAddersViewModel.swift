//
//  YDEditAddersViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/21.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDEditAddersViewModel: NSObject {
    var ydAdderModel:[YDAddAddersModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
//    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
//
//        return self.ydAdderModel?.count ?? 0
//
//    }
}
extension YDEditAddersViewModel {
    func refreshDataSource() {
        YDUserAddersProvider.request(.getAddressInfo(token: UserDefaults.LoginInfo.string(forKey: .token) as! String, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone) as! String)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                self.ydAdderModel?.removeAll()
                if let mappedObject = JSONDeserializer<YDAddAddersModel>.deserializeModelArrayFrom(json: json["data"].description) {
                        self.ydAdderModel = mappedObject as? [YDAddAddersModel]
                }
                 self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDEditAddersViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.ydAdderModel?.count ?? 0
    }


}
