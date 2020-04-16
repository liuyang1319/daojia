//
//  Color-Extension.swift
//  PipixiaTravel
//
//  Created by yanmy on 2017/7/17.
//  Copyright © 2017年 easyto. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat , g : CGFloat, b : CGFloat) {
        self.init(
            r: r,
            g: g,
            b: b,
            a: 1.0
        );
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(
            red:    r / 255.0,
            green:  g / 255.0,
            blue:   b / 255,
            alpha:  1.0
        )
    }
    
    convenience init(hex: Int) {
        self.init(hex:      hex,
                  alpha:    1.0)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        self.init(
            r: CGFloat((hex >> 16) & 0xFF),
            g: CGFloat((hex >> 8) & 0xFF),
            b: CGFloat(hex & 0xFF),
            a: alpha
        )
    }
    
    class func darkColor() -> UIColor {
        return UIColor(r: 39, g: 38, b: 42)
    }
    
    class func normalRedColor() -> UIColor {
        return UIColor(r: 250, g: 82, b: 124)
    }
    
}
