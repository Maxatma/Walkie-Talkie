//
//  MeVideoVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import WebRTC
import PIPKit


final class MeVideoVC: BondVC, PIPUsable {
    var vm: MeVideoVM {
        return viewModel as! MeVideoVM
    }
    
    @IBOutlet var video: VideoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        advise()
        hideKeyboardWhenTappedAround()
    }
    
    override func advise() {
        super.advise()
        video.vm = vm.videoVM
    }
}


