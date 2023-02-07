//
//  GFAvatarImageView.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeHolderImage = Images.placholder
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure()  {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromUrl url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeHolderImage
        }
        
//        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
//            guard let self = self else {return}
//            DispatchQueue.main.async { self.image = image }
//        }
    }
}
