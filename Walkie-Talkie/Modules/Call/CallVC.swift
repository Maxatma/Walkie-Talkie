//
//  ViewController.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

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
        advise()
        PIPKit.show(with: pipVC)
        hideAllWhenTappedAround()
    }
    
    override func advise() {
        super.advise()
        caller.videoView.vm = vm.videoVM
        settings.viewModel = vm.settingsVM
        pipVC.viewModel = vm.meVideoVM
    }
    
    private func hideAllWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.dissmissAll))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissAll() {
        settings.alpha = settings.alpha == 0 ? 1 : 0
        pipVC.view.alpha = pipVC.view.alpha == 0 ? 1 : 0
    }
}

