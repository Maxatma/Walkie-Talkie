//
//  SourceVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond


final class SourceVM: BondViewModel {
    let camera = SafePublishSubject<Void>()
    let library = SafePublishSubject<Void>()
    let selectDefault = SafePublishSubject<Void>()
    var webRTCClient: WebRTCClient!
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        
        camera
            .observeNext { _ in
                //make webrtcclient to work with camera
        }
        .dispose(in: bag)
        
        library
            .observeNext { [weak self] _ in
                guard let me = self else { return }
                me.openVideoGallery()
        }
        .dispose(in: bag)
        
        selectDefault
            .observeNext { _ in
                
        }
        .dispose(in: bag)
    }
    
    func openVideoGallery() {
        let picker = UIImagePickerController()
        //        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        picker.mediaTypes = ["public.movie"]
        picker.allowsEditing = false
        Router.shared.present(vc: picker)
    }
}

