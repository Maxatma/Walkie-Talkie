//
//  BaseAnimator.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/9/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit


class BaseAnimator<FromVC:UIViewController, ToVC:UIViewController> : NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? FromVC,
            let toVC = transitionContext.viewController(forKey: .to) as? ToVC
            else {
                transitionContext.completeTransition(true)
                return
        }

        self.fromVC = fromVC
        self.toVC = toVC
        
        containerView = transitionContext.containerView
    }
    
    var fromVC: FromVC!
    var toVC: ToVC!
    var containerView: UIView!
}

