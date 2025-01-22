//
//  Waste.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct Waste {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let tintColor: Color
    let amount: String
}

struct wasteMetaData: Codable {
    let garbage: Int
    let garbageGoal: Int
    let recycling: Int
    let recyclingGoal: Int
    let glass: Int
    let glassGoal: Int
    let organics: Int
    let organicsGoal: Int
}
