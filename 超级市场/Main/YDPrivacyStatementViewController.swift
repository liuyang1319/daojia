//
//  YDPrivacyStatementViewController.swift
//  爱阅读
//
//  Created by 王林峰 on 2019/12/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import MBProgressHUD
class YDPrivacyStatementViewController: YDBasicViewController {

    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var titleLbale :UILabel = {
        let label = UILabel()
        label.text = "温馨提示"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        return label
    }()
    
    var contentLabe :UILabel = {
        let lable = UILabel()
        lable.text = "欢迎使用辉鲜到家App!辉鲜到家非常重视用户的隐私保护和个人信息保护。在您使用辉鲜到家App前请认真阅读"
        lable.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        lable.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }()
    var content1Labe :UILabel = {
        let lable = UILabel()
        lable.text = "《辉鲜到家隐私政策》全部条款，您同意并授权全部条款后可开始使用我们的服务"
        lable.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        lable.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        lable.numberOfLines = 0
        // 富文本
        let attributeString = NSMutableAttributedString.init(string:lable.text ?? "")
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular) , range: NSRange.init(location: 0, length:10))
        //设置富文本字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: YMColor(r: 77, g: 195, b: 45, a: 1), range: NSMakeRange(0, 10))
        //设置文字背景颜色
        lable.attributedText = attributeString
        return lable
    }()
    
    private lazy var privateBtn : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectAgreePrivateButtonClick), for: UIControl.Event.touchUpInside)

        return button
    }()
    
    
    var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    var lineLabel1 : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    var agreeNBtn : UIButton = {
        let button = UIButton()
        button.setTitle("不同意", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 204, g: 204, b: 204, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(selectNotAgreePrivacy), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    var agreeBtn : UIButton = {
        let button = UIButton()
        button.setTitle("同意", for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
          button.addTarget(self, action: #selector(selectMyAgreePrivacy), for: UIControl.Event.touchUpInside)
        return button
    }()
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//         self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.modalPresentationStyle = .custom
        self.view.addSubview(self.backView)
        if isIphoneX == true {
            self.backView.frame = CGRect(x: 30, y: 264, width: (LBFMScreenWidth-60), height: 210)
        }else{
            self.backView.frame = CGRect(x: 30, y: 230, width: (LBFMScreenWidth-60), height: 210)
        }
        
        self.backView.addSubview(self.titleLbale)
        self.titleLbale.frame = CGRect(x: 0, y: 20, width:LBFMScreenWidth-60, height: 20)
        
        self.backView.addSubview(self.contentLabe)
        self.contentLabe.frame = CGRect(x: 25, y: self.titleLbale.frame.maxY+10, width:LBFMScreenWidth - 110 , height: 55)
        self.backView.addSubview(self.content1Labe)
        self.content1Labe.frame = CGRect(x: 25, y: self.contentLabe.frame.maxY, width: LBFMScreenWidth - 110, height: 35)
        
        self.backView.addSubview(self.privateBtn)
        self.privateBtn.frame = CGRect(x: 25, y: self.contentLabe.frame.maxY, width: 145, height: 20)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.content1Labe.frame.maxY+20, width: LBFMScreenWidth - 60, height: 1)
        
        self.backView.addSubview(self.lineLabel1)
        self.lineLabel1.frame = CGRect(x: (LBFMScreenWidth - 60)*0.5, y: self.lineLabel.frame.maxY, width: 1, height: 47)
        
        
        self.backView.addSubview(self.agreeNBtn)
        self.agreeNBtn.frame = CGRect(x: 0, y: self.lineLabel.frame.maxY+5, width: (LBFMScreenWidth - 60)*0.5, height: 40)
        
        
        self.backView.addSubview(self.agreeBtn)
        self.agreeBtn.frame = CGRect(x: (LBFMScreenWidth - 60)*0.5, y: self.lineLabel.frame.maxY+5, width: (LBFMScreenWidth - 60)*0.5, height: 40)
        
        
        
    }
//    不同意
    @objc func selectNotAgreePrivacy(){
        //只显示文字
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = "点击“同意”后方可使用本软件"
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
        return
        
    }
//    同意
    @objc func selectMyAgreePrivacy(){
        UserDefaults.localVersionInfo.set(value:"YES", forKey:.notPrivacy)
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("YDPrivacyStatementViewController"), object:nil)
    }
//    查看协议
    @objc func selectAgreePrivateButtonClick(){
        let lookPrive = YDPrivacyLookUrlViewController()
        if #available(iOS 13.0, *) {
            lookPrive.modalPresentationStyle = .fullScreen
        } else {
            // Fallback on earlier versions
        }
        self.present(lookPrive,animated:true,completion:nil)
    }
}
