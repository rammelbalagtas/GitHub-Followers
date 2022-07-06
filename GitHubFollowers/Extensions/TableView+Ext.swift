//
//  TableView+Ext.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-06.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
