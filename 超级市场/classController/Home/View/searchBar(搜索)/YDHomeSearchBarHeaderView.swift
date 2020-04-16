//
//  YDHomeSearchBarHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/12.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDHomeSearchBarHeaderView: UIView {
    var searchHeight: CGFloat = 0
    fileprivate var lastX: CGFloat = 0
    fileprivate var lastY: CGFloat = 35
    fileprivate var searchButtonClickCallback:((_ sender: UIButton) -> ())?
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = NSTextAlignment.left
        label.text = "最近搜索"
        return label
    }()
    private lazy var iconButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(removeRecordButtonClick), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor.red
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: 10, width: 70, height: 25)
        self.addSubview(self.iconButton)
        self.iconButton.frame = CGRect(x: LBFMScreenWidth-30, y: 15, width: 15, height: 15)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    删除记录
    @objc func removeRecordButtonClick(){
    
    }
   
    convenience init(frame: CGRect, searchButtonTitleTexts: [String], searchButtonClickCallback:@escaping ((_ sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        for i in 0..<searchButtonTitleTexts.count {
            let btn = UIButton()
            btn.setTitle(searchButtonTitleTexts[i], for: UIControl.State())
            btn.setTitleColor(UIColor.black, for: UIControl.State())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.white
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = YMColor(r: 200, g: 200, b: 200, a: 1).cgColor
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
