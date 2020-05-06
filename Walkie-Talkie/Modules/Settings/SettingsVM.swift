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

        microphone.observeNext { isOn in
            isOn ? audioClient.unmuteAudio() : audioClient.muteAudio()
        }
        sound.observeNext { isOn in
            isOn ? audioClient.speakerOn() : audioClient.speakerOff()
        }
        video.observeNext { isOn in
            isOn ? webRTCClient.onVideo() : webRTCClient.offVideo()
        }
        
        hangup.observeNext { isOn in
            print("hang up call")
        }
    }
}

