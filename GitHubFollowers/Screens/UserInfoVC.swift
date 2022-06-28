//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-27.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButtton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButtton
        
        NetworkManager.shared.getUserInfo(userName: username)
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user.login)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC() {
     dismiss(animated: true)
    }
                                        

}
