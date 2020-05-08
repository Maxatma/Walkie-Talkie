//
//  SettingsVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond
import WebRTC


final class SettingsVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    
    let microphone = SafePublishSubject<Bool>()
    let sound = SafePublishSubject<Bool>()
    let video = SafePublishSubject<Bool>()
    let hangup = SafePublishSubject<Void>()
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        let audioClient = AudioClient(webRTCService: webRTCClient)
        let videoClient = VideoClient(webRTCService: webRTCClient)
        
        microphone.observeNext { isOn in
            print("microphone on: ", isOn)
            isOn ? audioClient.unmuteAudio() : audioClient.muteAudio()
        }
        .dispose(in: bag)
        
        sound.observeNext { isOn in
            print("sound on: ", isOn)
            isOn ? audioClient.speakerOn() : audioClient.speakerOff()
        }
        .dispose(in: bag)
        
        video.observeNext { isOn in
            print("video on: ", isOn)
            isOn ? videoClient.onVideo() : videoClient.offVideo()
        }
        .dispose(in: bag)
        
        
        hangup.observeNext { _ in
            print("hang up call")
        }
        .dispose(in: bag)
        
    }
}

