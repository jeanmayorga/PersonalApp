//
//  PromptView.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI

struct PromptView: View {
    @Binding var prompt: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Prompt", text: $prompt, axis: .vertical)
                    .lineLimit(1...5)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(UIColor(
                        red: 0/255,
                        green: 0/255,
                        blue: 0/255,
                        alpha: 0.05
                    )))
                    .foregroundColor(Color(UIColor(
                        red: 0/255,
                        green: 0/255,
                        blue: 0/255,
                        alpha: 0.7
                    )))
                    .cornerRadius(10)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                Spacer()
            }
            .navigationBarTitle("Prompt", displayMode: .inline)
            .navigationBarItems(trailing: Button("Guardar") {
                dismiss()
            })
        }
        .padding()
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(prompt: .constant("Este es el current prompt \n hahaha"))
    }
}
