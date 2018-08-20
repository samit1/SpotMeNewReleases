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


/*
 Optional(["Content-Type": "application/json", "Authorization": "Bearer BQDc0Vc5SRUatMBKRsLkXq8nRtD8_9lPHs4vctduxTyYBnRybVW2ja3ElWjKWjzJprhutV1xljBxSljTdukzgm0dlZddKbObIO3psd3V-5pCMRQ9fURxdw-MLh6-034D3OUVmlc0IdGBAR1H8eo"])
 Optional(["Content-Type": "application/json", "Authorization": "Bearer BQDc0Vc5SRUatMBKRsLkXq8nRtD8_9lPHs4vctduxTyYBnRybVW2ja3ElWjKWjzJprhutV1xljBxSljTdukzgm0dlZddKbObIO3psd3V-5pCMRQ9fURxdw-MLh6-034D3OUVmlc0IdGBAR1H8eo"])
 */
