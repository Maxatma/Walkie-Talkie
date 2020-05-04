//
//  SignupVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit



final class SignupVC: BondVC {
    var vm: SignupVM {
        return viewModel as! SignupVM
    }
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        advise()
    }
    
    override func advise() {
        super.advise()
        signup.reactive.tap.bind(to: vm.login).dispose(in: bag)
    }
}

