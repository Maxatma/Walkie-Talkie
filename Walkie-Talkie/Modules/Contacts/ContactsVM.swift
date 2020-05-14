//
//  ContactsVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 14.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond
import ReactiveKit


final class ContactsVM: BondViewModel {
    var items = MutableObservableArray<СontactCellVM>()
    
    override init() {
        super.init()
        
    }
}

