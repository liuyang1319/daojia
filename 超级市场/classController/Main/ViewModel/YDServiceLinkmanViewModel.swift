//
//  YDServiceLinkmanViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/29.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDServiceLinkmanViewModel: NSObject {
    var serviceLinkmanModel:YDServiceLinkmanModel?
    var serviceSiteInfoModel:YDServiceSiteInfoModel?
    var serviceHelpInfoModel:[YDServiceHelpInfoModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        return self.serviceHelpInfoModel?.count ?? 0
        
    }
}
extension YDServiceLinkmanViewModel {
    func refreshServiceLinkmanList(supplierId:String,token:String,memberPhone:String)  {
        YDShopGoodsListProvider.request(.getMeServerLinkmanList(supplierId:	supplierId, token: token, memberPhone: memberPhone)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        print("---------------%@",json)
                        if let mappedObject = JSONDeserializer<YDServiceLinkmanModel>.deserializeFrom(json: json["data"].description) {
                            self.serviceLinkmanModel = mappedObject
                            self.serviceSiteInfoModel = mappedObject.siteInfo
                            self.serviceHelpInfoModel = mappedObject.helpInfo
                            self.updateDataBlock?()
                        }
                    }
                }
                }
            }
        }
    }
}
