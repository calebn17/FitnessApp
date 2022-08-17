//
//  PostViewModelTypes.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import Foundation

enum PostCellType {
    case owner(viewModel: OwnerPostViewModel)
    case post(viewModel: PostPostViewModel)
    case likes(viewModel: LikesPostViewModel)
    case actions(viewModel: ActionsPostViewModel)
    case timestamp(viewModel: TimestampPostViewModel)
}

public enum PostType: String, Codable {
    case run = "Run"
    case lift = "Lift"
    case metcon = "Metcon"
}

enum PostActions: Codable {
    case liked
    case commented
    case shared
}

struct OwnerPostViewModel {
    let profilePictureURL: URL?
    let username: String
}

struct PostPostViewModel {
    let type: PostType
    let name: String
    let body: String
}

struct ActionsPostViewModel {
    let actionsTaken: [PostActions]
}

struct LikesPostViewModel {
    let likers: [String]
}

struct TimestampPostViewModel {
    let dateCreatedString: String
}
