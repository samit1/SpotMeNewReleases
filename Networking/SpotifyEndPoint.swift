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
    var oAuthToken =  "BQDc0Vc5SRUatMBKRsLkXq8nRtD8_9lPHs4vctduxTyYBnRybVW2ja3ElWjKWjzJprhutV1xljBxSljTdukzgm0dlZddKbObIO3psd3V-5pCMRQ9fURxdw-MLh6-034D3OUVmlc0IdGBAR1H8eo"
    var endPoint = endPoints.newReleases.rawValue
    
    
    
    enum endPoints : String {
        case newReleases = "/v1/browse/new-releases"
    }
    
    
    
    
}
//
//
//Authorization: Bearer BQDc0Vc5SRUatMBKRsLkXq8nRtD8_9lPHs4vctduxTyYBnRybVW2ja3ElWjKWjzJprhutV1xljBxSljTdukzgm0dlZddKbObIO3psd3V-5pCMRQ9fURxdw-MLh6-034D3OUVmlc0IdGBAR1H8eo
//Authorization": "Bearer BQDc0Vc5SRUatMBKRsLkXq8nRtD8_9lPHs4vctduxTyYBnRybVW2ja3ElWjKWjzJprhutV1xljBxSljTdukzgm0dlZddKbObIO3psd3V-5pCMRQ9fURxdw-MLh6-034D3OUVmlc0IdGBAR1H8eo
