//
//  GFItemInfoView.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 31.01.2023.
//

import UIKit

enum ItemInfoType{
    case repos,gists,following,followers
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titlaLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titlaLabel)
        addSubview(countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        titlaLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titlaLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titlaLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titlaLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titlaLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType,with count:Int){
        
        countLabel.text = String(count)
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titlaLabel.text = "Public Repos"
            countLabel.text = String(count)
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titlaLabel.text = "Public Gists"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titlaLabel.text = "Following"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titlaLabel.text = "followers"
        }
        
    }
    
}
