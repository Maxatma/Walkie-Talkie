//
//  MyVideoView.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/6/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


final class VideoView: RTCEAGLVideoView {
    var vm: VideoVM! {
        didSet {
            advise()
        }
    }
    
    func advise() {
        vm.startRender(view: self)
    }
}

