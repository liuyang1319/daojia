//
//  YDMainHeader.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/3.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
let LBFMScreenWidth = UIScreen.main.bounds.size.width
let LBFMScreenHeight = UIScreen.main.bounds.size.height
let ScreenBounds: CGRect = UIScreen.main.bounds

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
let YDLabelColor = UIColor(red: 77/255.0, green: 195/255.0, blue: 45/255.0, alpha: 1)
/// RGBA的颜色设置
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
/// RGB的颜色设置
func YMColor(r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}
let urlhttp = "http://47.95.113.40:8081/huihui"
//let urlhttp = "http://192.168.31.22:8083"
// iphone X
let isIphoneX = LBFMScreenHeight >= 812 ? true : false
// LBFMNavBarHeight
let LBFMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// LBFMTabBarHeight
let LBFMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49


// MARK: - 搜索ViewController
public let LFBSearchViewControllerHistorySearchArray = "LFBSearchViewControllerHistorySearchArray"

// MARK: - 修改昵称
public let YDUserUpdateName = "YDUserUpdateName"
// MARK: - 购物车数量
public let YDCartSumNumber = "YDTaberCartSumNumber"
// MARK: - 详情页添加购物车动画
public let YDCartGoodsInfo = "YDTaberCartSumNumberInfo"
// MARK: - 修改收货地址
public let updeatAdders = "updeatAdders"

func isTelNumber(num:String)->Bool
{
    if num.count == 0 {
        return false
    }
    let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: num) == true {
        return true
    }else
    {
        return false
    }
}



func isUserLogin() -> Bool{
    let userId = UserDefaults.LoginInfo.string(forKey:.id) ?? ""
    if userId.isEqual("") {
        return true
    }else{
        return false
    }
}
//计算高度
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
}
//计算宽度
func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
    
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.width
}

//输入中文数字字母
func isLetterWithDigital(_ string:String) ->Bool{
    
    let numberRegex:NSPredicate=NSPredicate(format:"SELF MATCHES %@","^.*[0-9]+.*$")
    let letterRegex:NSPredicate=NSPredicate(format:"SELF MATCHES %@","^.*[A-Za-z]+.*$")
    let letRegex:NSPredicate=NSPredicate(format:"SELF MATCHES %@","^.*[\\u4E00-\\u9FA5]")
    if numberRegex.evaluate(with: string) || letterRegex.evaluate(with: string)||letRegex.evaluate(with: string){
        return true
    }else{
        return false
    }
    
}
// 只能输入中文
func isLetterWithChinese(_ string:String) ->Bool{

    let letRegex:NSPredicate=NSPredicate(format:"SELF MATCHES %@","^.*[\\u4E00-\\u9FA5]")
    let letterRegex:NSPredicate=NSPredicate(format:"SELF MATCHES %@","^.*[A-Za-z]+.*$")
    if letRegex.evaluate(with: string) || letterRegex.evaluate(with: string){
        return true
    }else{
        return false
    }
    
}
func DYStringIsEmpty(value: AnyObject?) -> Bool {
    //首先判断是否为nil
    if (nil == value) {
        //对象是nil，直接认为是空串
        return true
    }else{
        //然后是否可以转化为String
        if let myValue  = value as? String{
            //然后对String做判断
            return myValue == "" || myValue == "(null)" || 0 == myValue.count
        }else{
            //字符串都不是，直接认为是空串
            return true
        }
    }
}

//判断是否存在emoji
func stringContainsEmoji(input:String) ->Bool{
    let stringUtf8Length:NSInteger = input.lengthOfBytes(using: String.Encoding.utf8)
    if(stringUtf8Length >= 4 && (stringUtf8Length / input.count != 3))
    {
        return true
    }else{
        return false
    }
}
//JSONString转换为字典
func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
    
    
}
func calculationDateFromTimeStamp(timeStamp:String,timeInterval:TimeInterval) ->Date{
    
    //根据时间戳转化Date
    
    let interval:TimeInterval=TimeInterval.init(timeStamp)!
    
    let date = Date(timeIntervalSince1970: interval)
    
    return  date.addingTimeInterval(timeInterval)
    
}
func stringToTimeStamp(_ time: String) -> TimeInterval {
    
    let dateformatter = DateFormatter()
    
    dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
    
    let date = dateformatter.date(from: time)
    
    return (date?.timeIntervalSince1970)!
    
}
//时间比较
func compareDate(_ date1: Date, date date2: Date) -> Int {
    
    let result = date1.compare(date2)
    
    switch result {
        
    case .orderedDescending:// date1 小于 date2
        
        return 1
        
    case .orderedSame:// 相等
        
        return 0
        
    case .orderedAscending:// date1 大于 date2
        
        return -1
        
    }
    
}
func getDateFromTimeStamp(timeStamp:String) ->Date {
    
                    let interval:TimeInterval = TimeInterval.init(timeStamp)!
    
                    return Date(timeIntervalSince1970: interval)
}

//JSONString转换为数组
func getArrayFromJSONString(jsonString:String) ->NSArray{
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if array != nil {
        return array as! NSArray
    }
    return array as! NSArray
    
}

 func dataTypeTurnJson(element:AnyObject) -> String {
    
    let jsonData = try! JSONSerialization.data(withJSONObject: element, options: JSONSerialization.WritingOptions.prettyPrinted)
    let str = String(data: jsonData, encoding: String.Encoding.utf8)!
    //路径
//    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//    let filePath = path.stringByAppendingString("/data666.json")
//    try! str.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
//    print(filePath) //取件地址 点击桌面->前往->输入地址跳转取件
    
    return str
}
//时间格式化
func getNowTheTime() -> String {
    // create a date formatter
    let dateFormatter = DateFormatter()
    // setup formate string for the date formatter
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    // format the current date and time by the date formatter
    let dateStr = dateFormatter.string(from: Date())
    return dateStr
}
/// 拨打电话
func hw_callPhone(_ phone: String) {
    if phone.isEmpty {
        print("电话号码异常")
    } else {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(NSURL(string :"tel://"+phone)! as URL, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: { (tag) in })
        } else {
            UIApplication.shared.openURL(NSURL(string :"tel://"+phone)! as URL)
        }
    }
}
