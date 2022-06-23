//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-23.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String //Apple already convert field names from snake case to camel case and vice versa
}
