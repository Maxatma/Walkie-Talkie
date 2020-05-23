//
//  PIPVideoVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import PIPKit


final class PIPVideoVC: BondVC, PIPUsable {
    var vm: PIPVideoVM {
        return viewModel as! PIPVideoVM
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
    
    var initialPosition: PIPPosition {
        return .topRight
    }
    
    var pipSize: CGSize {
        return .init(width: 100, height: 100)
    }
}

