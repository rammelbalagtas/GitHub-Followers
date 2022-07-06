//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-06.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseId = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel   = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavorite(favorite: Follower) {
        userNameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl)
        { [weak self] image in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40),
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
}
