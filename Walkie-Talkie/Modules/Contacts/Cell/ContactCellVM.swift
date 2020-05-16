//
//  ContactCellVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond
import ReactiveKit
import SwiftyUserDefaults


final class СontactCellVM: BondViewModel, SelectableProtocol {
    let doSelect = SafePublishSubject<Void>()
    let info = Observable<String>("")
    
    init(model: String) {
        super.init()
        info.next(model)
        doSelect
            .observeNext {
                Defaults[\.selesctedId] = model
                Router.shared.pop() }
            .dispose(in: bag)
    }
}
