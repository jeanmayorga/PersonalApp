//
//  DeleteIconModifier.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import SwiftUI

struct DeleteIconModifier: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}
