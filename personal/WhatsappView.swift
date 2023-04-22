//
//  WhatsappView.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI
import Alamofire

struct WhatsappMessage: Encodable {
    let to: String
    let message: String
}

struct WhatsappView: View {
    @State private var to: String = ""
    @State private var message: String = ""
    @State private var responseMessage: String = ""
    @State private var isLoading: Bool = false
    
    func closeKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func sendMessage() {
        print("start send message")
        closeKeyBoard()
        isLoading = true
        let url = "WHATSAPP_API"
        let parameters = WhatsappMessage(to: to.filter("0123456789".contains), message: message)
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        message = ""
        print("request parameters: \(parameters)")
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).response{ response in
            switch response.result {
            case .success(let data):
                isLoading = false
                guard let jsonData = data else {
                    print("Error: No se recibió ningún dato del servidor.")
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(WhatsappResponse.self, from: jsonData)
                    responseMessage = "from: \(decodedData.data.from)\nto: \(decodedData.data.to)\nbody: \(decodedData.data.body)"
                } catch {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
                Form {
                    Section {
                        TextField("593962975512", text: $to).disabled(isLoading).modifier(DeleteIconModifier(text: $to))
                    } header: { Text("Numero de whatsapp") }
                    Section {
                        TextField("Content", text: $message, axis: .vertical)
                            .lineLimit(5...10).disabled(isLoading).onSubmit {
                                sendMessage()
                            }
                    } header: { Text("Mensaje") }
                    
                    if(responseMessage != "") {
                        Section {
                            Text(responseMessage)
                        } header: {
                            Text("Result")
                        }
                    }
            }.navigationTitle("Whatsapp")
                .scrollDismissesKeyboard(.interactively)
                .navigationBarItems(trailing: Button(action: { sendMessage() }) {
                    if (isLoading) {
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Enviar")
                    }
                })
        }
    }
}

struct WhatsappView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsappView()
    }
}
