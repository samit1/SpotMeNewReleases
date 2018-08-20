//
//  RequestResult.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

enum RequestResult {
    case success(Data)
    case fail(Error)
}

