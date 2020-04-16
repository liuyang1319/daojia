//
//  YDShopCartTool.swift
//  超级市场
//
//  Created by 云达 on 2020/4/16.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDShopCartTool: NSObject {
    private let viewModel = YDShopCartViewModel.share()
    private static let instance = YDShopCartTool()
    
    // 单例
    static func share() -> YDShopCartTool {
        return instance
    }
    
    // 返回购物车里面有几个本商品
    func inCartCount(goodsId: String) -> Int {
        let list = viewModel.shopCartListModel
        if list?.isEmpty ?? true {
            return 0
        }
        
        if goodsId.isEmpty {
            return 0
        }
        
        for shopCartList in list! {
            if shopCartList.list?.isEmpty ?? true {
                continue
            }
            
            for goods in shopCartList.list! {
                if goodsId == goods.goodsId {
                    return goods.count
                }
            }
        }
        
        return 0
    }
}
