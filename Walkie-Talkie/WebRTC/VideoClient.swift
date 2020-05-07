//
//  VideoClient.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


final class VideoClient {
    private let webRTCService: WebRTCClient!
    
    init(webRTCService: WebRTCClient) {
        self.webRTCService = webRTCService
    }
    
    //MARK: - Public
    
    public func offVideo() {
        setVideoEnabled(false)
    }
    
    public func onVideo() {
        setVideoEnabled(true)
    }
    
    //MARK: - Private
    
    private func setVideoEnabled(_ isEnabled: Bool) {
        let audioTracks = webRTCService.peerConnection.transceivers.compactMap { return $0.sender.track as? RTCVideoTrack }
        audioTracks.forEach { $0.isEnabled = isEnabled }
    }
}

