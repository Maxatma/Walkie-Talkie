//
//  MainVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//
import UIKit
import WebRTC
import PIPKit


final class MainVC: BondVC {
    var vm: MainVM {
        return viewModel as! MainVM
    }
    
    @IBOutlet var myVideo: VideoView!
    @IBOutlet var join: JoinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        advise()
    }
    
    override func advise() {
        super.advise()
        myVideo.vm = vm.videoVM
        join.viewModel = vm.joinVM
    }
}

