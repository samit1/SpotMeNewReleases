//
//  RecommendationsViewController.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        
        let requester = NetworkRequester()
        let spotifyEndPoint = SpotifyEndPointRequester()
        guard let request = requester.createURLRequest(endPoint: spotifyEndPoint, additionalParams: [:]) else {
            return
        }
        
        requester.performRequest(request: request) { (result) in
            switch result {
            case .success(let data):
                print(String(data: data, encoding: String.Encoding.utf8)!)
                
            case .fail(let error):
                print(error)
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

