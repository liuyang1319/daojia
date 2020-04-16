//
//  LYSwiftXibBaseCell.swift
//  Consult
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com.easyto.consult. All rights reserved.
//

import Foundation

class LYSwiftXibBaseCell: UITableViewCell {
    
    var isDrawLine: Bool = false    //是否画横线
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    
//    MARK: ---drawRect
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isDrawLine {
            let context: CGContext = UIGraphicsGetCurrentContext()!;
            context.setStrokeColor(UIColor.init(hex: 0xCBCBCB).cgColor);
            context.stroke(CGRect(x: 0, y: rect.height, width: rect.width, height: 0.5));
        }
        
    }
}
