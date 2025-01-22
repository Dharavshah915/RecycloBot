//
//  DatabaseManager.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() { }
    private let database = Firestore.firestore()
    let leaderboard = "leaderboard"
    let users = "users"
    
    // Fetch Leaderboards
    func fetchLeaderboards() async throws -> [LeaderboardUser] {
        let snapshot = try await database.collection(leaderboard).getDocuments()
        print(snapshot.documents)
        print(snapshot.documents.first?.data())
        
        // getting the leaders from the database
        return try snapshot.documents.compactMap( { try $0.data(as: LeaderboardUser.self)})
    }
    
    
    // Post (Update) Leaderboards for current user
    func postScoreUpdateFor(leader: LeaderboardUser) async
    throws {
        let data = try Firestore.Encoder().encode(leader)
        try await database.collection(leaderboard).document(leader.username).setData(data, merge: false)
    }
    
    func fetchUserMetaData(username: String) async throws -> wasteMetaData? {
        let snapshot = try await database.collection("users").whereField("username", isEqualTo: username).getDocuments()
        
        // Check if a document was found
        guard let document = snapshot.documents.first else {
            print("No user found with username: \(username)")
            return nil
        }
        
        // Convert the document data into a LeaderboardUser object
        return try document.data(as: wasteMetaData.self)
    }
}
