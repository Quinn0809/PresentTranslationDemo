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
    private var translateType:QTranslateType = .present
    weak var fromView:UIView?
    weak var toView:UIView?
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
    var interaction:QInteractiveTranslationManager?

    
    var dismissInteractionDirection:QGestureDirection = .down{
        didSet{
            interaction = QInteractiveTranslationManager(gestureDirection: dismissInteractionDirection)
        }
    }
    
}
extension QTransitionController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentType.transition(from:fromView ,to:toView)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissType.transition()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interaction?.interation ?? false) ? interaction : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //ToDo:present interaction
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        //ToDo:.....
        return nil
    }
    
}
