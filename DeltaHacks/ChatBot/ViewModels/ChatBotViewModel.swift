//
//  ChatBotViewModel.swift
//  DeltaHacks
//
//  Created by Karl-Alexandre Michaud on 2025-01-11.
//

import Foundation
extension ChatBotView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAiService()
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput)
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let receiveOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receiveOpenAIMessage.role, content: receiveOpenAIMessage.content)
                await MainActor.run {
                    messages.append(receivedMessage)
                }
            }
        }
        
        func intializeAIService() {
            // Prompt
            let tempContent = "You are a chatbot for our app. Our app is called RecycloBot. We encourage users to have more eco-friendly habits by having them set goals when it comes to waste management. Users can track how many times they disposed of: recycling, organics, garbage and glass. Thus they are able to see if they are reaching their eco goals they set for the month. You are to help the user with any questions about recycling, waste management, building more eco friendly and mindful habits and the environment in general. You may also add if necessary information about being mindful of the environment for the well being of everyone and that them building these habits is the first step to building and eco-friendly society. Your answers will never be more than 50 words. Your first answer will be set. You will have to introduce yourself. DO NOT USE the word hello as it is used right before."
            let tempMessages = [Message(id: UUID(), role: .assistant, content: tempContent)]
            
            Task {
                let response = await openAIService.sendMessage(messages: tempMessages)
                guard let receiveOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receiveOpenAIMessage.role, content: receiveOpenAIMessage.content)
                await MainActor.run {
                    messages.append(receivedMessage)
                }
            }
        }
    }
}

struct Message: Decodable {
    let id: UUID
    let role:  SenderRole
    let content: String
}
