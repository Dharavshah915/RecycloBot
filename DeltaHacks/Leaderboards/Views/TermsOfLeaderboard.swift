//
//  TermsOfLeaderboard.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct TermsOfLeaderboard: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("username") var username: String?
    @State var name = ""
    @State var acceptedTerms = false
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            Spacer()

            TextField("Username", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                )
            
            HStack(alignment: .top) {
                Button {
                    withAnimation {
                        acceptedTerms.toggle()
                        print(acceptedTerms)
                    }
                } label: {
                    if acceptedTerms {
                        Image(systemName: "square.inset.filled")
                    } else {
                        Image(systemName: "square")
                    }
                }
                
                Text("By checking you agree to the terms and enter into the leaderboard competition.")
            }
            
            Spacer()
            
            // MARK: The button to engage terms of conditions
            Button {
                if acceptedTerms && name.count > 2 {
                    username = name
                    dismiss()
                }
            } label: {
                Text("Continue")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TermsOfLeaderboard()
}
