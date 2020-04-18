//
//  String+Match.swift
//  超级市场
//
//  Created by mac on 2020/4/17.
//  Copyright © 2020 王林峰. All rights reserved.
//

import Foundation

extension String {
    /// 匹配
    ///
    /// - Parameter rules: 规则
    /// - Returns: 是否匹配
    func isMatch(_ rules: String ) -> Bool {
        let rules = NSPredicate(format: "SELF MATCHES %@", rules)
        let isMatch: Bool = rules.evaluate(with: self)
        return isMatch
    }
    /// 正则匹配手机号
    var isMobile: Bool {
        /**
         * 手机号码
         * 移动：134 135 136 137 138 139 147 148 150 151 152 157 158 159  165 172 178 182 183 184 187 188 198
         * 联通：130 131 132 145 146 155 156 166 171 175 176 185 186
         * 电信：133 149 153 173 174 177 180 181 189 199
         * 虚拟：170
         */
        return isMatch("^(1[3-9])\\d{9}$")
    }
    
    /// 正则匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        return isMatch("(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)")
    }
    
    /// 正则匹配用户密码6-18位数字和字母组合
    var isPassword: Bool {
        return isMatch("^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}")
    }
    
    /// 正则匹配URL
    var isURL: Bool {
        return isMatch("^[0-9A-Za-z]{1,50}")
    }
    
    /// 正则匹配用户姓名,20位的中文或英文
    var isUserName: Bool {
        return isMatch("^[0-9a-zA-Z\\u4E00-\\u9FA5]{1,6}")
    }
    
    /// 正则匹配用户email
    var isEmail: Bool {
        return isMatch("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    /// 判断是否都是数字
    var isNumber: Bool {
        return isMatch("^[0-9]*$")
    }
    
    /// 只能输入由26个英文字母组成的字符串
    var isLetter: Bool {
        return isMatch("^[A-Za-z]+$")
    }
}
