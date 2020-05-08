//
//  MainVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding


final class MainVC: BondVC {
    var vm: MainVM {
        return viewModel as! MainVM
    }
    
    @IBOutlet var myVideo: WebRTCView!
    @IBOutlet var join: JoinView!
    
    override func viewDidLoad() {
        navigationController?.delegate = self
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        advise()
        KeyboardAvoiding.avoidingView = join
    }
    
    override func advise() {
        super.advise()
        myVideo.videoView.vm = vm.videoVM
        join.viewModel = vm.joinVM
    }
}

