//
//  InteractionController.swift
//  CustomTransitions-sample
//
//  Created by Nofel Mahmood on 08/09/2017.
//  Copyright © 2017 nineish. All rights reserved.
//

import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    
    var presentedViewController: UIViewController!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    var isInteracting = false
    
    init(presentedViewController: UIViewController) {
        super.init()
        self.presentedViewController = presentedViewController
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        self.presentedViewController.view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
    }
    
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        let height = presentedViewController.view.frame.size.height
        var percent = translation.y / height
        percent = CGFloat(fmaxf(Float(percent), 0.0))
        percent = CGFloat(fminf(Float(percent), 1.0))
        
        let threshold = 0.5
        let shouldFinish = percent > CGFloat(threshold)
        
        if gestureRecognizer.state == .began {
            isInteracting = true
            presentedViewController.dismiss(animated: true, completion: nil)
        } else if gestureRecognizer.state == .changed {
            update(percent)
        } else if gestureRecognizer.state == .ended {
            if shouldFinish {
                finish()
            } else {
                cancel()
            }
        } else if gestureRecognizer.state == .cancelled {
            cancel()
        }
    }
    
}

extension InteractionController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view is UIButton {
            return false
        }
        
        return true
    }
}
