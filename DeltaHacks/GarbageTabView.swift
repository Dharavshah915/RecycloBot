//
//  GarbageTabView.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct GarbageTabView: View {
    @State var selectedTab = "Home"
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
            
            ChatBotView()
                .tag("Recyclobot")
                .tabItem {
                    Image(systemName: "wand.and.rays")
                }
            
            LeaderboardView()
                .tag("Leaderboards")
                .tabItem {
                    Image(systemName: "list.bullet")
                }
        }
    }
}

#Preview {
    GarbageTabView()
}
