//
//  File.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/2/20.
//  Copyright © 2020 Stas Seldin. All rights reserved.
//

import WebRTC


protocol WebRTCClientDelegate: class {
    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate)
    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState)
    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data)
}

