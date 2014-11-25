//
//  TransitionOperator.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-21.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import Foundation
import UIKit

class TransitionOperator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
  
  var snapshot : UIView!
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
  return 3.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView()
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let fromView = fromViewController!.view
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    let toView = toViewController!.view
    
    let size = toView.frame.size
    var offSetTransform = CGAffineTransformMakeTranslation(size.width - 120, 0)
    offSetTransform = CGAffineTransformScale(offSetTransform, 0.6, 0.6)
    
    snapshot = fromView.snapshotViewAfterScreenUpdates(true)
    
    container.addSubview(toView)
    container.addSubview(snapshot)
    
    let duration = self.transitionDuration(transitionContext)
    
    UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
      
      self.snapshot.transform = offSetTransform
      
      }, completion: { finished in
        
        transitionContext.completeTransition(true)
    })
    
  }
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  
  return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  
  return self
  }
}