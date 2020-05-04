//
//  WebRTCService+RTCDataChannelDelegate.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/28/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


extension WebRTCClient: RTCDataChannelDelegate {
    
    func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        debugPrint("dataChannel did change state: \(dataChannel.readyState)")
    }
    
    func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        delegate?.webRTCClient(self, didReceiveData: buffer.data)
    }
}

