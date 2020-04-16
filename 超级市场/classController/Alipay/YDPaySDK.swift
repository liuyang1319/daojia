//
//  YDPaySDK.swift
//  超级市场
//
//  Created by 王林峰 on 2019/11/6.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

public protocol PayRequestDelegate {
    func wechatPaySign(data: NSDictionary) -> Void
    func alipayPaySign(str: String) -> Void
    func payRequestSuccess(data: Any) -> Void
    func payRequestError(error: String) -> Void
}

public protocol AuthRequestDelegate {
    func authRequestSuccess(code: String) -> Void
    func authRequestError(error: String) -> Void
}
class YDPaySDK: NSObject {
    public static let instance: YDPaySDK = YDPaySDK()
    public var signUrl: String? = nil
    public static var alipayAppid: String? = nil
    
    public var authDelegate: AuthRequestDelegate?
    public var payDelegate: PayRequestDelegate?
}
