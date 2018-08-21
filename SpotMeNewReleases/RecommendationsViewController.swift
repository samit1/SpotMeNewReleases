//
//  RecommendationsViewController.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {
    
    /// Holds the list of new releases. Anytime it is set, the entire collectionview will reload. This guaruntees the model is synced with the view.
    private var songs = [Item]() {
        didSet {
            newReleasesCollectionView.reloadData()
        }
    }
    
    /// Responsible for showing the new releases to the user.
    private lazy var newReleasesCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ItemCollectionViewCell.Constants.xibIdentifier, bundle: nil), forCellWithReuseIdentifier: ItemCollectionViewCell.Constants.reuseIdentifier)
        
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundColor(.brown)
        addSubviews()
        addConstraints()
        requestSongs()
    }
    
    /// Requests the newly released songs
    private func requestSongs() {
        let requester = SpotifyNewReleases()
        
        requester.getSpotifyNewReleases() { [weak self] (result) in
            switch result {
            case .success(let payload):
                print(payload)
                if let album = payload.albums,
                    let newSongs = album.items {
                    self?.songs += newSongs
                } else {
                    print("album or songs were nil")
                }
                
            case .fail(let error):
                print(error)
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(newReleasesCollectionView)
    }
    
    private func addConstraints() {
        let margins = view.safeAreaLayoutGuide
        newReleasesCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        newReleasesCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        newReleasesCollectionView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        newReleasesCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    private func changeBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

extension RecommendationsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.Constants.reuseIdentifier, for: indexPath)
        
        
        if let cell = cell as? ItemCollectionViewCell {
            let item = songs[indexPath.row]
            /// This is why I don't love making my entire model optional
            /// Each song has an array of images. I just take the first image
            if let imgURL = item.images?.first?.url,
                let name = item.name {
                cell.configureCell(title: name, imgLink: imgURL)
            }
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return songs.count > 0 ? 1 : 0
    }
}

extension RecommendationsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /// This is why I don't love making my entire model optional
        /// Each song has an array of images. I just take the first image
        guard let width = songs[indexPath.row].images?.first?.width,
            let height = songs[indexPath.row].images?.first?.height else {
                return CGSize(width: view.bounds.width, height: view.bounds.height)
        }
        
        let ratio = CGFloat(CGFloat(height) / CGFloat(width))
        
        let newWidth = view.bounds.width
        let newHeight = newWidth * ratio
        
        
        return CGSize(width: newWidth, height: newHeight)
        
    }
}
