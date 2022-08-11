//
//  User.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation


struct User: Codable {
    let username: String
    let email: String
}

struct UserInfo: Codable {
    let userID: String
    let username: String
    let email: String
    let dateCreated: String
    let bio: String?
}
