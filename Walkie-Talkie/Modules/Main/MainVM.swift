//
//  MainVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Foundation


final class MainVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var joinVM: JoinVM!
    var videoVM: VideoVM!
    
    override init() {
        super.init()
        webRTCClient = WebRTCClient(iceServers: Config.shared.iceServers)
        joinVM = JoinVM(webRTCClient: webRTCClient)
        videoVM = VideoVM(webRTCClient: webRTCClient)
        meVideoVM = PIPVideoVM(webRTCClient: webRTCClient)
    }
}

