//
//  SendCodeBtn.swift
//  WLAPSwift
//
//  Created by 玉犀科技 on 2018/5/16.
//  Copyright © 2018年 谭徐杨. All rights reserved.
//

import UIKit

class SendCodeBtn: UIButton {
    
    var time: Timer?
    var count: Int?
    let textColor: UIColor = .white
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.setTitle("获取验证码", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.backgroundColor = .clear
        self.setTitleColor(textColor, for: .normal)
    }
    
    func timeFailBeginFrom(_ timeCount: Int) {
        count = timeCount
        self.isEnabled = false
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo:nil, repeats: true)
    }
    
   @objc private func timerFired() {
        if count != 1 {
            count? -= 1
            self.isEnabled = false
            self.setTitle("\(count!)", for: .normal)
            self.setTitleColor(textColor, for: .normal)
        } else {
            self.isEnabled = true
            self.setTitle("重新获取", for: .normal)
            self.setTitleColor(textColor, for: .normal)
            self.time?.invalidate()
            self.time = nil
        }
    }
    
    

    
    
    

}
