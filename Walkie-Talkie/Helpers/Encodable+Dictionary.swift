//
//  Encodable+Dictionary.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/7/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Foundation


extension Encodable {
    func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        guard let dictionary = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return [String: Any]()
        }
        return dictionary
    }
}

