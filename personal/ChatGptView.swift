//
//  ChatGptView.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI
import OpenAI

struct ChatGptView: View {
    let openAI = OpenAI(apiToken: "OPEN_IA_KEY")
    @State private var message: String = ""
    @State private var prompt: String = "Eres una IA para ayudar a Jean Paul en sus cosas del dia."
    @State private var isLoading: Bool = false
    @State private var showLoadingMessage: Bool = false
    @State private var isPromptSheetVisible: Bool = false
    
    @State private var messages: Array<Message> = []
    
    func onInit() {
        messages.append(
            Message(content: prompt, role: .system)
        )
    }
    
    func onDissmissSheet () {
        if (messages.count == 0) {
            messages = [
                Message(content: prompt, role: .system)
            ]
        }
    }
    
    func closeKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func handleSendMessage() async {
        do {
            messages.append(Message(content: message, role: .user));
            message = ""
            
            isLoading = true
            sleep(1)
            showLoadingMessage = true
            
            let response = try await openAI.chats(
                query: ChatQuery(
                    model: .gpt3_5Turbo,
                    messages: messages.map { message in
                        Chat(role: message.role, content: message.content)
                    }
                )
            )
            showLoadingMessage = false
            messages.append(Message(content: response.choices[0].message.content, role: .assistant))
        } catch {
            print(error)
        }
        isLoading = false
    }
    
    var body: some View {
        VStack {
            NavigationView{
                ScrollView {
                    VStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(content: message.content, role: message.role)
                        }
                        if (showLoadingMessage) {
                            MessageView(content: "Pensando ...", role: .assistant)
                        }
                    }.padding()
                }
                .navigationTitle("Chat gpt")
                .navigationBarItems(trailing:
                                        Button(action: {
                    isPromptSheetVisible = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                }.sheet(isPresented: $isPromptSheetVisible, onDismiss: onDissmissSheet) {
                    PromptView(prompt: $prompt)
                }
                )
                .onTapGesture {
                    closeKeyBoard()
                }
                .onAppear{
                    onInit()
                }
            }.scrollDismissesKeyboard(.interactively)
            Divider()
            HStack {
                TextField(
                    "Ask a question",
                    text: $message,
                    axis: .vertical
                )
                .padding(.all, 10.0)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor(
                    red: 0/255,
                    green: 0/255,
                    blue: 0/255,
                    alpha: 0.1
                )), lineWidth: 1))
                .lineLimit(1...5)
                Button(
                    action: {
                        Task {
                            await handleSendMessage()
                        }
                    }
                ) {
                    if (isLoading) {
                        ProgressView().progressViewStyle(CircularProgressViewStyle()).tint(.white)
                    } else {
                        Image(systemName: "paperplane.fill").foregroundColor(.white)
                    }
                }
                .padding(.all, 10)
                .background(Color.blue)
                .cornerRadius(30)
                .disabled(isLoading || message.isEmpty)
            }
            .padding(.horizontal)
            Divider()
            
        }
    }
}

struct ChatGptView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGptView()
    }
}
