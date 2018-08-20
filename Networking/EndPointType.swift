//
//  EndPointType.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    var baseURL : String { get }
    var oAuthToken : String { get }
    var endPoint: String { get }
}
