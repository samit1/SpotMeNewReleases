//
//  ItemCollectionViewCell.swift
//  SpotMeNewReleases
//
//  Created by Sami Taha on 8/20/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

// MARK: Question
// So I want to make my lastDataTask cancellable when the cell is reused. I know how to do this if I did something along the lines of lastDataTask = session.datatask....
// However, in this case I want reuse my request.performRequest function, since stuff gets cached in there!

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    private var lastRequestURL : URL?
    
    private var lastDataTask : URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
//        lastDataTask?.cancel()
    }
    
    func configureCell(title: String?, imgLink: String?) {
        titleLabel.text = ""
        
        imageView.image = nil
        
        guard let imgLink = imgLink else {
            print("No image url for cell")
            return
        }
        let img = fetchImage(url: imgLink)
        imageView.image = img
        

    }
    
    private func fetchImage(url: String) -> UIImage? {
        
        guard let url = URL(string: url) else {
            return nil
        }
        lastRequestURL = url

        
        let urlRequest = URLRequest(url: url)
        
        var imageFetched : UIImage?
        
        let request = NetworkRequester()
        request.performRequest(request: urlRequest) { [weak self] (result) in
            
            /// Guard against race conditions
            guard self?.lastRequestURL == url else {
                print("return values no longer valid")
                return
            }
            
            switch result {
            case .success(let data):
                guard let img = UIImage(data: data) else {
                    print("img is not convertible")
                    return
                }
                
                imageFetched = img
                
            case .fail(let error):
                print(error)
                
            }
        }
        
        return imageFetched
    }
    
}
