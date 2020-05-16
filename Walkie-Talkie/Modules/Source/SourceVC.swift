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
    
    private let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configurePicker()
        // Can't figure out how to pass video not from main bundle to webrtc library
        library.isHidden = true
        advise()
    }
    
    private func configurePicker() {
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        picker.mediaTypes = ["public.movie"]
        picker.allowsEditing = false
    }
    
    override func advise() {
        super.advise()
        
        picker
            .pickedWithInfo
            .map { ($0[.mediaURL] as! URL).path }
            .bind(to: vm.selectInLibrary)
            .dispose(in: bag)
        
        picker
            .pickedWithInfo
            .observeNext { info in
                print("info ", info)
        }
        .dispose(in: bag)
        
        vm.library
            .observeNext { [weak self] _ in
                guard let me = self else { return }
                Router.shared.present(vc: me.picker)
        }
        .dispose(in: bag)
        
        defaultSource.reactive.tap.bind(to: vm.selectDefault).dispose(in: bag)
        library.reactive.tap.bind(to: vm.library).dispose(in: bag)
        camera.reactive.tap.bind(to: vm.camera).dispose(in: bag)
    }
}

