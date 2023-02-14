//
//  ContentView.swift
//  ChatGPT-SwiftUI
//
//  Created by Hamed Naji on 2023-02-11.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var chatMessages: [ChatMessage] = []
    @State var messageText: String = ""
    @State var cancellables = Set<AnyCancellable>()
    let openAIService = OpenAIService()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    LazyVStack {
                        ForEach(chatMessages, id: \.id) { message in
                            messageView(message: message)
                        }
                    }
                    
                }.padding(.horizontal)
                VStack{
                    Spacer()
                    HStack{
                        TextField("Enter a message", text: $messageText)
                            .padding(12)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                            
                        Button {
                            if !messageText.isEmpty {
                                sendMessage()
                            }
                           
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.largeTitle)
                                .disabled(messageText.isEmpty ? true : false)
                        }

                    }.padding()
                    .background(.regularMaterial)
                }
                
            }
            .navigationTitle("ChatGPT")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    func messageView(message: ChatMessage) -> some View {
        HStack{
            if message.sender == .me { Spacer() }
            Text(message.content)
                .foregroundColor(message.sender == .me ? .white : .black)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(message.sender == .me ? .blue : .gray.opacity(0.1))
                .shadow(radius: 10)
                .cornerRadius(16)
            if message.sender == .gpt { Spacer() }
        }
    }
    
    func sendMessage() {
        
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me)
        chatMessages.append(myMessage)
        
        openAIService.sendMessage(message: messageText).sink { completion in
            //
        } receiveValue: { response in
            print(response)
            guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .gpt)
            chatMessages.append(gptMessage)
        }
        .store(in: &cancellables)

        messageText = ""
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


