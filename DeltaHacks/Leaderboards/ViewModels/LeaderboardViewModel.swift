//
//  LeaderboardViewModel.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import Foundation

class LeaderboardViewModel: ObservableObject {
    
    @Published var leaderResult = LeaderboardResult(user: nil, top10: [])
    
    var mockData = [
        LeaderboardUser(username: "Tory", count: 100),
        LeaderboardUser(username: "Drake", count: 90),
        LeaderboardUser(username: "Nicki", count: 80),
        LeaderboardUser(username: "Travis", count: 70),
        LeaderboardUser(username: "Carti", count: 70)
    ]
    
    init() {
        Task {
            do {
                let result = try await fetchLeaderboards()
                DispatchQueue.main.async {
                    self.leaderResult = result
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    struct LeaderboardResult {
        let user: LeaderboardUser?
        let top10: [LeaderboardUser]
    }
    
    func fetchLeaderboards() async throws -> LeaderboardResult {
        let leaders = try await DatabaseManager.shared.fetchLeaderboards()
        let top10 = Array(leaders.sorted(by: { $0.count > $1.count}).prefix(10))
        let username = UserDefaults.standard.string(forKey: "username")
        
        // Handle if username is nil
        if let username = username, !top10.contains(where: { $0.username == username}) {
            let user = leaders.first(where: { $0.username == username })
            return LeaderboardResult(user: user, top10: top10)
            
        } else {
            return LeaderboardResult(user: nil, top10: top10)
        }
    }
    
    func postScoreUpadteForUser(username: String, count: Int) async throws {
        try await DatabaseManager.shared.postScoreUpdateFor(leader: LeaderboardUser(username: username, count: count))
    }
}
