//
//  RequestResult.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

/// A generic Results enum that represents a successful result or a failed result. 
enum RequestResult {
    case success(Data)
    case fail(Error)
}

