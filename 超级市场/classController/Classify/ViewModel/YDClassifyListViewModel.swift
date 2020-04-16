//
//  YDClassifyListViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/27.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON

class YDClassifyListViewModel: NSObject {
    var classfiyOneListModel : [YDClassifyListOneModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDClassifyListViewModel {

    func refreshClassfiyDataSource() {
        YDClassifyViewProvider.request(.getClassifyListInfo) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let mappedObject = JSONDeserializer<YDClassifyListOneModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.classfiyOneListModel = mappedObject as? [YDClassifyListOneModel]
                    self.updateDataBlock?()
                }
                
                }
            }
        }
    }
}
extension YDClassifyListViewModel {
//    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
//        return self.classfiyOneListModel?[section].children?.count ?? 0
//    }
}
