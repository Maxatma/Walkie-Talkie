//
//  BackableVM.swift
//
//
//  Created by Alexandr on 7/22/17.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import ReactiveKit

public protocol Backable: BondVMProtocol {
	var back: SafePublishSubject<()> { get }
}

class BackableVM: BondViewModel, Backable {
	let back = SafePublishSubject<()>()

	public override init() {
		super.init()
	}
}
