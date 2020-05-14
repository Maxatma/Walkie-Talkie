//
//  MainVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit


final class MainVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var joinVM: JoinVM!
    var videoVM: VideoVM!
    
    let selectSource = SafePublishSubject<Void>()
    let selectID = SafePublishSubject<Void>()
    
    override init() {
        super.init()
        webRTCClient = WebRTCClient(iceServers: Config.shared.iceServers)
        joinVM = JoinVM(webRTCClient: webRTCClient)
        videoVM = VideoVM(webRTCClient: webRTCClient, videoSource: .localFile(name: "cat.mp4"))
        
        selectSource
            .observeNext { [weak self] _ in
                guard let me = self else { return }
                Router.shared.showSource(webRTCClient: me.webRTCClient)
        }
        .dispose(in: bag)
        
        selectID
            .observeNext { _ in
                Router.shared.showContacts()
        }
        .dispose(in: bag)
    }
}

