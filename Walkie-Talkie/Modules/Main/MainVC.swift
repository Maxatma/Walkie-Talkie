//
//  MainVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import SwiftyUserDefaults


final class MainVC: BondVC {
    var vm: MainVM {
        return viewModel as! MainVM
    }
    
    @IBOutlet var myVideo: WebRTCView!
    @IBOutlet var join: JoinView!
    @IBOutlet var source: UIButton!
    @IBOutlet var selectID: UIButton!
    
    override func viewDidLoad() {
        navigationController?.delegate = self
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        advise()
        KeyboardAvoiding.avoidingView = join
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.joinVM.roomID.next(Defaults[\.selesctedId] ?? "")
    }
    
    override func advise() {
        super.advise()
        myVideo.videoView.vm = vm.videoVM
        join.viewModel = vm.joinVM
        source.reactive.tap.bind(to: vm.selectSource).dispose(in: bag)
        selectID.reactive.tap.bind(to: vm.selectID).dispose(in: bag)
    }
}

