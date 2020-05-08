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
    var videoSource: VideoSource!
    
    init(webRTCClient: WebRTCClient, videoSource: VideoSource) {
        super.init()
        self.webRTCClient = webRTCClient
        self.videoSource = videoSource
    }
    
    func startRender(view: RTCVideoRenderer) {
        switch videoSource! {
        case .remote:
            webRTCClient.renderRemoteVideo(to: view)
        case .localCamera:
            webRTCClient.startCaptureLocalCameraVideo(renderer: view)
        case let .localFile(name):
            webRTCClient.startCaptureLocalVideoFile(name: name, renderer: view)
        }
        webRTCClient.startCaptureLocalVideoFile(name: "cat.mp4", renderer: view)
    }
}


enum VideoSource {
    case remote
    case localCamera
    case localFile(name: String)
}
