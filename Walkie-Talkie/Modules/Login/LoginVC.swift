//
//  LoginVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond


final class LoginVC: BondVC {
    var vm: LoginVM {
        return viewModel as! LoginVM
    }
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        advise()
    }
    
    override func advise() {
        super.advise()
//        emailTF.viewModel    = vm.emailVM
//        passwordTF.viewModel = vm.passswordVM
        login.reactive.tap.bind(to: vm.login).dispose(in: bag)
    }
}

