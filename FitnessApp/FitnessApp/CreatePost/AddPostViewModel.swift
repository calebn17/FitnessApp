//
//  AddPostViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import Foundation

struct RunPostModel: Codable {
    let id: String
    let name: String
    let duration: Double
    let distance: Double
    let avgSpeed: String
    let dateCreated: String
}

struct RunPostViewModel: Codable {
    let username: String
    let profilePictureURL: URL?
    let likers: [String]
    let actionsTaken: [PostActions]
    let postType: PostType
    let model: RunPostModel
}

struct LiftPostModel: Codable {
    
}

struct LiftPostViewModel: Codable {
    let username: String
    let profilePictureURL: URL?
    let likers: [String]
    let actionsTaken: [PostActions]
    let model: LiftPostModel
}

struct MetconPostModel: Codable {
    
}

struct MetconPostViewModel: Codable {
    let username: String
    let profilePictureURL: URL?
    let likers: [String]
    let actionsTaken: [PostActions]
    let model: MetconPostModel
}

struct AddPostViewModel {
    
    var currentUser: User { return DatabaseManager.shared.currentUser }
    
    static func insertRunPost(runName: String, duration: Double, distance: Double, date: Date) async throws {
        let speed = String(duration/distance)
        let dateCreated = String(Date().timeIntervalSince1970)
        
        let model = RunPostModel(
            id: "\(Int.random(in: 0...1000))_\(UUID().uuidString)",
            name: runName,
            duration: duration,
            distance: distance,
            avgSpeed: speed,
            dateCreated: dateCreated
        )
        let viewModel = RunPostViewModel(
            username: DatabaseManager.shared.currentUser.username,
            profilePictureURL: nil,
            likers: [],
            actionsTaken: [],
            postType: .run,
            model: model
        )
        try await DatabaseManager.shared.insertRunPost(runVM: viewModel)
    }
}
