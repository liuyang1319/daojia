//
//  YDEmojiString.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/22.
//  Copyright © 2020 王林峰. All rights reserved.
//

//import Foundation
extension String{

// 字符串转Unicode
    var unicodeStr:String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
/// 判断是不是Emoji
    ///
    /// - Returns: true false
    func containsEmoji()->Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x2600...0x26FF,
                 0x2700...0x27BF,
                 0xFE00...0xFE0F:
                return true
            default:
                continue
            }
        }

        return false
    }

/// 判断是不是Emoji
    ///
    /// - Returns: true false
    func hasEmoji()->Bool {

        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@",pattern)
        return pred.evaluate(with: self)
    }

///// 判断是不是九宫格
//    ///
//    /// - Returns: true false
//    func isNineKeyBoard()->Bool{
//        let other : NSString = "➋➌➍➎➏➐➑➒"
//        let len = self.length
//        for i in 0 ..< len {
//            if !(other.range(of: self).location != NSNotFound) {
//                return false
//            }
//        }
//
//        return true
//    }


    /// 然后是去除字符串中的表情
    ///
    /// - Parameter text: text
    func disable_emoji(text : NSString)->String{
        do {
            let regex = try NSRegularExpression(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: NSRegularExpression.Options.caseInsensitive)

            let modifiedString = regex.stringByReplacingMatches(in: text as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.length), withTemplate: "")

            return modifiedString
        } catch {
            print(error)
        }
        return ""
    }
}
