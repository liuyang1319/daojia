//
//  YDGoShopPayHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
// 添加cell点击代理方法
protocol YDGoShopPayHeaderViewDelegate:NSObjectProtocol {
    func goEditAddersHeaderView()
    func selectTimerHeaderView(timerDate:UILabel)
}
class YDGoShopPayHeaderView: UITableViewHeaderFooterView {
   weak var delegate : YDGoShopPayHeaderViewDelegate?
    
    lazy var backImage : UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named: "header_back_image")
        return backImage
    }()
    
    lazy var backView :UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    // 昵称
    private lazy var deliveryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "配送至"
        return label
    }()
    // 地址
    private lazy var addersLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    // 联系人
    private lazy var userLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    private lazy var boultImage : UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(named: "arrowsImage")
        return iamgeView
    }()
    private lazy var addersBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goEditAddersButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    // 分割线
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()
    
    // 配送时间
    private lazy var timerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .left
        label.text = "配送时间"
        return label
    }()
    
    // 配送时间
    private lazy var timerDate : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 77, g: 195, b: 45, a: 1)
        label.textAlignment = .right
        label.text = "立即送出，大约30分钟送达"
        return label
    }()
    private lazy var selectTimerBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectTimerButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var boult1Image : UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(named: "arrowsImage")
        return iamgeView
    }()
    lazy var backView1 : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5;
        backView.clipsToBounds = true
        return backView
    }()
    lazy var shopImage : UIImageView = {
        let shop = UIImageView()
        shop.image = UIImage(named: "shop_Icon")
        return shop
    }()
    lazy var shopName : UILabel = {
        let name = UILabel()
        name.text = ""
        name.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        name.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        return name
    }()
    // 分割线
    lazy var line : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpudeatAddersValue(nofit:)), name: NSNotification.Name(rawValue:updeatAdders), object: nil)

        self.addSubview(self.backImage)
         if isIphoneX == true {
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 252)
         }else{
            self.backImage.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 232)
        }
 
        setUpLayout()
        

    }
    @objc func notificationUpudeatAddersValue(nofit:Notification) {
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 15, y: LBFMNavBarHeight+15, width: LBFMScreenWidth-30, height: 145)
        
        
        self.backView.addSubview(self.deliveryLabel)
        self.deliveryLabel.frame = CGRect(x: 15, y: 15, width: 40, height: 15)
        
        
        
        let userDefault = UserDefaults.standard
        let adders = userDefault.dictionary(forKey: "AddersDictionary") ?? nil
        if adders!.count > 0 {
            self.backView.addSubview(self.addersLabel)
            self.addersLabel.text = String(format:"%@%@",adders!["addressRegion"] as! String ,adders!["street"] as! String).unicodeStr
            self.addersLabel.frame = CGRect(x: 15, y: self.deliveryLabel.frame.maxY+10, width: LBFMScreenWidth-85, height: heightForView(text: self.addersLabel.text ?? "", font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), width: LBFMScreenWidth-85))
            
            var sex = String()
            sex = adders!["sex"] as! String
            if sex == "1"{
                self.userLabel.text = String(format:"%@  男士   %@",adders?["name"] as! CVarArg,adders?["addressPhone"] as! CVarArg).unicodeStr
            }else if sex == "2"{
                self.userLabel.text = String(format:"%@  女士   %@",adders?["name"] as! CVarArg,adders?["addressPhone"] as! CVarArg).unicodeStr
            }
            self.backView.addSubview(self.userLabel)
            self.userLabel.frame = CGRect(x: 15, y: self.addersLabel.frame.maxY+10, width: LBFMScreenWidth-85, height: 15)
            
            self.backView.addSubview(self.boultImage)
            self.boultImage.frame = CGRect(x: LBFMScreenWidth - 50, y: 45, width: 10, height: 15)
            
            
            
            self.backView.addSubview(self.lineLabel)
            self.lineLabel.frame = CGRect(x: 15, y: self.userLabel.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)
            
            self.backView.addSubview(self.addersBtn)
            self.addersBtn.frame = CGRect(x: 15, y: self.deliveryLabel.frame.maxY+10, width: LBFMScreenWidth-60, height: self.lineLabel.frame.maxY - self.addersLabel.frame.maxY)
            
            self.backView.addSubview(self.timerLabel)
            self.timerLabel.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+15, width: 80, height: 15)
            
            self.backView.addSubview(self.timerDate)
            self.timerDate.frame = CGRect(x:110, y: self.lineLabel.frame.maxY+13, width: LBFMScreenWidth-175, height: 20)
            
            self.backView.addSubview(self.boult1Image)
            self.boult1Image.frame = CGRect(x: LBFMScreenWidth-50, y: self.lineLabel.frame.maxY+13, width: 10, height: 15)
            
            self.backView.addSubview(self.selectTimerBtn)
            self.selectTimerBtn.frame = CGRect(x: 110, y: self.lineLabel.frame.maxY, width: LBFMScreenWidth-160, height: self.backView.frame.maxY - self.lineLabel.frame.maxY)
            
            
//            self.addSubview(self.backView1)
            self.backView1.frame = CGRect(x: 15, y: self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 60)
            
            self.backView1.addSubview(self.shopImage)
            self.shopImage.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
            
            self.backView1.addSubview(self.shopName)
            self.shopName.frame = CGRect(x: self.shopImage.frame.maxX + 10, y: 18, width: LBFMScreenWidth-70, height: 25)
        } else {
            self.backView.addSubview(self.addersLabel)
            self.addersLabel.text = "请选择配送地址"
            self.addersLabel.frame = CGRect(x: 15, y: self.deliveryLabel.frame.maxY+10, width: LBFMScreenWidth-85, height: heightForView(text: self.addersLabel.text ?? "", font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), width: LBFMScreenWidth-85))
            
            self.backView.addSubview(self.boultImage)
            self.boultImage.frame = CGRect(x: LBFMScreenWidth - 50, y: 45, width: 10, height: 15)
            
            self.backView.addSubview(self.lineLabel)
            self.lineLabel.frame = CGRect(x: 15, y: self.addersLabel.frame.maxY+20, width: LBFMScreenWidth-60, height: 1)
            
            self.backView.addSubview(self.addersBtn)
            self.addersBtn.frame = CGRect(x: 15, y: self.deliveryLabel.frame.maxY+10, width: LBFMScreenWidth-60, height: self.lineLabel.frame.maxY - self.addersLabel.frame.maxY)
            
            self.backView.addSubview(self.timerLabel)
            self.timerLabel.frame = CGRect(x: 15, y: self.lineLabel.frame.maxY+25, width: 80, height: 15)
            
            self.backView.addSubview(self.timerDate)
            self.timerDate.frame = CGRect(x:110, y: self.lineLabel.frame.maxY+23, width: LBFMScreenWidth-175, height: 20)
            
            self.backView.addSubview(self.boult1Image)
            self.boult1Image.frame = CGRect(x: LBFMScreenWidth-50, y: self.lineLabel.frame.maxY+23, width: 10, height: 15)
            
            self.backView.addSubview(self.selectTimerBtn)
            self.selectTimerBtn.frame = CGRect(x: 110, y: self.lineLabel.frame.maxY, width: LBFMScreenWidth-160, height: self.backView.frame.maxY - self.lineLabel.frame.maxY)
            
//            self.addSubview(self.backView1)
            self.backView1.frame = CGRect(x: 15, y: self.backView.frame.maxY+15, width: LBFMScreenWidth-30, height: 60)
            self.backView1.addSubview(self.shopImage)
            self.shopImage.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
            
            self.backView1.addSubview(self.shopName)
            self.shopName.frame = CGRect(x: self.shopImage.frame.maxX + 10, y: 18, width: LBFMScreenWidth-70, height: 25)
        }
    }
    var timerStr:Int = 0{
        didSet{
            if timerStr == 0{
                self.timerDate.text = "休息中，请选择明天的配送时间"
            }else{
                self.timerDate.text = "立即送出，大约30分钟送达"
            }
        }
    }
    var goodOrderModel:YDGoodsOrderordersModel? {
        didSet{
            guard let model = goodOrderModel else { return }
            self.shopImage.kf.setImage(with: URL(string:model.supplierImg ?? ""))
            self.shopName.text = "\(model.supplierName ?? "" )"
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //    更换地址
    @objc func goEditAddersButtonClick(){
        delegate?.goEditAddersHeaderView()
    }
    //   选择时间
    @objc func selectTimerButtonClick(){
        delegate?.selectTimerHeaderView(timerDate:timerDate)
    }
 
}
