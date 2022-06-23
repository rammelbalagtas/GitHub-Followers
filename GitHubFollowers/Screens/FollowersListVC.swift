//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-23.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}
