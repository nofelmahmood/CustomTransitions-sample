//
//  ViewController.swift
//  CustomTransitions-sample
//
//  Created by Nofel Mahmood on 06/09/2017.
//  Copyright © 2017 nineish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var anotherViewController: UIViewController!
    var dismissInteractionController: InteractionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleButtonTap(sender: AnyObject) {
        performSegue(withIdentifier: "Show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show" {
            let destinationViewController = segue.destination
            anotherViewController = segue.destination
            destinationViewController.modalPresentationStyle = .custom
            
            dismissInteractionController = InteractionController(presentedViewController: segue.destination)
            destinationViewController.transitioningDelegate = self
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animationController = AnimationController()
        
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = AnimationController()
        animationController.direction = .Dismiss
        
        return animationController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return dismissInteractionController.isInteracting ? dismissInteractionController: nil
    }
}

