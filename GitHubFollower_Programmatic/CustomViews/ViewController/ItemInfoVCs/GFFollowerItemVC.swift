//
//  GFFollowerItemVC.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 1.02.2023.
//

import Foundation
class GFFollowerItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
