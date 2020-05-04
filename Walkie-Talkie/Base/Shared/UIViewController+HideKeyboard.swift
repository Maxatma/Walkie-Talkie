//
//  UIViewController+HideKeyboard.swift
//
//
//  Created by Alexander Zaporozhchenko on 6/2/17.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap                  = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

