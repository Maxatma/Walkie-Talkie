//
//  MainVC+UINavigationDelegate.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/9/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit


extension MainVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            guard fromVC is MainVC && toVC is CallVC else {
                return nil
            }
            return MainToCallAnimator()
        case .pop:
            guard fromVC is CallVC && toVC is MainVC else {
                return nil
            }
            return CallToMainAnimator()
        default:
            return nil
        }
    }
}

