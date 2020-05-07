//
//  UIApplication.swift
//  
//
//  Created by Alexander Zaporozhchenko on 6/26/17.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import UIKit


extension UIApplication {
    
    public static func getVisibleViewControllerFrom(vc: UIViewController?  = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIApplication.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        }
        else if let tc = vc as? UITabBarController {
            return UIApplication.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        }
        else {
            if let pvc = vc?.presentedViewController {
                return UIApplication.getVisibleViewControllerFrom(vc:pvc)
            } else {
                return vc
            }
        }
    }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    class func topView()->UIView? {
        var view = topViewController()?.view
        
        while view != nil && view?.superview != nil {
            view = view!.superview
        }
        return view
    }
}

