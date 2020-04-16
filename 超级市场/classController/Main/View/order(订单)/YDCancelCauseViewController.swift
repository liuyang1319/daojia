//
//  YDCancelCauseViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2020/1/7.
//  Copyright © 2020 王林峰. All rights reserved.
//

import UIKit

protocol YDCancelCauseViewControllerDelegate: NSObjectProtocol {
    // 选择问题
    func selectResean(model: YDCancelCauseModel, order: YDOrderAllGoodsListModel)
}

//protocol YDCancelCauseViewControllerDelegate:NSObjectProtocol {
//    //    运费问题
//    func selectFreightButtonClickViewController(freightBtn:UIButton)
//    //    重复购买
//    func selectRepetitionButtonClickViewController(RepetitionBtn:UIButton)
//    //    收货人信息错误
//    func selectMessageErrorButtonClickViewController(messageErrorBtn:UIButton)
//    //    我不想买了
//    func selectnotBuyButtonClickViewController(notBuyBtn:UIButton)
//    //    使用优惠劵
//    func selectUseCouponButtonClickViewController(useCouponBtn:UIButton)
//    //    其他
//    func selectOtherButtonClickViewController(otherBtn:UIButton)
//    //    取消点错了
//    func selectCancelErrorButtonClickViewController()
//}

class YDCancelCauseViewController: YDBasicViewController {
    weak var delegate : YDCancelCauseViewControllerDelegate?
//    lazy var customView:UIView = {
//        let view = UIView()
//        view.backgroundColor = YMColor(r: 0, g: 0, b: 0, a: 0.1)
////        view.clipsToBounds = true
////        view.layer.cornerRadius = 10
//        return view
//    }()
    
    private let kYDCancelCauseCell = "YDCancelCauseCell"
    private let viewWidth = LBFMScreenWidth - 20
    private var dataSource: [YDCancelCauseModel] = []
    private var order: YDOrderAllGoodsListModel?
    
    lazy var tableView: UITableView = {
        let tableView = YDTableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        return tableView
    }()
    
    lazy var backView:UIView = {
        let back = UIView()
        back.backgroundColor = UIColor.white
        back.clipsToBounds = true
        back.layer.cornerRadius = 10
        return back
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.text = "订单取消原因"
        title.textAlignment = .center
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return title
    }()
    
    
    lazy var messageLabel:UILabel = {
        let title = UILabel()
        title.text = "请您慎重选择，不要错过每一单的精彩"
        title.textAlignment = .center
        title.textColor = YMColor(r: 255, g: 143, b: 48, a: 1)
        title.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return title
    }()
    
    lazy var lineLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
        return label
    }()
    
//    lazy var freightLabel:UILabel = {
//        let label = UILabel()
//        label.text = "运费问题"
//        label.textAlignment = .center
//        label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//        return label
//    }()
//
//    lazy var freightBtn:UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(selectFreightButtonClick(freightBtn:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//    lazy var lineLabel1:UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
//        return label
//    }()
//
//    lazy var repetitionLabel:UILabel = {
//        let label = UILabel()
//        label.text = "重复购买"
//        label.textAlignment = .center
//        label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//        return label
//    }()
//
//    lazy var repetitionBtn:UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(selectRepetitionButtonClick(repetitionBtn:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//    lazy var lineLabel2:UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
//        return label
//    }()
//
//    lazy var mesgErrorLabel:UILabel = {
//        let label = UILabel()
//        label.text = "收货人信息有误"
//        label.textAlignment = .center
//        label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//        return label
//    }()
//
//    lazy var mesgErrorBtn:UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(selectMessageErrorButtonClick(messageErrorBtn:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//
//    lazy var lineLabel3:UILabel = {
//        let label = UILabel()
//        label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
//        return label
//    }()
//
//    lazy var notBuyLabel:UILabel = {
//        let label = UILabel()
//        label.text = "我不想买了"
//        label.textAlignment = .center
//        label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//        return label
//    }()
//
//    lazy var notBuyBtn:UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(selectnotBuyButtonClick(notBuyBtn:)), for: UIControl.Event.touchUpInside)
//        return button
//    }()
//
//
//    lazy var lineLabel4:UILabel = {
//           let label = UILabel()
//           label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
//           return label
//       }()
//
//       lazy var useCouponLabel:UILabel = {
//           let label = UILabel()
//           label.text = "忘记使用优惠劵"
//           label.textAlignment = .center
//           label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//           label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//           return label
//       }()
//
//       lazy var useCouponBtn:UIButton = {
//           let button = UIButton()
//           button.addTarget(self, action: #selector(selectUseCouponButtonClick(useCouponBtn:)), for: UIControl.Event.touchUpInside)
//           return button
//       }()
//
//    lazy var lineLabel5:UILabel = {
//            let label = UILabel()
//            label.backgroundColor = YMColor(r: 224, g: 224, b: 224, a: 1)
//            return label
//        }()
//
//        lazy var otherLabel:UILabel = {
//            let label = UILabel()
//            label.text = "其他"
//            label.textAlignment = .center
//            label.textColor = YMColor(r: 58, g: 133, b: 213, a: 1)
//            label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
//            return label
//        }()
//
//        lazy var otherBtn:UIButton = {
//            let button = UIButton()
//            button.addTarget(self, action: #selector(selectOtherButtonClick(otherBtn:)), for: UIControl.Event.touchUpInside)
//            return button
//        }()
//

    lazy var backCancel:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
        
    lazy var cancelErrorLabel:UILabel = {
            let label = UILabel()
            label.text = "点错了，不取消订单"
            label.textAlignment = .center
            label.textColor = YMColor(r: 70, g: 130, b: 224, a: 1)
            label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
            return label
    }()
        
    lazy var cancelErrorBtn:UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(selectCancelErrorButtonClick), for: UIControl.Event.touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
//        UIView.animate(withDuration: 0.5, animations: {
//            self.view.alpha = 0
//        }) { (true) in
//              self.modalPresentationStyle = .custom
//        }
        
        self.view.addSubview(self.backView)
        self.backView.frame = CGRect(x:10, y:LBFMScreenHeight-400, width: viewWidth, height: 325)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 0, y: 10, width:viewWidth, height: 20)
        
        self.backView.addSubview(self.messageLabel)
        self.messageLabel.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY, width: viewWidth, height: 15)
        
        self.backView.addSubview(self.lineLabel)
        self.lineLabel.frame = CGRect(x: 0, y: self.messageLabel.frame.maxY+5, width: viewWidth, height: 1)
        
        tableView.regiestCellsForNibs(cellIds: [kYDCancelCauseCell])
        tableView.frame = CGRect(x: 0, y: lineLabel.frame.maxY, width: viewWidth, height: 280)
        backView.addSubview(tableView)
//        self.backView.addSubview(self.freightLabel)
//        self.freightLabel.frame = CGRect(x: 0, y: self.lineLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//        self.backView.addSubview(self.freightBtn)
//        self.freightBtn.frame = CGRect(x: 0, y: self.lineLabel.frame.maxY, width: LBFMScreenWidth-20, height: 45)
//
//        self.backView.addSubview(self.lineLabel1)
//        self.lineLabel1.frame = CGRect(x: 0, y: self.freightLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 1)
//
//        self.backView.addSubview(self.repetitionLabel)
//        self.repetitionLabel.frame = CGRect(x: 0, y: self.lineLabel1.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//        self.backView.addSubview(self.repetitionBtn)
//        self.repetitionBtn.frame = CGRect(x: 0, y: self.lineLabel1.frame.maxY, width: LBFMScreenWidth-20, height: 45)
//
//        self.backView.addSubview(self.lineLabel2)
//        self.lineLabel2.frame = CGRect(x: 0, y: self.repetitionLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 1)
//
//        self.backView.addSubview(self.mesgErrorLabel)
//        self.mesgErrorLabel.frame = CGRect(x: 0, y: self.lineLabel2.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//        self.backView.addSubview(self.mesgErrorBtn)
//        self.mesgErrorBtn.frame = CGRect(x: 0, y: self.lineLabel2.frame.maxY, width: LBFMScreenWidth-20, height: 45)
//
//        self.backView.addSubview(self.lineLabel3)
//        self.lineLabel3.frame = CGRect(x: 0, y: self.mesgErrorLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 1)
//
//        self.backView.addSubview(self.notBuyLabel)
//        self.notBuyLabel.frame = CGRect(x: 0, y: self.lineLabel3.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//        self.backView.addSubview(self.notBuyBtn)
//        self.notBuyBtn.frame = CGRect(x: 0, y: self.lineLabel3.frame.maxY, width: LBFMScreenWidth-20, height: 45)
//
//
//        self.backView.addSubview(self.lineLabel4)
//        self.lineLabel4.frame = CGRect(x: 0, y: self.notBuyLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 1)
//
//        self.backView.addSubview(self.useCouponLabel)
//        self.useCouponLabel.frame = CGRect(x: 0, y: self.lineLabel4.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//        self.backView.addSubview(self.useCouponBtn)
//        self.useCouponBtn.frame = CGRect(x: 0, y: self.lineLabel4.frame.maxY, width: LBFMScreenWidth-20, height: 45)
//
//        self.backView.addSubview(self.lineLabel5)
//         self.lineLabel5.frame = CGRect(x: 0, y: self.useCouponLabel.frame.maxY+10, width: LBFMScreenWidth-20, height: 1)
//
//         self.backView.addSubview(self.otherLabel)
//         self.otherLabel.frame = CGRect(x: 0, y: self.lineLabel5.frame.maxY+10, width: LBFMScreenWidth-20, height: 25)
//
//         self.backView.addSubview(self.otherBtn)
//         self.otherBtn.frame = CGRect(x: 0, y: self.lineLabel5.frame.maxY, width: LBFMScreenWidth-20, height: 45)

        self.view.addSubview(self.backCancel)
        self.backCancel.frame = CGRect(x:10, y: self.backView.frame.maxY + 10, width: viewWidth, height: 45)
//
        self.backCancel.addSubview(self.cancelErrorLabel)
        self.cancelErrorLabel.frame = CGRect(x: 0, y: 10, width: viewWidth, height: 25)

        self.backCancel.addSubview(self.cancelErrorBtn)
        self.cancelErrorBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 45)
       
    }
    
    func setDataSource(dataSource: [YDCancelCauseModel]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
    
    func setOrderModel(order: YDOrderAllGoodsListModel) {
        self.order = order
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
////    运费问题
//    @objc func selectFreightButtonClick(freightBtn:UIButton){
//        delegate?.selectFreightButtonClickViewController(freightBtn:freightBtn)
//    }
////    重复购买
//    @objc func selectRepetitionButtonClick(repetitionBtn:UIButton){
//        delegate?.selectRepetitionButtonClickViewController(RepetitionBtn:repetitionBtn)
//    }
////    收货人信息错误
//    @objc func selectMessageErrorButtonClick(messageErrorBtn:UIButton){
//        delegate?.selectMessageErrorButtonClickViewController(messageErrorBtn:messageErrorBtn)
//    }
////    我不想买了
//    @objc func selectnotBuyButtonClick(notBuyBtn:UIButton){
//        delegate?.selectnotBuyButtonClickViewController(notBuyBtn:notBuyBtn)
//    }
////    使用优惠劵
//    @objc func selectUseCouponButtonClick(useCouponBtn:UIButton){
//        delegate?.selectUseCouponButtonClickViewController(useCouponBtn: useCouponBtn)
//
//    }
////    其他
//    @objc func selectOtherButtonClick(otherBtn:UIButton){
//        delegate?.selectOtherButtonClickViewController(otherBtn: otherBtn)
//    }
//
//    取消点错了selectCancelErrorButtonClick
    @objc func selectCancelErrorButtonClick(){
        self.dismiss(animated: true, completion: nil)
//        delegate?.selectCancelErrorButtonClickViewController()
    }
}

extension YDCancelCauseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kYDCancelCauseCell) as! YDCancelCauseCell
        if dataSource.count > indexPath.row {
            let model = dataSource[indexPath.row]
            cell.setTitle(title: model.name)
        }
        
        cell.setSpaceLineHidden(isHidden: indexPath.row == dataSource.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YDCancelCauseCell.getHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataSource.count <= indexPath.row {
            return
        }
        
        if order == nil {
            return
        }
        
        delegate?.selectResean(model: dataSource[indexPath.row], order: order!)
        dismiss(animated: true, completion: nil)
    }
    
}
