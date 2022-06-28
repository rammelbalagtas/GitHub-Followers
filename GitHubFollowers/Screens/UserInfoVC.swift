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
        
    }
    
    @objc func dismissVC() {
     dismiss(animated: true)
    }
                                        

}
