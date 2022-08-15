//
//  PostViewModelTypes.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import Foundation

enum Post {
    case owner(viewModel: OwnerPostViewModel)
    case post(viewModel: PostPostViewModel)
    case likes(viewModel: LikesPostViewModel)
    case actions(viewModel: ActionsPostViewModel)
    case timestamp(viewModel: TimestampPostViewModel)
}

enum PostTypes {
    case run
    case lift
    case metcon
}

enum PostActions {
    case like
    case comment
    case share
}

struct OwnerPostViewModel {
    let profilePictureURL: URL?
    let username: String
}

struct PostPostViewModel {
    let type: PostTypes
    let body: String
}

struct ActionsPostViewModel {
    let action: PostActions
}

struct LikesPostViewModel {
    let likers: [String]
}

struct TimestampPostViewModel {
    let dateCreatedString: String
}
