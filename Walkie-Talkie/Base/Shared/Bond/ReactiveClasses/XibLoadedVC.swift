//
//  XibLoadedVC.swift
//  Login
//
//  Created by Oleksandr Zaporozhchenko on 2/11/19.
//  Copyright © 2019 Oleksandr Zaporozhchenko. All rights reserved.
//

import UIKit

class XibLoadedVC: UIViewController {
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
   
    required init() {
        print("init \(type(of: self))")
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: String(describing: type(of: self)), bundle: bundle)
    }
}
