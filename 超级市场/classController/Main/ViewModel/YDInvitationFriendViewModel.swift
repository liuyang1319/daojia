//
//  YDInvitationFriendViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class YDInvitationFriendViewModel: NSObject {
    var inviteLinkmanModel:YDInvitePresentLinkmanModel?
    var inviteLogModel:[YDInviteLoglistInfoModel]?
    var inviteLogsModel:[YDInviteLogsSucceedInfoModel]?
    var inviteHeaderInfoModel:YDInvitePresentInfoModel?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
//    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
//
//        return self.serviceHelpInfoModel?.count ?? 0
//
//    }
}
extension YDInvitationFriendViewModel {
    func refreshInvitationFriendList(token:String,memberPhone:String)  {
        YDShopGoodsListProvider.request(.getInvitationFriendActionList(token: token, memberPhone: memberPhone)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if json["success"] == true{
                    if json["data"].isEmpty != true{
                        print("---------------%@",json)
                        if let mappedObject = JSONDeserializer<YDInvitePresentLinkmanModel>.deserializeFrom(json: json["data"].description) {
                            self.inviteLinkmanModel = mappedObject
                            self.inviteHeaderInfoModel = mappedObject.inviteInfo
                            self.inviteLogModel = mappedObject.inviteLog
                            self.inviteLogsModel = mappedObject.inviteLogs
                            self.updateDataBlock?()
                        }
                    }
                }
                }
            }
        }
    }
}

