//
//  BaseServiceError.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Foundation


public enum BaseServiceError: Error {
    case unknown
    case serverBaseURLisNotConfigurated
    case unAuthorized
    case cantCreateURLComponents
    case cantCreateURLFromComponents
    case noFirebaseToken
    case errorFromServer(message: String)
    case parsingError(message: String)
    case dataBaseError
}
