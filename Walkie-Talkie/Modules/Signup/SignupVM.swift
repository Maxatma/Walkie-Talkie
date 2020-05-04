//
//  SignupVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond


class SignupVM: BondViewModel {
//    let emailVM     = EmailTFVM()
//    let passswordVM = PasswordTFVM()
    let login       = SafePublishSubject<Void>()
    
    override init() {
        super.init()
        
        login
            .observeNext { [weak self] in
                guard let me = self else { return }
//                LoginService.shared
//                    .loginWith(email: me.emailVM.text.value ?? "",
//                               password: me.passswordVM.text.value ?? "")
//                    .feedError(into: me.errors)
//                    .observeNext { user in
//                        print("user ", user)
//                        ModuleConfigurator.shared.goToMain.next()
//                    }
//                    .dispose(in: me.bag)
            }
            .dispose(in: bag)
    }
}

