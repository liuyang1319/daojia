//
//  YDWeChatCodeViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/2.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit

class YDWeChatCodeViewController: UIViewController {

    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    var codeImage:UIImageView = {
        let code = UIImageView()
        return code
    }()
    var titleLabel:UILabel = {
        let title = UILabel()
        title.text = "扫一扫上面的二维码\n联系我们"
        title.textAlignment = .center
        title.numberOfLines = 2
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        title.textColor = YMColor(r: 51, g: 51, b: 51, a: 1)
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        self.view.addSubview(self.backView)
        if isIphoneX == true{
            self.backView.frame = CGRect(x:(LBFMScreenWidth-290)*0.5, y: 270, width: 290, height: 330)
        }else{
            self.backView.frame = CGRect(x:(LBFMScreenWidth-290)*0.5, y: 170, width: 290, height: 330)
        }
        self.backView.addSubview(self.codeImage)
        self.codeImage.frame = CGRect(x: 35, y: 35, width: 215, height: 215)
//        self.codeImage.image = setupQRCodeImage("hehehe", image: nil)
        
        self.backView.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(x: 80, y: self.codeImage.frame.maxY+15, width: 130, height: 40)
    }
    var imageCode : String = ""{
        didSet {
            self.codeImage.kf.setImage(with: URL(string:imageCode), placeholder: UIImage(named: ""))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
//    //MARK: -传进去字符串,生成二维码图片
//    func setupQRCodeImage(_ text: String, image: UIImage?) -> UIImage {
//        //创建滤镜
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        filter?.setDefaults()
//        //将url加入二维码
//        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
//        //取出生成的二维码（不清晰）
//        if let outputImage = filter?.outputImage {
//            //生成清晰度更好的二维码
//            let qrCodeImage = setupHighDefinitionUIImage(outputImage, size: 300)
//            //如果有一个头像的话，将头像加入二维码中心
////            if var image = image {
////                //给头像加一个白色圆边（如果没有这个需求直接忽略）
////                image = circleImageWithImage(image, borderWidth: 50, borderColor: UIColor.white)
////                //合成图片
////                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 100, height: 100)
////
////                return newImage
////            }
//            
//            return qrCodeImage
//        }
//        
//        return UIImage()
//    }
//    //MARK: - 生成高清的UIImage
//    func setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
//        let integral: CGRect = image.extent.integral
//        let proportion: CGFloat = min(size/integral.width, size/integral.height)
//        
//        let width = integral.width * proportion
//        let height = integral.height * proportion
//        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
//        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
//        
//        let context = CIContext(options: nil)
//        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
//        
//        bitmapRef.interpolationQuality = CGInterpolationQuality.none
//        bitmapRef.scaleBy(x: proportion, y: proportion);
//        bitmapRef.draw(bitmapImage, in: integral);
//        let image: CGImage = bitmapRef.makeImage()!
//        return UIImage(cgImage: image)
//    }

}
