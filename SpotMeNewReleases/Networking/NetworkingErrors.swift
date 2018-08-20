//
//  NetworkingErrors.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation


enum NetworkingErrors : Error {
    case nilDataReturned
    case nonConvertibleResponse
    case jsonParsError
    case invalidURLRequest
}
