//
//  SpotifyEndPoint.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import Foundation

/// Manages how to query the Spotify New Releases API
struct SpotifyNewReleases  {
    
    enum RequestResult {
        case success(NewReleasesPayload)
        case fail(Error)
    }

    private func parseJSONToModel(_ data: Data) -> RequestResult {
        
        guard let parsedResults = try? JSONDecoder().decode(NewReleasesPayload.self, from: data) else {
            return .fail(NetworkingErrors.jsonParsError)
        }
        return .success(parsedResults)
        
    }
    
    func getSpotifyNewReleases(onCompletion: @escaping  (RequestResult) -> () ) {
        
        let requester = NetworkRequester()
        let newReleases = SpotifyRouter.newReleases
        guard let request = newReleases.generateRequest() else {
            onCompletion(.fail(NetworkingErrors.invalidURLRequest))
            return
        }
        
        requester.performRequest(request: request, useCache: true) { (result) in
            
            switch result {
            case .success(let data):
                DispatchQueue.global(qos: .userInitiated).async {
                    let parsedResults = self.parseJSONToModel(data)
                    DispatchQueue.main.async {
                        switch parsedResults {
                        case .success(let parsedPayload):
                            onCompletion(.success(parsedPayload))
                        case .fail(let error):
                            onCompletion(.fail(error))
                        }
                    }
                }
            case .fail(let error):
                DispatchQueue.main.async {
                    onCompletion(.fail(error))
                }
            }
        }
    }
}

