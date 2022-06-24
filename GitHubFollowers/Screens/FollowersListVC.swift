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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(userName: userName, page: 1)
        { followers, errorMessage in
            guard
                let followers = followers else {
                if let errorMessage = errorMessage {
                    self.presentGFAlertOnMainThread(title: "Error", message: errorMessage.rawValue, buttonTitle: "OK")
                }
                return
            }
            
            print(followers.count)

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
