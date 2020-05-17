//
//  JoinView.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/6/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond


final class JoinView: BondView {
    var vm: JoinVM {
        return viewModel as! JoinVM
    }
    @IBOutlet var create: UIButton!
    @IBOutlet var join: UIButton!
    @IBOutlet var roomID: UITextField!
    
    override func advise() {
        super.advise()
        
        create.reactive.tap.bind(to: vm.create).dispose(in: bag)
        join.reactive.tap.bind(to: vm.join).dispose(in: bag)

        roomID.reactive.text.ignoreNils().bind(to: vm.roomID).dispose(in: bag)
        vm.roomID.bind(to: roomID.reactive.text).dispose(in: bag)

        vm.isButtonsEnabled.bind(to: create.reactive.isEnabled).dispose(in: bag)
        vm.isButtonsEnabled.bind(to: join.reactive.isEnabled).dispose(in: bag)
    }
}

