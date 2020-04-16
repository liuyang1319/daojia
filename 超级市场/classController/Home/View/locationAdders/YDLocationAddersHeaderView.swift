//
//  YDLocationAddersHeaderView.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/25.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDLocationAddersHeaderViewDelegate:NSObjectProtocol {
    func addNewLocationAddeersHeaderView()
}
class YDLocationAddersHeaderView: UITableViewHeaderFooterView {
    weak var delegate : YDLocationAddersHeaderViewDelegate?
    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    // 标题
     var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
        return label
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.textColor = YMColor(r: 153, g: 153, b: 153, a: 1)
        return label
    }()
    
    public var moreBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("新建地址", for: UIControl.State.normal)
        button.setImage(UIImage(named: "Addadders_iamge"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(newAddersButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(YDLabelColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout(){

        self.addSubview(self.backView)
        self.backView.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 55)
    
        self.backView.addSubview(lineLabel)
        lineLabel.frame = CGRect(x: 0, y: 0, width: LBFMScreenWidth, height: 10)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 15, y: lineLabel.frame.maxY+15, width: 75, height: 15)
        
        self.backView.addSubview(self.moreBtn)
        self.moreBtn.frame = CGRect(x: LBFMScreenWidth-95, y: lineLabel.frame.maxY+15, width: 80, height: 15)
       
    }

    var titleName: String? {
        didSet{
            guard let string = titleName else {return}
            self.titleLabel.text = string
        }
    }
    @objc func newAddersButtonClick(){
        delegate?.addNewLocationAddeersHeaderView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
