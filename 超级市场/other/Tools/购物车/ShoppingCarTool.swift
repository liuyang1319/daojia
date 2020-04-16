//
//  ShoppingCarTool.swift
//  AsongShoppingCarDemo
//
//  Created by SongLan on 2017/2/19.
//  Copyright © 2017年 SongLan. All rights reserved.
//

import UIKit
typealias animationFinishedBlock = (_ finish : Bool) -> Void

class ShoppingCarTool: NSObject,CAAnimationDelegate {

    private var layer : CALayer?
    var aniFinishedBlock : animationFinishedBlock?
    override init() {
        super.init()
    }
    //MARK: - 开始走的方法
    func startAnimationBottom(view : UIImageView,andRect rect : CGRect,andFinishedRect finishPoint : CGPoint, andFinishBlock completion : @escaping animationFinishedBlock) -> Void{
        layer = CALayer()
        layer?.contents = view.layer.contents
        layer?.bounds = rect
        layer?.cornerRadius = layer!.bounds.width * 0.3
        layer?.cornerRadius = layer!.bounds.height * 0.3
        layer?.masksToBounds = true
        layer?.contentsGravity = CALayerContentsGravity.resize
        layer?.frame = rect
    
        let myWindow : UIView = ((UIApplication.shared.delegate?.window)!)!
        myWindow.layer.addSublayer(layer!)
        //创建路径 其路径是抛物线
        let path : UIBezierPath = UIBezierPath()
        path.move(to: (layer?.position)!)
        path.addQuadCurve(to: finishPoint, controlPoint:CGPoint(x: myWindow.frame.size.width/2, y: rect.origin.y - 40))
        
        //这里要使用组合动画 一个负责旋转，另一个负责曲线的运动
        //创建 关键帧动画 负责曲线的运动
        let pathAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")//位置的平移
        pathAnimation.path = path.cgPath
        //负责旋转 rotation
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1
        smallAnimation.fromValue = 0.5
        smallAnimation.toValue = 0.2
        smallAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        //创建组合动画 主要是负责时间的相关设置 如下
        let groups : CAAnimationGroup = CAAnimationGroup()
        groups.animations = [pathAnimation,smallAnimation]
        groups.duration = 1.0//国际单位制 S
        groups.fillMode = CAMediaTimingFillMode.forwards
        groups.isRemovedOnCompletion = false
        groups.delegate = self
        self.layer?.add(groups, forKey: "groups")
        aniFinishedBlock = completion
    }
   //MARK: - 开始走的方法
    func startAnimation(view : UIImageView,andRect rect : CGRect,andFinishedRect finishPoint : CGPoint, andFinishBlock completion : @escaping animationFinishedBlock) -> Void{
        layer = CALayer()
        layer?.contents = view.layer.contents
        layer?.bounds = rect
        layer?.cornerRadius = layer!.bounds.height * 0.3
        layer?.masksToBounds = true
        layer?.contentsGravity = CALayerContentsGravity.resize
        layer?.frame = rect
    
        let myWindow : UIView = ((UIApplication.shared.delegate?.window)!)!
        myWindow.layer.addSublayer(layer!)
        //创建路径 其路径是抛物线
        let path : UIBezierPath = UIBezierPath()
        path.move(to: (layer?.position)!)
        path.addQuadCurve(to: finishPoint, controlPoint:CGPoint(x: myWindow.frame.size.width/2, y: rect.origin.y - 40))
        
        //这里要使用组合动画 一个负责旋转，另一个负责曲线的运动
        //创建 关键帧动画 负责曲线的运动
        let pathAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")//位置的平移
        pathAnimation.path = path.cgPath
        //负责旋转 rotation
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1
        smallAnimation.fromValue = 0.8
        smallAnimation.toValue = 0.2
        smallAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        //创建组合动画 主要是负责时间的相关设置 如下
        let groups : CAAnimationGroup = CAAnimationGroup()
        groups.animations = [pathAnimation,smallAnimation]
        groups.duration = 1.0//国际单位制 S
        groups.fillMode = CAMediaTimingFillMode.forwards
        groups.isRemovedOnCompletion = false
        groups.delegate = self
        self.layer?.add(groups, forKey: "groups")
        aniFinishedBlock = completion
    }
    //MARK: - 开始走的方法
    func startAnimationTop(view : UIImageView,andRect rect : CGRect,andFinishedRect finishPoint : CGPoint, andFinishBlock completion : @escaping animationFinishedBlock) -> Void{
        layer = CALayer()
        layer?.contents = view.layer.contents
        layer?.bounds = rect
        layer?.cornerRadius = layer!.bounds.height * 0.3
        layer?.masksToBounds = true
        layer?.contentsGravity = CALayerContentsGravity.resize
        layer?.position = CGPoint(x: view.center.x, y: rect.minY + 96)
        layer?.frame = rect
        
        let myWindow : UIView = ((UIApplication.shared.delegate?.window)!)!
        myWindow.layer.addSublayer(layer!)
        //创建路径 其路径是抛物线
        let path : UIBezierPath = UIBezierPath()
        path.move(to: (layer?.position)!)
        path.addQuadCurve(to:CGPoint(x: LBFMScreenWidth-25, y:35), controlPoint:CGPoint(x: LBFMScreenWidth*0.5, y: rect.origin.y - 80))
        
        //这里要使用组合动画 一个负责旋转，另一个负责曲线的运动
        //创建 关键帧动画 负责曲线的运动
        let pathAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")//位置的平移
        pathAnimation.path = path.cgPath
        //负责旋转 rotation
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1
        smallAnimation.fromValue = 0.8
        smallAnimation.toValue = 0.2
        smallAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        //创建组合动画 主要是负责时间的相关设置 如下
        let groups : CAAnimationGroup = CAAnimationGroup()
        groups.animations = [pathAnimation,smallAnimation]
        groups.duration = 1.0//国际单位制 S
        groups.fillMode = CAMediaTimingFillMode.forwards
        groups.isRemovedOnCompletion = false
        groups.delegate = self
        self.layer?.add(groups, forKey: "groups")
        aniFinishedBlock = completion
    }
    //MARK: - 上下浮动
    func shakeAnimation(shakeView : UIView){
        let basicAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        basicAnimation.duration = 0.25
        basicAnimation.fromValue = NSNumber(value: -5)
        basicAnimation.toValue = NSNumber(value: 5)
        basicAnimation.autoreverses = true
        shakeView.layer.add(basicAnimation, forKey: "Asong")
    }
    //MARK: -CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == layer!.animation(forKey: "groups"){
            layer?.removeFromSuperlayer()
            layer = nil
            if (aniFinishedBlock != nil) {
                aniFinishedBlock!(true)
            }
        }
    }
    
}
