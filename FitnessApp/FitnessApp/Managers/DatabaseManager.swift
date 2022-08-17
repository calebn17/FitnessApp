//
//  DatabaseManager.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let firestore = Firestore.firestore()
    private var userRef: CollectionReference { return firestore.collection("users") }
    private var postRef: CollectionReference { return firestore.collection("posts") }
    private var postRunRef: CollectionReference { return postRef.document("run").collection("run_posts") }
    public var currentUser: User {
        return User(
            username: UserDefaults.standard.string(forKey: K.username) ?? "",
            email: UserDefaults.standard.string(forKey: K.email) ?? ""
        )
    }
    
    private init() {}
    
//MARK: - User
    func canCreateUser(user: User) async throws -> Bool {
        let allUsers = try await userRef.getDocuments().documents.compactMap({ User(with: $0.data()) })
        return !allUsers.contains(where: {$0.username == user.username || $0.email == user.email})
    }
    
    func insertUser(user: User) async throws {
        let userInfo = UserInfo(
            userID: UUID().uuidString,
            username: user.username,
            email: user.email,
            dateCreated: String(Date().timeIntervalSince1970),
            bio: nil
        )
        try await userRef.document(user.username).setData(userInfo.asDictionary() ?? [:])
    }
    
    func getUser(username: String) async throws -> UserInfo? {
        guard let data = try await userRef.document(username).getDocument().data() else {return nil}
        return UserInfo(with: data)
    }
    
    func getUser(email: String) async throws -> User? {
        guard let user = try await userRef.getDocuments().documents.compactMap({ User(with: $0.data()) }).first(where: {$0.email == email}) else {return nil}
        return user
    }
    
//MARK: - Run Posts
    func insertRunPost(runVM: RunPostViewModel) async throws {
        try await userRef.document(currentUser.username).collection("run").document(runVM.model.id).setData(runVM.model.asDictionary() ?? [:])
        try await postRef.document("run").collection("run_posts").document(runVM.model.id).setData(runVM.asDictionary() ?? [:])
    }
    
    func getRunPosts() async throws -> [RunPostViewModel]? {
        return try await postRunRef.getDocuments().documents.compactMap({ RunPostViewModel(with: $0.data()) })
    }
}
