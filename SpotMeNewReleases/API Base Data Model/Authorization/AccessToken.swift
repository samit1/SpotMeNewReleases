//
//  AccessToken.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/21/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 21, 2018

import Foundation

struct AccessToken : Codable {
    
    let accessToken : String
    let expiresIn : Int
    let scope : String
    let tokenType : String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case scope = "scope"
        case tokenType = "token_type"
    }

    
}
