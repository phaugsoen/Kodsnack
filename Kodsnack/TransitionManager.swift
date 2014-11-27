//
//  TransitionManager.swift
//  kodsnack
//
//  Created by Per Haugsoen on 26/11/14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import Foundation
import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    
    private var presenting = true
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
/*
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        // start the toView to the right of the screen
       // toView.transform = offScreenRight
        if self.presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animateWithDuration(duration,
            delay: 0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1.3,
            options: nil, animations: {
            
           // fromView.transform = offScreenLeft
            if (self.presenting) {
            fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
        })
        
    }
  */
  //  func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 1. Prepare for the required components
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let screenBounds = UIScreen.mainScreen().bounds
        
        // 2. Make toVC at the top of the screen
        toVC.view.frame = CGRectOffset(finalFrame, 0, -1.0 * CGRectGetHeight(screenBounds))
        containerView.addSubview(toVC.view)
        
        // 3. Set the dynamic animators used by the view controller presentation
        var animator: UIDynamicAnimator? = UIDynamicAnimator(referenceView: containerView)
        let gravity = UIGravityBehavior(items: [toVC.view])
        gravity.magnitude = 5 // 10
        
        let collision = UICollisionBehavior(items: [toVC.view])
        collision.addBoundaryWithIdentifier("GravityBoundary",
            fromPoint: CGPoint(x: 0, y: screenBounds.height),
            toPoint: CGPoint(x: screenBounds.width, y: screenBounds.height))
        
        let animatorItem = UIDynamicItemBehavior(items: [toVC.view])
        animatorItem.elasticity = 0.5 // 0.5
        
        animator!.addBehavior(gravity)
        animator!.addBehavior(collision)
        animator!.addBehavior(animatorItem)
        
        // 4. Complete the transition after the time of the duration
        let nsecs = UInt64(transitionDuration(transitionContext)) * NSEC_PER_SEC
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(nsecs))
        
        dispatch_after(delay, dispatch_get_main_queue()) {
            animator = nil
            transitionContext.completeTransition(true)
        }
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 3.0
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // remmeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}