//
//  RefreshableScrollView.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    var content: Content
    var action: () async -> Void
    
    init(@ViewBuilder content: @escaping () -> Content, action: @escaping () async -> Void) {
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        ScrollView {
            VStack {
                content
            }
            .overlay(
                VStack {
                    Spacer()
                    ProgressView().opacity(0) // Invisible progress view
                }
            )
            .refreshable {
                await action()
            }
        }
    }
}

