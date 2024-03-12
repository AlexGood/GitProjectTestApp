//
//  GitHubUser.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 29.02.2024.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var login: String
    var avatarUrl: String
    var htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}

