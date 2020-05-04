//
//  UIStoryboard+Add.swift
//  GPSWIFT
//
//  Created by Alexander Zaporozhchenko on 11/27/16.
//  Copyright © 2016 Alexander Zaporozhchenko. All rights reserved.
//

import UIKit


extension UIStoryboard {
    func instantiate<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        return instantiateViewController(withIdentifier: name) as! T
    }
    
    func instantiate<T: UIViewController>(_ identifier:String) -> T {
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func instantiate(_ controller:UIViewController, viewModel:Any) {
        return
    }
}

