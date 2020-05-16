//
//  UIImagePickerController+Bond.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 16.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond
import ReactiveKit


extension ReactiveExtensions where Base: UIImagePickerController {
    public var delegate: ProtocolProxy {
        return base.reactive.protocolProxy(for: UIImagePickerControllerDelegate.self, selector: NSSelectorFromString("setDelegate:"))
    }
}

extension UIImagePickerController {
    var pickedWithInfo: SafeSignal<[UIImagePickerController.InfoKey : Any]> {
        let delegateSelector = #selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:))
        return reactive
            .delegate
            .signal(for: delegateSelector) { (
                subject: SafePublishSubject<[UIImagePickerController.InfoKey : Any]>,
                picker: UIImagePickerController,
                info: [UIImagePickerController.InfoKey : Any]
                ) in
                
                subject.next(info)
        }
    }
}

