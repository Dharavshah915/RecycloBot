//
//  ChatBotView.swift
//  DeltaHacks
//
//  Created by Karl-Alexandre Michaud on 2025-01-11.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ChatBotView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var firstMessage = true
    
    // Prompt variable
    @State private var messageText = ""
    
    // Max prompt length
    @State private var characterLimit = 175
    
    @State var messages: [Message] = []
    
    var body: some View {
        VStack {
            ChatBotIntro()
            
            ScrollView {
                HStack {
                    Text("Hello!")
                        .padding()
                        .foregroundColor(.white)
                        .background(.green.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    Spacer()
                }
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) { message in
                    messageView(message: message)
                }
            }
            
            .onAppear {
                if firstMessage {
                    viewModel.intializeAIService()
                    firstMessage = false
                }
            }
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.endEditing()
            })  // ✅ Added drag gesture for swipe-to-dismiss keyboard
            

            
            HStack {
                TextField("Enter Questions!", text: $viewModel.currentInput, axis: .vertical)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke()
                    )
                    .onChange(of: messageText) { newValue in
                        if newValue.count > characterLimit {
                            messageText = String(newValue.prefix(characterLimit))
                        }
                    }
                    .onSubmit {
                        viewModel.sendMessage()
                    }
                
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.green)
                }
                .font(.system(size: 25))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(.gray.opacity(0.15))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            } else {
                Text(message.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(.green.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                Spacer()
            }
        }
    }
}

#Preview {
    ChatBotView()
}
