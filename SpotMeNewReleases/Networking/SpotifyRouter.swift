//
//  SpotifyEndPoint.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

/// Manages how a URL request should be created based on the endpoint used.
enum SpotifyRouter {
    case newReleases
    
    // MARK: QUESTION: I have no idea how to deal with authorization. Trying to request my credentials on their site returns authorization errors. https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow
    // As such, I am manually typing in my bearer key but it expires every so often. 
    private static let baseURL = "https://api.spotify.com"
    private static let authorization = "Bearer \(key)"
    private static let key = "BQA7g0b3bfjw9OX499qrpsnAXRSGUff5nNOf_AC_a8wq3L0_tOUHBH5d48rl1S-By9PXrc_itEQ_grd1PuOJbnc1JguBzm8mepGrVcAKRq2qrIn0LL4wMq229gcAxvO1Xb8KYk78Kfbh9fJPQ9U"
    
    /// API Endpoint
    private var path : String {
        switch self {
        case .newReleases:
            return "/v1/browse/new-releases"
        }
    }
    
    /// Optional parameters to include for API
    private var parameters : [String : String] {
        switch self {
        case .newReleases:
            return [:]
        }
    }
    
    /// Generates a URLRequest if possible, based on which endpoint was chosen
    /// - NOTE: URLRequest includes the authorization and content-type parameters
    func generateRequest() -> URLRequest? {
        
        var components = URLComponents(string: SpotifyRouter.baseURL)
        components?.path = path
        
        var queryItems = [URLQueryItem]()
        for param in parameters {
            queryItems.append(URLQueryItem(name: param.key, value: param.value))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            print("invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(SpotifyRouter.authorization, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
        
    }
}

