//
//  OpenAIService.swift
//  ChatGPT-SwiftUI
//
//  Created by Hamed Naji on 2023-02-12.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    
    let baseURL = "https://api.openai.com/v1/"
    
    func sendMessage(message: String) -> AnyPublisher<OpenAICompletionsResponse, Error> {
        let parameter = OpenAIModel(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 256)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]
        return Future { [weak self] promise in
            guard let self = self else { return }
            AF.request(self.baseURL + "completions", method: .post, parameters: parameter, encoder: .json, headers: headers).responseDecodable(of: OpenAICompletionsResponse.self ,completionHandler: { response in
                
                switch response.result {
                    
                case .success(let result):
                    print(result)
                    promise(.success(result))
                case .failure(let error):
                    print(error)
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
