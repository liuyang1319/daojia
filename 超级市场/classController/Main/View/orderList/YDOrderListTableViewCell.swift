//
//  YDOrderListTableViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/8.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDOrderListTableViewCellDelegate:NSObjectProtocol {
//    评论的积分
    func reconfirmGoodsCommentTableViewCell(commentBtn:UIButton)
//    再次购买
    func reconfirmGoodsBuyAgainTableViewCell(buyAgain:UIButton)
//    去支付
    func reconfirmGoodsoPayMentTableViewCell(payBtn:UIButton)
//    申请退款
    func reconfirmGoodsPayReimburseTableViewCell(Reimburse:UIButton)
//    取消订单
    func reconfirmGoodsPayCancelTableViewCell(cancel:UIButton)
}
class YDOrderListTableViewCell: UITableViewCell {
    
    let countDownTimer = WMCountDown()
    weak var delegate:YDOrderListTableViewCellDelegate?
    
    var goodsCount = Int()
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    // 头像
    lazy var iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "goodsIcon")
        return imageView
    }()
    // 昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.text = ""
        return label
    }()
    // 状态
    lazy var stateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight:UIFont.Weight.regular)
        label.textColor = YMColor(r: 244, g: 140, b: 43, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
        return label
    }()

//    商品
    lazy var shopImage:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var shopImage1:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var shopImage2:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var shopImage3:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 数量
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "11"
        return label
    }()
    
    // 总额
    lazy var countSum : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13 , weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    lazy var sumLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13 , weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    // 分割线
    lazy var line1Label : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    
    lazy  var commentButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsCommentButtonClick(commentBtn:)), for: UIControl.Event.touchUpInside)
        
        button.setTitle("评价得好礼", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named:"evaluate_back_image"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 288, g: 27, b: 42, a: 1), for: UIControl.State.normal)
        return button
    }()
    lazy  var buyAgainButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsBuyAgainButtonClick(selectBtn:)), for: UIControl.Event.touchUpInside)
        button.setTitle("再来一单", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "buyAgainImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        return button
    }()

    lazy  var cancelButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsCancelButtonClick(cancelBtn:)), for: UIControl.Event.touchUpInside)
        button.setTitle("取消订单", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "buyAgainImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        return button
    }()
    lazy  var payButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsOrderPayButtonClick(payBtn:)), for: UIControl.Event.touchUpInside)
        button.setTitle("立即支付", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "buyAgainImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 77, g: 195, b: 45, a: 1), for: UIControl.State.normal)
        return button
    }()
    lazy  var payReimburse : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        button.addTarget(self, action: #selector(reconfirmGoodsPayReimburseButtonClick(Reimburse:)), for: UIControl.Event.touchUpInside)
        button.setTitle("申请退款", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "deletButtonImage"), for: UIControl.State.normal)
        button.setTitleColor(YMColor(r: 51, g: 51, b: 51, a: 1), for: UIControl.State.normal)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        
    }
    func setUpLayout(){
        self.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x:15, y: 5, width: LBFMScreenWidth-30, height: 265)
        
        self.backView.addSubview(self.iconImage)
        self.iconImage.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
        
        self.backView.addSubview(self.nameLabel)
        self.nameLabel.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 20, width: 100, height: 25)
        
        self.backView.addSubview(self.stateLabel)
        self.stateLabel.frame = CGRect(x: LBFMScreenWidth-145, y: 15, width:100, height: 20)
    
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 15, y: self.iconImage.frame.maxY+10, width: LBFMScreenWidth-60, height: 1)

        self.shopImage.frame = CGRect(x:15, y: self.iconImage.frame.maxY+25, width: 70, height: 70)
        self.backView.addSubview(self.shopImage)
        
        self.shopImage1.frame = CGRect(x:self.shopImage.frame.maxX+15, y: self.iconImage.frame.maxY+25, width: 70, height: 70)
        self.backView.addSubview(self.shopImage1)
        
        self.shopImage2.frame = CGRect(x:self.shopImage1.frame.maxX+15, y: self.iconImage.frame.maxY+25, width: 70, height: 70)
        self.backView.addSubview(self.shopImage2)
        
        self.shopImage3.frame = CGRect(x:self.shopImage2.frame.maxX+15, y: self.iconImage.frame.maxY+25, width: 70, height: 70)
        self.backView.addSubview(self.shopImage3)
        
        self.backView.addSubview(self.sumLabel)
      
     
        self.backView.addSubview(self.countSum)
        
      
        self.backView.addSubview(self.line1Label)
        self.line1Label.frame = CGRect(x: 15, y: self.shopImage1.frame.maxY+65, width: LBFMScreenWidth-60, height: 1)
        self.backView.addSubview(self.buyAgainButton)
        self.backView.addSubview(self.payButton)
        self.backView.addSubview(self.commentButton)
//        self.backView.addSubview(self.serviceButton)
        self.backView.addSubview(self.payReimburse)
        self.backView.addSubview(self.cancelButton)
    }
    deinit {
        countDownTimer.stop()
    }
    var orderGoodsListModel:[YDOrderGoodsListModel]? {
        didSet {
            guard let model = orderGoodsListModel else {return}
            let modelShop = model[0]
            self.iconImage.kf.setImage(with: URL(string: modelShop.supplierImg ?? ""))
            self.nameLabel.text = "\(modelShop.supplierName ?? "")"
        
            self.shopImage.image = UIImage(named: "")
            self.shopImage1.image = UIImage(named: "")
            self.shopImage2.image = UIImage(named: "")
            self.shopImage3.image = UIImage(named: "")
            if model.count == 1{
                self.shopImage.kf.setImage(with: URL(string:model[0].imageUrl ?? ""))
            }else if model.count == 2{
                self.shopImage.kf.setImage(with: URL(string:model[0].imageUrl ?? ""))
                self.shopImage1.kf.setImage(with: URL(string:model[1].imageUrl ?? ""))
          
            }else if model.count == 3{
                self.shopImage.kf.setImage(with: URL(string:model[0].imageUrl ?? ""))
                self.shopImage1.kf.setImage(with: URL(string:model[1].imageUrl ?? ""))
                self.shopImage2.kf.setImage(with: URL(string:model[2].imageUrl ?? ""))
            }else if model.count >= 4{
                self.shopImage.kf.setImage(with: URL(string:model[0].imageUrl ?? ""))
                self.shopImage1.kf.setImage(with: URL(string:model[1].imageUrl ?? ""))
                self.shopImage2.kf.setImage(with: URL(string:model[2].imageUrl ?? ""))
                self.shopImage3.kf.setImage(with: URL(string:model[3].imageUrl ?? ""))
            }
            goodsCount = 0
            for goodsModel in model {
                goodsCount += Int(goodsModel.count ?? "") ?? 0
            }
            self.countSum.text = String(format: "共%d件", goodsCount)
            self.sumLabel.text = String(format: "应付:¥%.2f", modelShop.countsum ?? 0)
            let width = widthForView(text:self.sumLabel.text ?? "", font: UIFont.systemFont(ofSize: 13), height: 20)
            self.sumLabel.frame = CGRect(x: LBFMScreenWidth-width-40, y: self.shopImage.frame.maxY+25, width:width, height: 20)
            let countWidth = widthForView(text:self.countSum.text ?? "", font: UIFont.systemFont(ofSize: 13), height: 20)
            
            self.countSum.frame = CGRect(x:LBFMScreenWidth-width-countWidth-50, y: self.shopImage.frame.maxY+25, width: countWidth, height: 20)

            
            if modelShop.status == "1" {
                self.stateLabel.text = "待支付"
                self.payButton.isHidden = false
                self.cancelButton.isHidden = false
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = true
                self.payReimburse.isHidden = true
                
                countDownTimer.countDown = { [weak self] (m, s) in
                    let time = m + ":" + s
//                    self?.textLabel?.text = time
//                    self.payButton.set
                    self!.payButton.setTitle("立即支付:\(time)", for: UIControl.State.normal)
//                    print("时间是：\(m):\(s)")
                }

                let date = Date()
                let timeFormatter = DateFormatter()
                //日期显示格式，可按自己需求显示
                timeFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
                let strNowTime = timeFormatter.string(from: date) as String
                
                let timer = modelShop.creatAt?.prefix(19)
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = dateFormatter.date(from:String(timer!))!
                
                let interval = date.timeIntervalSince(date1)
                let second = 1800 - Int(round(interval))
                print("------------%d",interval)
                let nowLater = Date.init(timeIntervalSinceNow:TimeInterval(Int(second)))// 比GMT时间晚1分钟
                let endTimer = timeFormatter.string(from: nowLater) as String
                countDownTimer.start(with:strNowTime, end: endTimer)

                
                self.cancelButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.payButton.frame = CGRect(x: LBFMScreenWidth - 240, y: self.line1Label.frame.maxY+15, width: 100, height: 25)

            }else if modelShop.status == "2"{
                self.stateLabel.text = "支付成功"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = false
                self.payReimburse.setTitle("申请退款", for: UIControl.State.normal)
                self.payReimburse.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)

            }else if modelShop.status == "5"{
                self.stateLabel.text = "配送中"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = true
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "6"{
                self.stateLabel.text = "配送完成"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = false
                self.payReimburse.setTitle("申请退款", for: UIControl.State.normal)
                self.payReimburse.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            } else if modelShop.status == "7"{
                self.stateLabel.text = "待评价"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = true
                self.commentButton.isHidden = false
                self.commentButton.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                 self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "8"{
                self.stateLabel.text = "已取消"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = true
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "9"{
                self.stateLabel.text = "评价完成"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = true
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "10"{
                self.stateLabel.text = "退款中"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = false
                self.payReimburse.setTitle("查看退款", for: UIControl.State.normal)
                self.payReimburse.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "11"{
                self.stateLabel.text = "退款成功"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = false
                self.payReimburse.setTitle("查看退款", for: UIControl.State.normal)
                self.payReimburse.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }else if modelShop.status == "12"{
                self.stateLabel.text = "退款失败"
                self.payButton.isHidden = true
                self.cancelButton.isHidden = true
                self.commentButton.isHidden = true
                self.buyAgainButton.isHidden = false
                self.payReimburse.isHidden = false
                self.payReimburse.setTitle("查看退款", for: UIControl.State.normal)
                self.payReimburse.frame = CGRect(x: LBFMScreenWidth - 225, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
                self.buyAgainButton.frame = CGRect(x: LBFMScreenWidth - 130, y: self.line1Label.frame.maxY+15, width: 85, height: 25)
            }
        }
    }
//  去评论
    @objc func reconfirmGoodsCommentButtonClick(commentBtn:UIButton){
        delegate?.reconfirmGoodsCommentTableViewCell(commentBtn:commentBtn)
    }
    //  再次购买
    @objc func reconfirmGoodsBuyAgainButtonClick(selectBtn:UIButton){
        delegate?.reconfirmGoodsBuyAgainTableViewCell(buyAgain:selectBtn)
    }
    //  立即支付
    @objc func reconfirmGoodsOrderPayButtonClick(payBtn:UIButton){
        delegate?.reconfirmGoodsoPayMentTableViewCell(payBtn:payBtn)
    }

    //  取消
    @objc func reconfirmGoodsCancelButtonClick(cancelBtn:UIButton){
        delegate?.reconfirmGoodsPayCancelTableViewCell(cancel:cancelBtn)
    }
//  申请退款
    @objc func reconfirmGoodsPayReimburseButtonClick(Reimburse:UIButton){
        delegate?.reconfirmGoodsPayReimburseTableViewCell(Reimburse:Reimburse)
    }
}
extension YDOrderListTableViewCell {
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
}
