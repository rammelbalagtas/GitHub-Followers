//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-06.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }

}
