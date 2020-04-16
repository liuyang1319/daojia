//
//  YDSearchView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/12.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDSearchView: UIView {
    
    fileprivate let searchLabel = UILabel()
    fileprivate var lastX: CGFloat = 0
    fileprivate var lastY: CGFloat = 35
    fileprivate var searchButtonClickCallback:((_ sender: UIButton) -> ())?
    var searchHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width - 30, height: 35)
        searchLabel.font = UIFont.systemFont(ofSize: 16)
        searchLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        addSubview(searchLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, searchTitleText: String, searchButtonTitleTexts: [String], searchButtonClickCallback:@escaping ((_ sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        searchLabel.text = searchTitleText
        
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        for i in 0..<searchButtonTitleTexts.count {
            let btn = UIButton()
            btn.setTitle(searchButtonTitleTexts[i].unicodeStr, for: UIControl.State())
            btn.setTitleColor(YMColor(r: 102, g: 102, b: 102, a: 1), for: UIControl.State())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
//            btn.layer.borderWidth = 0.5
//            btn.layer.borderColor = YMColor(r: 200, g: 200, b: 200, a: 1).cgColor
            btn.addTarget(self, action: #selector(searchButtonClick(_:)), for: UIControl.Event.touchUpInside)
            btnW = btn.titleLabel!.width + addW
            
            if frame.width - lastX > btnW {
                btn.frame = CGRect(x: lastX, y: lastY, width: btnW, height: btnH)
            } else {
                btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: btnW, height: btnH)
            }
            
            lastX = btn.frame.maxX + marginX
            lastY = btn.y
            searchHeight = btn.frame.maxY
            
            addSubview(btn)
        }
        
        self.searchButtonClickCallback = searchButtonClickCallback
    }
    
    @objc func searchButtonClick(_ sender: UIButton) {
        if searchButtonClickCallback != nil {
            searchButtonClickCallback!(sender)
        }
    }
}

