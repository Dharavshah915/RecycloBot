//
//  LeaderboardUser.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import Foundation

struct LeaderboardUser: Codable, Identifiable {
    let id = UUID()
    let username: String
    let count: Int
}
