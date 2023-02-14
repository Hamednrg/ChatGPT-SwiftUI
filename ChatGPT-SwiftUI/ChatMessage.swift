//
//  ChatMessage.swift
//  ChatGPT-SwiftUI
//
//  Created by Hamed Naji on 2023-02-12.
//

import Foundation

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
    
}
extension ChatMessage{
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Sample Message from Me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample Message from GPT", dateCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample Message from Me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample Message from GPT", dateCreated: Date(), sender: .gpt)
    ]
}

enum MessageSender{
    case me
    case gpt
}
