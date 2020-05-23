//
//  CallVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/25/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond
import WebRTC


final class CallVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var settingsVM: SettingsVM!
    var videoVM: VideoVM!
    var meVideoVM: PIPVideoVM!
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        settingsVM = SettingsVM(webRTCClient: webRTCClient)
        videoVM = VideoVM(webRTCClient: webRTCClient, videoSource: .remote)
        meVideoVM = PIPVideoVM(webRTCClient: webRTCClient, videoSource: VideoSource(localVideoSource: webRTCClient.localVideoSource))
    }
}

