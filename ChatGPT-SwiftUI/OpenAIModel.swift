//
//  OpenAIModel.swift
//  ChatGPT-SwiftUI
//
//  Created by Hamed Naji on 2023-02-12.
//

import Foundation

struct OpenAIModel: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}

struct OpenAICompletionsResponse: Decodable{
    let id: String
    let choices: [OpenAICompletionsChoice]
}

struct OpenAICompletionsChoice: Decodable {
    let text: String
}
