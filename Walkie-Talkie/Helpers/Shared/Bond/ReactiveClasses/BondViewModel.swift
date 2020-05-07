//
//  BondViewModel.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit


public protocol BondVMProtocol: class {}

public class BondViewModel: NSObject, BondVMProtocol {
	let errors = SafePublishSubject<BaseServiceError>()

	public override init() {
		super.init()
        
        print("init \(type(of: self))")

		errors
			.observeNext { value in
                print("BondViewModel error ", value)
//                Router.shared.showAlert(message: String(describing: value))
			}
			.dispose(in: bag)
	}
}

