//
//  YDClassifyLeftHeaderFooterView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/23.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDClassifyLeftHeaderFooterViewDelegate {
    func tableViewHeaderClick(_ headerView: YDClassifyLeftHeaderFooterView, sectionIndex: Int)
}
class YDClassifyLeftHeaderFooterView: UITableViewHeaderFooterView {
    var delegate : YDClassifyLeftHeaderFooterViewDelegate?
    var section : Int = 0
    lazy var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return backView
    }()
    lazy var leftLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        return label
    }()
    
    lazy var buLabel : UILabel = {
        let buLabel = UILabel()
        buLabel.backgroundColor = YDLabelColor
        return buLabel
    }()
    lazy var leftBack : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        return label
    }()
    
    lazy var backView1 : UIView = {
        let backView = UIView()
        backView.isHidden  = true
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        return backView
    }()
    
    
    lazy var calssBtn : UIButton = {
        let classBtn = UIButton()
        classBtn.addTarget(self, action: #selector(selctCalssButtonClick(classButton:)), for: UIControl.Event.touchUpInside)
        return classBtn
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
        
        self.addSubview(self.buLabel)
        self.buLabel.frame = CGRect(x: 0, y: 14.5, width: 3, height: 15)
        
        self.backView.addSubview(self.leftLabel)
        self.leftLabel.frame = CGRect(x: 10, y:12, width: 70, height: 20)
        
        self.backView.addSubview(self.calssBtn)
        self.calssBtn.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
    }
    var classifyListOneModel:YDClassifyListOneModel? {
        didSet {
            
            guard let model = classifyListOneModel else {return}
//            self.leftLabel.text = model.name
            
////            if model.isOpen == true {
//                self.backView.frame = CGRect(x: 0, y: 0, width: 90, height: 44)
//                self.backView.backgroundColor = UIColor.white
//                self.backView.layer.cornerRadius = 5
//                self.backView.clipsToBounds = true
//                self.buLabel.isHidden = false
//                leftLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
//                leftLabel.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
//            }else{
//                self.backView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
//                self.buLabel.isHidden = true
//                leftLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
//                leftLabel.textColor = YMColor(r: 103, g: 103, b: 103, a: 1)
//            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    static func headerViewWithTableView(_ tableView: UITableView) -> YDClassifyLeftHeaderFooterView {
//        let headerIdentifier = "YDClassifyLeftHeaderFooterView"
//
//        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier)
//
//        if headerView == nil {
//            headerView = YDClassifyLeftHeaderFooterView(reuseIdentifier: headerIdentifier)
//        }
//
//        return headerView as! YDClassifyLeftHeaderFooterView
//    }
//
//    选择分类
    @objc func selctCalssButtonClick(classButton:UIButton){
        delegate?.tableViewHeaderClick(self, sectionIndex:classButton.tag)
    }
    
    
    
}

