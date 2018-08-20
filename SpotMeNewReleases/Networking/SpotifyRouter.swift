//
//  SpotifyEndPoint.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

enum SpotifyRouter {
    case newReleases
    
    private static let baseURL = "https://api.spotify.com"
    private static let authorization = "Bearer \(key)"
    private static let key = "BQDt2Ea2MF4DP2bZ_dh_6cOfLRFp2w8-KbvfGiHhR9a-7ExUuklWU2ZyYxZQf8sI2bWH1FnSsO-LFlZqaUzpv2qWQ_NxUoL3N6kpwMphmccZYLQLbXlR8BUTdJgRnKv14kviK2LFIguHh3LoQUo"
    
    private var path : String {
        switch self {
        case .newReleases:
            return "/v1/browse/new-releases"
        }
    }
    
    private var parameters : [String : String] {
        switch self {
        case .newReleases:
            return [:]
        }
    }
    
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

