//
//  UITextField+Bond.swift
//  Login
//
//  Created by Oleksandr Zaporozhchenko on 3/19/19.
//  Copyright © 2019 Oleksandr Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit


extension ReactiveExtensions where Base: UITextField {
    public var delegate: ProtocolProxy {
        return base.reactive.protocolProxy(for: UITextFieldDelegate.self,
                                           selector: NSSelectorFromString("setDelegate:"))
    }
}


extension UITextField {
    var textShouldBeginEditing: SafeSignal<Bool> {
        return reactive.delegate.signal(for: #selector(UITextFieldDelegate.textFieldShouldBeginEditing(_:))) { (subject: SafePublishSubject<Bool>, _: UITextField) in
            subject.next(false)
        }
    }
}

