//
//  SourceVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit


final class SourceVC: BondVC {
    var vm: SourceVM {
        return viewModel as! SourceVM
    }
    
    @IBOutlet var defaultSource: UIButton!
    @IBOutlet var library: UIButton!
    @IBOutlet var camera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        advise()
    }
    
    override func advise() {
        super.advise()
        defaultSource.reactive.tap.bind(to: vm.selectDefault).dispose(in: bag)
        library.reactive.tap.bind(to: vm.library).dispose(in: bag)
        camera.reactive.tap.bind(to: vm.camera).dispose(in: bag)
    }
}

