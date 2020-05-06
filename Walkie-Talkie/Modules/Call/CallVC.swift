//
//  ViewController.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import WebRTC


final class CallVC: BondVC {
    var vm: CallVM {
        return viewModel as! CallVM
    }
    
    @IBOutlet var caller: WebRTCView!
    @IBOutlet var join: JoinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        advise()
    }
    
    override func advise() {
        super.advise()
        caller.videoView.vm = vm.videoVM
        join.viewModel = vm.joinVM
        
        //        vm.webRTCClient.startCaptureLocalVideoFile(name: "cat.mp4", renderer: me)
        //        vm.webRTCClient.renderRemoteVideo(to: caller.videoView)
        
    }
}

