//
//  QPresentTransitionAnimatiorLibrary.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/6/3.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
/**
 Present转场动画库，配合 QTransitionController使用
 */

enum QPresentTransitionAnimatorLibrary {
    case fadeIn
    case pointIn
    case viewIn
    func transition(from:UIView?,to:UIView?)->UIViewControllerAnimatedTransitioning{
        switch self {
        case .fadeIn:
            return QPresentAnimatorA(from: from, to: to)
        case .pointIn:
            return QPresentAnimatorB(from: from, to: to)
        case .viewIn:
            return QPresentAnimatorC(from: from, to: to)
        }
    }
}
class QPresentAnimator: NSObject {
    weak var fromView:UIView?
    weak var toView:UIView?
    var transitionContext: UIViewControllerContextTransitioning?
    init(from:UIView?,to:UIView?) {
        super.init()
        fromView = from
        toView = to
    }
}
/**
 present animator 需要遵守 UIViewControllerAnimatedTransitioning 协议
 
 */
class QPresentAnimatorA: QPresentAnimator, UIViewControllerAnimatedTransitioning{

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let screenBounds = UIScreen.main.bounds
       
        
        //from vc view
        guard let from = transitionContext.viewController(forKey: .from)else{
            return
        }
        from.view.frame = CGRect.init(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        
        
        //to vc view
        guard let to = transitionContext.viewController(forKey: .to) else {
            return
        }
        to.view.frame = CGRect.init(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        to.view.alpha = 0
        /**转场动画UIView容器
         */
        let containView = transitionContext.containerView
        
        containView.addSubview(from.view)
        containView.addSubview(to.view)
        
        let duration: TimeInterval = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            
            to.view.alpha = 1
            
        }) { (_) in
            
            let wasCancelled: Bool = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
    }
    
}
class QPresentAnimatorB: QPresentAnimator, UIViewControllerAnimatedTransitioning,CAAnimationDelegate{
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag{
           transitionContext?.completeTransition(true)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        /**转场动画UIView容器
         */
        let containView = transitionContext.containerView
        //from vc view
        guard let from = transitionContext.viewController(forKey: .from)else{
            return
        }
        //to vc view
        guard let to = transitionContext.viewController(forKey: .to) else {
            return
        }
        containView.addSubview(from.view)
        containView.addSubview(to.view)
        
        guard let fromView = fromView else {
            return
        }

        let startCircle = UIBezierPath.init(arcCenter: fromView.center, radius: min(fromView.frame.width, fromView.frame.height), startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        
        let a = max(fromView.frame.origin.x, containView.frame.size.width - fromView.frame.origin.x)
        let b = max(fromView.frame.origin.y, containView.frame.size.height - fromView.frame.origin.y)
        let radius = sqrt(pow(a, 2) + pow(b, 2))
        
        let endCircle = UIBezierPath.init(arcCenter: containView.center, radius: radius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = endCircle.cgPath
        
        to.view.layer.mask = maskLayer
        
        
        let maskLayerAnimation = CABasicAnimation.init(keyPath: "path")
        maskLayerAnimation.fromValue = startCircle.cgPath
        maskLayerAnimation.toValue = endCircle.cgPath
        maskLayerAnimation.duration = 0.5
        maskLayerAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "maskLayer")

        
    }
    
}
class QPresentAnimatorC: QPresentAnimator, UIViewControllerAnimatedTransitioning{
    
    weak var imageV:UIImageView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        /**转场动画UIView容器
         */
        let containView = transitionContext.containerView
        //from vc view
        guard let from = transitionContext.viewController(forKey: .from)else{
            return
        }
        //to vc view
        guard let to = transitionContext.viewController(forKey: .to) else {
            return
        }
        to.view.alpha = 0
        containView.addSubview(from.view)
        containView.addSubview(to.view)
        
        guard let fromView = fromView as? UIButton else {
            return
        }
        guard let image = fromView.image(for: .normal) else{
            return
        }
        
        let imageV = UIImageView.init(frame: fromView.frame)
        imageV.image = image
        imageV.alpha = 0.5
        containView.addSubview(imageV)
        self.imageV = imageV
        
        guard let vc = to as? SecondViewController else{
            return
        }
        
        let positionAnimation = CABasicAnimation.init(keyPath: "position")
        positionAnimation.fromValue = imageV.center
        positionAnimation.toValue = vc.imageV.center
        positionAnimation.duration = 0.3
        positionAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "bounds.size")
        scaleAnimation.fromValue = imageV.bounds.size
        scaleAnimation.toValue = vc.imageV.bounds.size
        scaleAnimation.duration = 0.3
        scaleAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let alphaAnimation = CABasicAnimation.init(keyPath: "alpha")
        alphaAnimation.fromValue = 0.5
        alphaAnimation.toValue = 1
        alphaAnimation.duration = 0.3
        alphaAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let group = CAAnimationGroup()
        group.animations = [positionAnimation,scaleAnimation,alphaAnimation]
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.duration = 0.3
        
        imageV.layer.add(group, forKey: "group")

        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveLinear, animations: {
            vc.view.alpha = 1
        }) { (bool) in
            imageV.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
}

