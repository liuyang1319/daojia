//
//  YDSelectShopMenuView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/10/11.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSelectShopMenuView: UIView {
    private lazy var backImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back_image_menu")
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.2)
        
        self.addSubview(self.backImage)
        self.backImage.frame = CGRect(x: 15, y: LBFMNavBarHeight, width: LBFMScreenWidth-30, height: 300)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
