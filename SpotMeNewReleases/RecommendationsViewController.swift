//
//  RecommendationsViewController.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    private var songs = [Item]()
    
    private lazy var newReleasesCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        
        let requester = SpotifyNewReleases()
        
        requester.getSpotifyNewReleases() { (result) in
            switch result {
            case .success(let payload):
                print(payload)
            case .fail(let error):
                print(error)
            }
        }
        
        
    }
}

extension RecommendationsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return songs.count > 0 ? 1 : 0
    }
    
    
    
}
