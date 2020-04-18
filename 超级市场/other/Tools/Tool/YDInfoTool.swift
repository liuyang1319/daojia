//
//  YDInfoTool.swift
//  超级市场
//
//  Created by mac on 2020/4/17.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDInfoTool: NSObject {

    static func getUUid() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static func getMemberId() -> String {
        return UserDefaults.LoginInfo.string(forKey: .id) ?? ""
    }
    
}
