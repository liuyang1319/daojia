//
//  YDCancelCauseCell.swift
//  超级市场
//
//  Created by 云达 on 2020/4/14.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDCancelCauseCell: LYSwiftXibBaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var space: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setSpaceLineHidden(isHidden: Bool) {
        print("ishidden: ", isHidden)
        space.isHidden = isHidden
    }

    static func getHeight() -> CGFloat {
        return 45.0
    }
}
