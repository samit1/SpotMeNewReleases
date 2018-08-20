//
//  RecommendationsViewController.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    private var songs = [Item]() {
        didSet {
            newReleasesCollectionView.reloadData()
        }
    }
    
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
    
    private func requestSongs() {
        let requester = SpotifyNewReleases()
        
        requester.getSpotifyNewReleases() { [weak self] (result) in
            switch result {
            case .success(let payload):
                print(payload)
                if let album = payload.albums,
                    let newSongs = album.items {
                    print(self?.songs)
                    self?.songs += newSongs
                }
                
            case .fail(let error):
                print(error)
            }
        }
        
        
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
  
        guard let width = songs[indexPath.row].images?.first?.width,
            let height = songs[indexPath.row].images?.first?.height else {
                return CGSize.zero
        }
        
        let ratio = CGFloat(CGFloat(height) / CGFloat(width))
        
        let newWidth = view.bounds.width
        let newHeight = newWidth * ratio
        
        
        return CGSize(width: newWidth, height: newHeight)
        
    }
}

/*
 NewReleasesPayload(albums: Optional(SpotMeNewReleases.Album(items: Optional([SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("66CXWjxzNUsdJxJ2JdwvnR"), name: Optional("Ariana Grande"))]), id: Optional("5KOu62BJwwCJTfyyAaEbZk"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/a805c2bf76733089771e9d9403ccb25764d72992"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/c8fe45e9cc35bf3bafff3fade16d219e4bb88b75"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/e8e3f12eeee74f5140de30da6bb85ab70e2ac903"), width: Optional(64))]), name: Optional("Sweetener")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("50co4Is1HCEo8bhOyUWKpn"), name: Optional("Young Thug")), SpotMeNewReleases.Artist(id: Optional("1xr2G8Hlx4QWmT9HaUbmoO"), name: Optional("Young Stoner Life Records"))]), id: Optional("4OHfmMUq6xwCo8zfQuc9Rf"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/99404833351cba4c0e0b2b9add62193ccfd89bb7"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/7968429777550657adadc1a2a95c18d7bb92fcfa"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/aea65584802a42e6d70b7f5c9ca64498c8fe3ebf"), width: Optional(64))]), name: Optional("Slime Language")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("7CajNmpbOovFoOoasH2HaY"), name: Optional("Calvin Harris")), SpotMeNewReleases.Artist(id: Optional("2wY79sveU1sp5g7SokKOiI"), name: Optional("Sam Smith")), SpotMeNewReleases.Artist(id: Optional("3KedxarmBCyFBevnqQHy3P"), name: Optional("Jessie Reyez"))]), id: Optional("2tpWgbBdzjkaJVJzR4T8y1"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/b0875765de11e1b6bdfbdd07c2de72e65c02f524"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/fa4598bd87f290b62a4c1c44c5d36d31de110e28"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/869fc500fc980b928e65ed70ffe9e7125e8206f6"), width: Optional(64))]), name: Optional("Promises (with Sam Smith)")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("1mfDfLsMxYcOOZkzBxvSVW"), name: Optional("Cole Swindell"))]), id: Optional("2SxBuClrOCg8WZPXEDobmm"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/e4bcf0b6a196ce16bf944dca5f5b8658787a1b23"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/b5b3c249d10a48d417e38787ff6db61274ff2e7d"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/6c3a6a1f2934a720470fdc233ec742dc8b40861d"), width: Optional(64))]), name: Optional("All of It")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("4qwGe91Bz9K2T8jXTZ815W"), name: Optional("Janet Jackson")), SpotMeNewReleases.Artist(id: Optional("4VMYDCV2IEDYJArk749S6m"), name: Optional("Daddy Yankee"))]), id: Optional("2crbCV0Z1cIwOljKsPnpqJ"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/adea2a57f4ef058fcb387a30a72248f0a472a309"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/3b8f68ad1d94f087eaa590a08c4c31f64c405913"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/26f9b4517d4022302108d1a5d5cdd3145e544022"), width: Optional(64))]), name: Optional("Made For Now")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("3Gm5F95VdRxW3mqCn8RPBJ"), name: Optional("Aminé"))]), id: Optional("4mwO9qIVmngSe7yR5Ios0I"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/28ff8d972db7522a47b1340c8e47e1e678a7106b"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/199a7a8734d53f439a09acdca39086e0593b4d3f"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/0641ad8623d27337c98d58f9adc89fbb11b00399"), width: Optional(64))]), name: Optional("ONEPOINTFIVE")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("64KEffDW9EtZ1y2vBYgq8T"), name: Optional("Marshmello")), SpotMeNewReleases.Artist(id: Optional("7EQ0qTo7fWT7DPxmxtSYEc"), name: Optional("Bastille"))]), id: Optional("78EicdHZr5XBWD7llEZ1Jh"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/13e7cea6399eaaf6cc7ead76e9582f8a9e37dbff"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/600b9b6e68c7d63495d653d544a9bbbbe380f194"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/12702ff263a6686503b26eafff2f3d11d814708a"), width: Optional(64))]), name: Optional("Happier")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("0YrtvWJMgSdVrk3SfNjTbx"), name: Optional("Death Cab for Cutie"))]), id: Optional("6agCM9GJcebduMddgFmgsO"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/6682603902bf1f3da8e7e1f2290802009c55fdad"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/98d215dd15e34e835fff8468eed9ddb80661144c"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/4d949efa81d13a26f4fd5040751028524c439783"), width: Optional(64))]), name: Optional("Thank You for Today")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("2uYWxilOVlUdk4oV9DvwqK"), name: Optional("Mitski"))]), id: Optional("653wRjqO0GOZPQPcXpeAXD"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/a8cb24db3381860f4f28238c35698565b769efe9"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/4277a11fabcaab846088f519dd9a7e0bec7444bd"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/54aa97299ae55579fb17de1a6600cd9c4f6e9669"), width: Optional(64))]), name: Optional("Be the Cowboy")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("4STHEaNw4mPZ2tzheohgXB"), name: Optional("Paul McCartney"))]), id: Optional("5mHdvZojPyBMhgmvQ6HW4U"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/448872237b64d21d229d8a8fd449d286c2fb9b9b"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/3ae57ac4ce5082e23dd0b4a310462e328f40e106"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/750752fc7269df09cf114f795760e77fc8d7899d"), width: Optional(64))]), name: Optional("Fuh You")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("5GDZ6xhBwk7Yja97CFLmV7"), name: Optional("Jillian Jacqueline"))]), id: Optional("1JKqltirWsvh9PJo8EyE4K"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/60a05149bf4e44a434a8d61ce5929d0ec07ac22a"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/353bbec7e488b2487935060c6fa09e0e8597b385"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/8ce42cf92be1555dd8d80157f8fcd48f101c6c43"), width: Optional(64))]), name: Optional("If I Were You (feat. Keith Urban)")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("2IvkS5MXK0vPGnwyJsrEyV"), name: Optional("Eric Church"))]), id: Optional("3MzEGOOseqbJEJVoJTGKfx"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/c7def47043ade3ac2384cdf7b2481f23533f83b9"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/ebe6a72eb4541158431600f93725ed9864fdea56"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/8e37682deafc9c15058c7caae5a554e2b77511ca"), width: Optional(64))]), name: Optional("Heart Like A Wheel")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("3TOqt5oJwL9BE2NG9MEwDa"), name: Optional("Disturbed"))]), id: Optional("5xwNt3DHA2WrOOlfrlZxFg"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/b8a975109fa3113836b8b357050923b35bc78f79"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/8cf9b5cb76700d3f23007ced4cb9413309c9c4b1"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/bf6e570f9c51076246cf44be6f0da91bcbc1a91a"), width: Optional(64))]), name: Optional("Are You Ready")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("5a2EaR3hamoenG9rDuVn8j"), name: Optional("Prince"))]), id: Optional("0CEHFvHUQ0ZSv3mugziS76"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/e3eb36833d2c5096961a83628733ec7c12e6f853"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/446b20447f70f4c78d8d034496c22eb752daf41f"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/746ffb365d1ac547bb7a44bddf32891b704d9ea4"), width: Optional(64))]), name: Optional("Anthology: 1995-2010")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("2jku7tDXc6XoB6MO2hFuqg"), name: Optional("Tory Lanez")), SpotMeNewReleases.Artist(id: Optional("2EMAnMvWE2eb56ToJVfCWs"), name: Optional("Bryson Tiller"))]), id: Optional("5Ezs1ZUquwvBK0vCRt7eVx"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/eb24864602f826f7774ffaafb35292093927dcf9"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/5f09f162b4066cd029b96d72fd6b9dc82a333447"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/16968ffab8235a28a65e674da4ae16a2e9944962"), width: Optional(64))]), name: Optional("Keep In Touch (with Bryson Tiller)")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("4IVAbR2w4JJNJDDRFP3E83"), name: Optional("6LACK"))]), id: Optional("1JIsPeUpWLoDM6YRW0gQk2"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/666d5a994f106d487d4f7ea03569919a9edd9af0"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/5ba6dc114bbb154968c570bc5b9b0f6ef8047438"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/d431125f393bf5b6ec9c74a85f6ae9a66c5a4561"), width: Optional(64))]), name: Optional("Nonchalant")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("1z7b1Pr1rSlvWRzsW3HOrS"), name: Optional("Russ"))]), id: Optional("0O76Y0bvZcocBQ5kNfi6mJ"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/8edcbefd8cccc4a48d0579dcc74fe99f74f94b65"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/44eca21c38e12e205ac09b064595a4002b286112"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/a02b9f3a28c203353cc82fb5d853ad4421847750"), width: Optional(64))]), name: Optional("The Flute Song")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("3PAwspMN27PDm81WwXDsMf"), name: Optional("Reykon")), SpotMeNewReleases.Artist(id: Optional("7ciBW1p3KBsYIkFk4UmwS8"), name: Optional("The Rudeboyz"))]), id: Optional("1gDc7VLwYlcHa3KBISF5jh"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/a8a5b00ecf57f1de54815c831976e1b8bd51e6cf"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/2c5a33ce26a97453a903e8fc44e366c4313da423"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/b00230a956b3d8916772415ede021e0cd76437a4"), width: Optional(64))]), name: Optional("Macarena")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("6i3DxIlAqnDkwELLw4aVrx"), name: Optional("Lele Pons"))]), id: Optional("0gXUZc4bTQzNqLvIyeObHm"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/6f4bcfdd4429de93e576965123ae542a2cddd658"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/8bea92a288d8df2c1c94a5f6c8d4e373c03a016f"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/3bf9b8a9ae3610a23642729de4d0a72899cf3029"), width: Optional(64))]), name: Optional("Celoso")), SpotMeNewReleases.Item(artists: Optional([SpotMeNewReleases.Artist(id: Optional("6pRi6EIPXz4QJEOEsBaA0m"), name: Optional("Chris Tomlin"))]), id: Optional("6ZuWGXRfNLt2G3M1Wx0h38"), images: Optional([SpotMeNewReleases.Image(height: Optional(640), url: Optional("https://i.scdn.co/image/895e424c9c6756a9aa20aea6c07061a1670c6744"), width: Optional(640)), SpotMeNewReleases.Image(height: Optional(300), url: Optional("https://i.scdn.co/image/2439030a26b184425d70728ff8ed0630307e0e6c"), width: Optional(300)), SpotMeNewReleases.Image(height: Optional(64), url: Optional("https://i.scdn.co/image/3b70b00d7cac962c8e430b126fcf7835607e46d3"), width: Optional(64))]), name: Optional("Nobody Loves Me Like You - EP"))]))))
 Optional([])

 
 */
