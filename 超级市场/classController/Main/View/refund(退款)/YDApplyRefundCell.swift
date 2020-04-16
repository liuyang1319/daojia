//
//  YDApplyRefundCell.swift
//  超级市场
//
//  Created by 云达 on 2020/4/14.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

class YDApplyRefundCell: LYSwiftXibBaseCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var space: UIView!
    
    private var model: YDCancelCauseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func isSelect(isSelect: Bool) {
        selectImg.image = UIImage.init(named: isSelect ? "selectGoodsImage" : "noSelectCartImage")
    }
    
    func setValue(model: YDCancelCauseModel) {
        self.model = model
        title.text = model.name
    }
    
    func spaceHidden(isHidden: Bool) {
        space.isHidden = isHidden
    }
    
    func isSelect(model: YDCancelCauseModel?) -> Bool {
        if model == nil {
            return false
        }
        return model!.id == self.model?.id
    }
    
    static func getHeight() -> CGFloat {
        return 40.0
    }
    
}
