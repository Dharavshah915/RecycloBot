//
//  ChatBotIntro.swift
//  DeltaHacks
//
//  Created by Karl-Alexandre Michaud on 2025-01-11.
//

import SwiftUI

struct ChatBotIntro: View {
    @State var promptSent = false // Track if the prompt has been sent
        
    var body: some View {
        if !promptSent {
            HStack {
                Text("RecycloBot")
                    .font(.largeTitle)
                    .bold()
                
                // TODO: Replace when logo is made using chatgpt
//                Image(systemName: "bubble.left.fill")
//                    .font(.system(size: 30))
//                    .foregroundColor(Color.green)
//                    
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
            }
        }
        
    }
}

#Preview {
    ChatBotIntro()
}
