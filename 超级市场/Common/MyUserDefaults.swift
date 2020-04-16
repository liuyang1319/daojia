//
//  MyUserDefaults.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/12.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}
extension UserDefaults {
    // 账户信息
    struct AccountInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case addersName
            case cityName
            case latitudeStr
            case locationStr
            case age
            case addersInfo
        }
    }
    
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case token
            case phone
            case id
            case status
        }
    }
    // 地址信息
    struct adders: UserDefaultsSettable {
        enum defaultKeys: String {
            case phone
            case addressCode
            case sex
            case type
            case addressRegion
            case street
        }
    }
    // 仓储信息
    struct warehouseManagement: UserDefaultsSettable {
        enum defaultKeys: String {
            case supplierId
        }
    }
    //
    struct cartCountInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case countCart
        }
    }
    
//    引导图，版本判断
    struct localVersionInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case notFirst // 引导图
            case notPrivacy //隐私声明
            case classifyID
            case newUserGift //新用户登录有礼
        }
    }
    // 微信登录信息
      struct WeChatLoginInfo: UserDefaultsSettable {
          enum defaultKeys: String {
              case openid
              case unionid
              case nickname
              case headimgurl
              case city
              case province
              case country
          }
      }
    
}
extension UserDefaultsSettable where defaultKeys.RawValue==String {
    static func set(value: String?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
}

