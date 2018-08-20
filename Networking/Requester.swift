//
//  Networking.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

struct NetworkRequester {
    
    private var sharedSession : URLSession = {
        let sharedSession = URLSession(configuration: .default)
        return sharedSession
    }()
    
    private var cache : URLCache = {
        let cache = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024, diskPath: nil)
        return cache
    }()
    
    
    
    private func createURLRequest(endPoint: EndPointType, additionalParams: [String: String] ) -> URLRequest? {
        
        guard var components = URLComponents(string: endPoint.baseURL) else {
            print("base path failed url conversion")
            return nil
        }
        
        
        components.path = endPoint.endPoint
        
        /* create base params */
        
        let baseParams = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer " + endPoint.oAuthToken
        ]
        
        var queryComponents = [URLQueryItem]()
        
        for (key, value) in baseParams {
            let queryItem = URLQueryItem(name: key, value: value)
            queryComponents.append(queryItem)
        }
        
        for (key, value) in additionalParams {
            let queryItem = URLQueryItem(name: key, value: value)
            queryComponents.append(queryItem)
        }
        
        components.queryItems = queryComponents
        
        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
        
    }
    
    func performRequest(request: URLRequest, onCompletion: @escaping (RequestResult) -> ()) {
        
        if let response = cache.cachedResponse(for: request) {
            DispatchQueue.main.async {
                onCompletion(.success(response.data))
            }
        } else {
            let task = sharedSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data else {
                        onCompletion(.fail(NetworkingErrors.nilDataReturned))
                        return
                    }
                    
                    guard let response = response else {
                        onCompletion(.fail(NetworkingErrors.nonConvertibleResponse))
                        return
                    }
                    
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    
                    self.cache.storeCachedResponse(cachedResponse, for: request)
                    onCompletion(.success(data))
                }
            }
            task.resume()
        }
    }
}
