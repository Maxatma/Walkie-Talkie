//
//  SdpType.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


enum SdpType: String, Codable {
    case offer, prAnswer, answer
    
    var rtcSdpType: RTCSdpType {
        switch self {
        case .offer:    return .offer
        case .answer:   return .answer
        case .prAnswer: return .prAnswer
        }
    }
}

