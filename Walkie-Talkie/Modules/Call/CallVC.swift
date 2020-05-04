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

    @IBOutlet var me: RTCEAGLVideoView!
    @IBOutlet var caller: WebRTCView!
    @IBOutlet var create: UIButton!
    @IBOutlet var join: UIButton!
    @IBOutlet var roomID: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        advise()
        hideKeyboardWhenTappedAround()
        vm.webRTCClient.startCaptureLocalVideoFile(name: "cat.mp4", renderer: me)
        vm.webRTCClient.renderRemoteVideo(to: caller.videoView)
    }

    override func advise() {
        super.advise()
        create.reactive.tap.bind(to: vm.create).dispose(in: bag)
        join.reactive.tap.bind(to: vm.join).dispose(in: bag)
        roomID.reactive.text.ignoreNil().bind(to: vm.roomID).dispose(in: bag)
        vm.roomID.bind(to: roomID.reactive.text).dispose(in: bag)
    }
}

