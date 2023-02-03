//
//  GFTabBarController.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 3.02.2023.
//

import UIKit
class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbarApperance = UITabBar.appearance()
        tabbarApperance.tintColor = .systemGreen
        tabbarApperance.backgroundColor = .systemGray5
        viewControllers = [createSearchNC(),createFavoritesNC()]

    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoriteListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }

}
