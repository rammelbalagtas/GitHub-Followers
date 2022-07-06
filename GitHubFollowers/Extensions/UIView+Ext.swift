//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-06.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
