//
//  Networking.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

/// Generic manager that manages networking activites. Requests should be made through this interface if possible.
/// - NOTE: Caching is used. 
struct NetworkRequester {
    
    /// Shared URLSession
    private var sharedSession : URLSession = {
        let sharedSession = URLSession(configuration: .default)
        return sharedSession
    }()
    
    /// Cache for URLRequests
    /// Everytime this is instantiated the cache is cleared.
    private var cache : URLCache = {
        // MARK: QUESTION:
        /// How does one going about choosing a memory capcity? I found this on SO
        let cache = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 0, diskPath: nil)
        cache.removeAllCachedResponses()
        return cache
    }()
    
    /// Performs a URL Request.
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
