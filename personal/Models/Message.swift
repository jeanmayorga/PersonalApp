//
//  Message.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import Foundation
import OpenAI

struct Message: Hashable {
    var content: String
    var role: Chat.Role
}
