//
//  MeVideoVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Foundation


final class PIPVideoVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var videoVM: VideoVM!
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        videoVM = VideoVM(webRTCClient: webRTCClient)
    }
}

