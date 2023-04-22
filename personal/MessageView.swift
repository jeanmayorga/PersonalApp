//
//  ContentMessageView.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI
import OpenAI

struct MessageView: View {
    var content: String
    var role: Chat.Role
    
    func getBgColor() -> Color {
        if (role == Chat.Role.user) {
            return Color.blue
        }
        if (role == Chat.Role.assistant) {
            return Color(
                UIColor(
                    red: 240/255,
                    green: 240/255,
                    blue: 240/255,
                    alpha: 1.0
                )
            )
        }
        return Color.teal
    }
    
    func getFgColor() -> Color {
        if (role == Chat.Role.user) {
            return Color.white
        }
        if (role == Chat.Role.assistant) {
            return Color.black
        }
        return Color.white
    }
    
    func getAlignment() -> Alignment {
        if (role == Chat.Role.user) {
            return .trailing
        }
        if (role == Chat.Role.assistant) {
            return .leading
        }
        return .center
    }
    
    var body: some View {
        Text(content)
            .frame(maxWidth: role == Chat.Role.system ? .infinity : .none)
            .padding(10)
            .foregroundColor(getFgColor())
            .background(getBgColor())
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: getAlignment())
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageView(content: "Mensaje del sistema", role: .system)
            MessageView(content: "Mi Mensaje", role: .user)
            MessageView(content: "Este es el mensaje de la IA", role: .assistant)
        }
    }
}
