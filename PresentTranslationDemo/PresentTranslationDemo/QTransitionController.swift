//
//  QTransitionController.swift
//
//  Created by Quinn_F on 2018/6/3.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
/**
 present转场动画控制器，遵守UIViewControllerTransitioningDelegate
 需要配置 presented dismissed 相关动画信息
 相关文件为：
 1.QPresentTransitionAnimatorLibrary.swift
 2.QDismissTransitionAnimatorLibrary.swift
 */

class QTransitionController: NSObject {
    
    enum TranslateType {
        case present
        case push
        case pop
        case dismiss
    }
    
    private var translateType:TranslateType = .present
    
    var presentType:QPresentTransitionAnimatorLibrary = .fadeIn{
        didSet{
            translateType = .present
        }
    }
    var dismissType:QDismissTransitionAnimatorLibrary = .fadeOut{
        didSet{
            translateType = .dismiss
        }
    }

}

extension QTransitionController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return QPresentTransitionAnimatorLibrary.fadeIn.transition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return QDismissTransitionAnimatorLibrary.fadeOut.transition()
    }

//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//
//    }
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//
//    }
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//
//    }

}
extension QTransitionController:UIViewControllerInteractiveTransitioning{
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}
