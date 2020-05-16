//
//  SourceVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond
import WebRTC


final class SourceVM: BondViewModel {
    let camera = SafePublishSubject<Void>()
    let library = SafePublishSubject<Void>()
    let selectDefault = SafePublishSubject<Void>()
    var webRTCClient: WebRTCClient!
    let selectInLibrary = SafePublishSubject<String>()

    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        
        camera
            .observeNext { _ in
                webRTCClient.change(localVideoSource: .camera)
                Router.shared.pop()
        }
        .dispose(in: bag)
        
        selectInLibrary
            .observeNext { name in
                webRTCClient.change(localVideoSource: .file(name: name))
                Router.shared.pop()
        }
        .dispose(in: bag)

        
        selectDefault
            .observeNext { _ in
                webRTCClient.change(localVideoSource: .file(name: "cat.mp4"))
                Router.shared.pop()
        }
        .dispose(in: bag)
    }
}

