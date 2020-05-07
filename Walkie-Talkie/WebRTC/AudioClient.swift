//
//  WebRTCService+Audio Control.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/28/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


final class AudioClient {
    let audioQueue = DispatchQueue(label: "audio")
    private let webRTCService: WebRTCClient!
    
    init(webRTCService: WebRTCClient) {
        self.webRTCService = webRTCService
    }
    
    //MARK: - Public
    
    public func muteAudio() {
        setAudioEnabled(false)
    }
    
    public func unmuteAudio() {
        setAudioEnabled(true)
    }
    
    public func speakerOn() {
        setSpeaker(isOn: true)
    }
    
    public func speakerOff() {
        setSpeaker(isOn: false)
    }
    
    //MARK: - Private
    
    private func setAudioEnabled(_ isEnabled: Bool) {
        let audioTracks = webRTCService.peerConnection.transceivers.compactMap { return $0.sender.track as? RTCAudioTrack }
        audioTracks.forEach { $0.isEnabled = isEnabled }
    }
    
    private func setSpeaker(isOn: Bool) {
        audioQueue.async { [weak self] in
            guard let me = self else {
                return
            }
            
            me.webRTCService.rtcAudioSession.lockForConfiguration()
            //
            do {
                try me.webRTCService.rtcAudioSession.setCategory(AVAudioSession.Category.playAndRecord.rawValue)
                //
                if isOn {
                    try me.webRTCService.rtcAudioSession.overrideOutputAudioPort(.speaker)
                    try me.webRTCService.rtcAudioSession.setActive(true)
                } else {
                    try me.webRTCService.rtcAudioSession.overrideOutputAudioPort(.none)
                }
            } catch let error {
                debugPrint("Error setting AVAudioSession category: \(error)")
            }
            me.webRTCService.rtcAudioSession.unlockForConfiguration()
        }
    }
}

