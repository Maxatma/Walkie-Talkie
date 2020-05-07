//
//  Config.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/27/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Foundation


final class Config {
    static let shared = Config()
    
    var iceServers = ["stun:stun.l.google.com:19302",
                      "stun:stun1.l.google.com:19302",
                      "stun:stun2.l.google.com:19302",
                      "stun:stun3.l.google.com:19302",
                      "stun:stun4.l.google.com:19302"]
}

