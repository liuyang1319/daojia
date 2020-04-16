//
//  YDClassifyCollectionViewCell.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/4.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
protocol YDClassifyCollectionViewCellDelegate {
    func selectGoodsClassTableViewCell(selectBtn:UIButton)
}
class YDClassifyCollectionViewCell: UITableViewCell {
    
     var delegate : YDClassifyCollectionViewCellDelegate?
    lazy var backView : UIView = {
       let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    lazy var backImage : UIImageView = {
         let backView = UIImageView()
          backView.image = UIImage(named:"class_back_iamge")
          return backView
      }()
    lazy var linLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YDLabelColor
        return label
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var selectBtn : UIButton = {
        let button = UIButton()
        button.isSelected = false
        button.addTarget(self, action: #selector(refreshIndexPathIRow(selectBtn:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = YMColor(r: 238, g: 238, b: 238, a: 1)
        return label
    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.backView.backgroundColor = UIColor.white
            if isIphoneX == true {
                self.backView.frame = CGRect(x: 0, y:0, width: 100, height:50)
                self.nameLabel.frame = CGRect(x: 5, y:15, width: 95, height: 20)
            }else{
                self.backView.frame = CGRect(x: 0, y:0, width: 80, height:50)
                self.nameLabel.frame = CGRect(x: 5, y:15, width: 75, height: 20)
            }
          
            self.nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
            self.backView.addSubview(self.linLabel)
            self.nameLabel.textColor = YDLabelColor
            self.linLabel.isHidden = false
            self.linLabel.frame = CGRect(x:0, y:18, width: 3, height: 14)
            let attributedString = NSMutableAttributedString(string:self.nameLabel.text ?? "")
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 2, range: NSRange(location: 0, length:attributedString.length))
            self.nameLabel.attributedText = attributedString
        }else{

            self.backView.backgroundColor = YMColor(r: 246, g: 246, b: 246, a: 1)
            self.nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
            self.linLabel.isHidden = true
            self.nameLabel.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
            let attributedString = NSMutableAttributedString(string:self.nameLabel.text ?? "")
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 2, range: NSRange(location: 0, length:attributedString.length))
            self.nameLabel.attributedText = attributedString
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.nameLabel)
        if isIphoneX == true{
            self.backView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            self.nameLabel.frame = CGRect(x: 5, y:15, width: 95, height: 20)
        }else{
            self.backView.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
            self.nameLabel.frame = CGRect(x: 5, y:15, width: 75, height: 20)
        }
        let attributedString = NSMutableAttributedString(string:self.nameLabel.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 2, range: NSRange(location: 0, length:attributedString.length))
        self.nameLabel.attributedText = attributedString
//        self.backView.addSubview(self.lineLabel)
        
        self.lineLabel.frame = CGRect(x: 0, y: 43, width: 80, height: 1)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var classifyListTwoModel:YDClassifyListOneModel? {
        didSet {
            guard let model = classifyListTwoModel else {return}
            self.nameLabel.text = model.name
        }
    }
    @objc func refreshIndexPathIRow(selectBtn:UIButton) {
        
//        delegate?.selectGoodsClassTableViewCell(selectBtn: selectBtn)
        
//        self.backView.addSubview(self.linLabel)
//        self.linLabel.frame = CGRect(x:0, y:14, width: 3, height: 14)
//
//        self.backView.addSubview(self.nameLabel)
//        self.nameLabel.frame = CGRect(x: 10, y: 12, width: 60, height: 20)
//        self.nameLabel.textColor = YDLabelColor
    }

//    var isopenModel:String = "" {
//        didSet {
//            guard var model = isopenModel else {return}
//            if model.isOpen == "" {
//                self.linLabel.isHidden = false
//                 self.nameLabel.textColor = YDLabelColor
//            }else{
//                self.linLabel.isHidden = true
//                self.nameLabel.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
//            }
//
//        }
//    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    @objc func refreshIndexPathIRow(){
//        if self.selectBtn.isSelected != true {
//            self.selectBtn.isSelected = false
//            self.backView.backgroundColor = UIColor.white
//            self.backView.frame = CGRect(x: 0, y:0, width: 80, height:44)
//            self.nameLabel.frame = CGRect(x: 10, y:12, width: 65, height: 20)
//            self.backView.addSubview(self.linLabel)
//            self.nameLabel.textColor = YDLabelColor
//            self.linLabel.isHidden = false
//            self.linLabel.frame = CGRect(x:0, y:14, width: 3, height: 14)
//        }else{
//            self.selectBtn.isSelected = true
//            self.linLabel.isHidden = true
//            self.nameLabel.textColor = YMColor(r: 102, g: 102, b: 102, a: 1)
//        }
//    }
   
}
