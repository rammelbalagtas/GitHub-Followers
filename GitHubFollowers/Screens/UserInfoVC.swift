//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-27.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowerListVC(for username: String)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemsViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getUserInfo()
        layoutUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButtton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButtton
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(userName: username)
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = " GitHub user since \(user.createdAt.convertToMonthYearFormat())"
    }
       
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemsViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemsViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    // add child VC to a container view   
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
                                        

}

extension UserInfoVC: ItemInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        //show safari view controller
        guard let url = URL(string: user.htmlUrl) else
        { presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to the user is invalid.", buttonTitle: "OK")
            return
        }
        
        presentSafariVC(with: url)

    }
    
    func didTapGetFollowers(for user: User) {
        dismiss(animated: true)
        guard user.followers != 0 else
        {
            presentGFAlertOnMainThread(title: "No followers", message: "These users does not have followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowerListVC(for: user.login)
    }
}
