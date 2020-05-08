//
//  ViewController.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import WebRTC
import PIPKit


final class CallVC: BondVC {
    var vm: CallVM {
        return viewModel as! CallVM
    }
    
    @IBOutlet var caller: WebRTCView!
    @IBOutlet var settings: SettingsView!
    
    let pipVC = PIPVideoVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        advise()
        
        pipVC.viewModel = vm.meVideoVM
        PIPKit.show(with: pipVC)
    }
    
    override func advise() {
        super.advise()
        caller.videoView.vm = vm.videoVM
        settings.viewModel = vm.settingsVM
    }
}

