//
//  ContactCellVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond
import ReactiveKit


final class СontactCellVM: BondViewModel, SelectableProtocol {
    let doSelect = SafePublishSubject<Void>()
    let info = Observable<String>("")

    init(model: String) {
        super.init()
        doSelect
            .observeNext { Router.shared.pop() }
            .dispose(in: bag)
    }
}
