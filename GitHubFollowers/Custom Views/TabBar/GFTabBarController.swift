//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-06.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavVC(), createFavoritesListNavVC()]
    }
    
    func createSearchNavVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesListNavVC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Search"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites , tag: 1)
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
