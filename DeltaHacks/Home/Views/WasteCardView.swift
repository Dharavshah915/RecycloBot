//
//  WasteCardView.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct WasteCardView: View {
    var waste: Waste
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(waste.title)
                        
                        Text(waste.subtitle)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: waste.image)
                        .foregroundColor(waste.tintColor)
                }
                
                Text(waste.amount)
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    WasteCardView(waste: Waste(id: 0, title: "Recycling", subtitle: "Goal 50", image: "arrow.3.trianglepath", tintColor: .blue, amount: "30"))
}
