//
//  SpotifyEndPoint.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

struct SpotifyEndPointRequester : EndPointType {
    
    var baseURL = "https://api.spotify.com"
    var oAuthToken = "BQA2Bnbvh2iBwy-6ndSpXdn9UJgvEhBaARyCGfkCeHNPBf13rLxGDtYmSdn1D_Vu1OILXPjqtW-los5YCWjETKhvHbK2PNbLtd5JKcUX1vNAD8pbTnKBMhFpPVG7s96wn0jDnE5jw-7-8P2G9_w"
    var endPoint = endPoints.newReleases.rawValue
    
    
    
    enum endPoints : String {
        case newReleases = "/v1/browse/new-releases"
    }
    
    
    
    
}
