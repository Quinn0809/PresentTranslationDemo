//
//  QInteractiveTranslationManager.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/7/9.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class QInteractiveTranslationManager: UIPercentDrivenInteractiveTransition {
    
    weak var vc:UIViewController?
    var gestureDirection:QGestureDirection = .down
    private(set) var interation:Bool = false
    private(set) var transitionType:QTranslateType = .dismiss
    
    init(gestureDirection:QGestureDirection) {
        super.init()
        self.gestureDirection = gestureDirection
    }
    
    @objc func handleGesture(gesture:UIPanGestureRecognizer){
        
        var present:CGFloat = 0
        switch gestureDirection {
        case .left:
            let transitionX = -gesture.translation(in: gesture.view).x
            present = transitionX/(gesture.view?.frame.size.width ?? 0)
        case .right:
            let transitionX = gesture.translation(in: gesture.view).x
            present = transitionX/(gesture.view?.frame.size.width ?? 0)
        case .up:
            let transitionY = -gesture.translation(in: gesture.view).y
            present = transitionY/(gesture.view?.frame.size.height ?? 0)
        case .down:
            let transitionY = gesture.translation(in: gesture.view).y
            present = transitionY/(gesture.view?.frame.size.height ?? 0)
        }
        
        switch gesture.state {
        case .began:
            interation = true
            startGesture()
        case .changed:
            //更新百分比
            update(present)
        case .ended:
            interation = false
            if present > 0.3{
                self.finish()
            }else{
                self.cancel()
            }
        default:
            break
        }
    }
    
    func addPanGestureForViewController(_ viewController:UIViewController ){
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
        self.vc = viewController
        self.vc?.view.addGestureRecognizer(pan)
    }
    
    
    func startGesture(){
        switch transitionType {
        case .dismiss:
            vc?.dismiss(animated: true, completion: nil)
            
        case .pop:
            vc?.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}
