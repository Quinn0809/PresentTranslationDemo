//
//  QDismissTransitionAnimatorLibrary.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/6/3.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
/**
 Dismiss转场动画库，配合 QTransitionController使用
 */
enum QDismissTransitionAnimatorLibrary {
    case fadeOut
    func transition()->UIViewControllerAnimatedTransitioning{
        switch self {
        case .fadeOut:
            return QDismissAnimatorA()
        
        }
    }
}
/**
 present animator 需要遵守 UIViewControllerAnimatedTransitioning 协议
 
 */
class QDismissAnimatorA: NSObject, UIViewControllerAnimatedTransitioning{
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
class QDismissAnimatorB: NSObject, UIViewControllerAnimatedTransitioning{
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
