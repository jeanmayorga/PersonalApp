//
//  ContentView.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            ChatGptView()
              .tabItem {
                 Image(systemName: "ellipsis.message")
                 Text("Chat GPT")
               }
            WhatsappView()
              .tabItem {
                 Image(systemName: "message")
                 Text("Whatsapp")
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
