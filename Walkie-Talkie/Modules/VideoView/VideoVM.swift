//
//  MyVideoVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/6/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


final class VideoVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
    }
    
    func startRender(view: RTCVideoRenderer) {
        webRTCClient.startCaptureLocalVideoFile(name: "cat.mp4", renderer: view)
    }
}

