//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import FirebaseAuth

struct HomeViewModel {
    
    var isNotAuthenticated: Bool { Auth.auth().currentUser == nil }
    var currentUser: User { return DatabaseManager.shared.currentUser }
    @MainActor let observablePosts = Observable<[[PostCellType]]>([])
    
    
    @MainActor func fetchPosts() async throws {
        guard var runPostViewModels = try await DatabaseManager.shared.getRunPosts() else {return}
        
        runPostViewModels.sort { post1, post2 in
            post1.model.dateCreated > post2.model.dateCreated
        }
        
        let runPosts: [[PostCellType]] = runPostViewModels.compactMap { viewModel in
            let postCell: [PostCellType] = [
                .owner(
                    viewModel:
                        OwnerPostViewModel(
                            profilePictureURL: viewModel.profilePictureURL,
                            username: viewModel.username
                        )
                ),
                .post(
                    viewModel:
                        PostPostViewModel(
                            type: viewModel.postType,
                            name: viewModel.model.name,
                            body: "\(viewModel.model.distance) miles | \(viewModel.model.duration) min | \(viewModel.model.avgSpeed) min/mi"
                        )
                ),
                .likes(
                    viewModel:
                        LikesPostViewModel(
                            likers: viewModel.likers
                        )
                ),
                .timestamp(
                    viewModel:
                        TimestampPostViewModel(
                            dateCreatedString: String.date(from: Date(timeIntervalSince1970: Double(viewModel.model.dateCreated) ?? 0.0) ) ?? ""
                        )
                ),
                .actions(
                    viewModel:
                        ActionsPostViewModel(
                            id: viewModel.model.id,
                            likers: viewModel.likers,
                            type: viewModel.postType
                        )
                )
                
            ]
            return postCell
        }
        let posts = runPosts
        self.observablePosts.value = posts
    }
    
    static func insertLike(viewModel: ActionsPostViewModel, liked: Bool) async throws {
        try await DatabaseManager.shared.updateLikeStatus(postID: viewModel.id, postType: viewModel.type, liked: liked)
    }
}
