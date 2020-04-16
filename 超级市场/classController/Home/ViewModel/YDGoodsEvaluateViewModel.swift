//
//  YDGoodsEvaluateViewModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/10.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
class YDGoodsEvaluateViewModel: NSObject {
    var imageArray = [String]()
    var labelHeight = CGFloat()
    var homeGoodsEvaluateList:[YDGoodsEvaluateList]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
    
}
extension YDGoodsEvaluateViewModel {
    func refreshDataSource(code:String) {
        YDHomeProvider.request(.getHomeCommentGoodsList(code:code)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data != nil{
                let json = JSON(data!)
                print("---------------%@",json)
                if let goodsImage = JSONDeserializer<YDGoodsEvaluateList>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.homeGoodsEvaluateList = goodsImage as? [YDGoodsEvaluateList]
                }
                 self.updateDataBlock?()
            }
            }
        }
    }
}
extension YDGoodsEvaluateViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.homeGoodsEvaluateList?.count ?? 0
    }
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let mdeol =  self.homeGoodsEvaluateList?[indexPath.row]
        let textHeight:CGFloat = heightForView(text: mdeol?.content ?? "", font: UIFont.systemFont(ofSize: 12), width: LBFMScreenWidth-75)
        if mdeol?.able?.isEmpty != true {
            labelHeight = 30
        }else{
            labelHeight = 0
        }
        self.imageArray.removeAll()
        if mdeol?.imageUrl?.isEmpty != nil {
            self.imageArray = (mdeol?.imageUrl?.components(separatedBy:","))!
            if self.imageArray.count <= 3 {
             return 190 + textHeight + labelHeight
            }else {
                 return 295 + textHeight + labelHeight
            }
        }else{
            return 80 + textHeight + labelHeight
        }
    }
}
