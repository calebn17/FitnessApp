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
    private var ref: CollectionReference { return firestore.collection("users")}
    //public var currentUser: User {}
    
    private init() {}
    
    func canCreateUser(user: User) async throws -> Bool {
        let allUsers = try await ref.getDocuments().documents.compactMap({ User(with: $0.data()) })
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
        try await ref.document(user.username).setData(userInfo.asDictionary() ?? [:])
    }
    
    func getUser(username: String) async throws -> UserInfo? {
        guard let data = try await ref.document(username).getDocument().data() else {return nil}
        return UserInfo(with: data)
    }
    
    func getUser(email: String) async throws -> User? {
        guard let user = try await ref.getDocuments().documents.compactMap({ User(with: $0.data()) }).first(where: {$0.email == email}) else {return nil}
        return user
    }
}
