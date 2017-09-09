//
//  AnimationController.swift
//  CustomTransitions-sample
//
//  Created by Nofel Mahmood on 06/09/2017.
//  Copyright © 2017 nineish. All rights reserved.
//

import UIKit

enum AnimationType {
    case Present
    case Dismiss
}

class AnimationController: NSObject {
    var direction = AnimationType.Present
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)
        
        let containerView = transitionContext.containerView
        
        if direction == .Present {
            
            containerView.addSubview(toViewController!.view)
            
            let finalFrame = toViewController!.view.frame
            let initialFrame = CGRect(x: toViewController!.view.frame.origin.x, y: toViewController!.view.frame.size.height, width: toViewController!.view.frame.size.width, height: toViewController!.view.frame.size.height)
            toViewController!.view.frame = initialFrame
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController!.view.frame = finalFrame
            }, completion: { _ in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                } else {
                    transitionContext.completeTransition(true)
                }
            })
            
        } else if direction == .Dismiss {
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                fromViewController!.view.frame = CGRect(x: fromViewController!.view.frame.origin.x, y: fromViewController!.view.frame.size.height, width: fromViewController!.view.frame.size.width, height: fromViewController!.view.frame.size.height)
                
            }, completion: { _ in
                
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                } else {
                    transitionContext.completeTransition(true)
                    fromViewController!.view.removeFromSuperview()
                }
            })
        }
        
        
    }
}
