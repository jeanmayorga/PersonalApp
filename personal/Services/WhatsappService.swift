//
//  WhatsappService.swift
//  personal
//
//  Created by Jean Mayorga on 22/4/23.
//

import Foundation

struct WhatsappResponse: Codable {
    let data: WhatsappMessageData
}

struct WhatsappMessageData: Codable {
    let id: WhatsappMessageID
    let ack: Int
    let hasMedia: Bool
    let body: String
    let type: String
    let timestamp: Int
    let from: String
    let to: String
    let deviceType: String
    let isForwarded: Bool
    let forwardingScore: Int
    let isStarred: Bool
    let fromMe: Bool
    let hasQuotedMsg: Bool
    let vCards: [String]
    let mentionedIds: [String]
    let isGif: Bool
}

struct WhatsappMessageID: Codable {
    let fromMe: Bool
    let remote: WhatsappMessageRemote
    let id: String
    let selfValue: String?
    let serialized: String

    enum CodingKeys: String, CodingKey {
        case fromMe
        case remote
        case id
        case selfValue = "self"
        case serialized = "_serialized"
    }
}

struct WhatsappMessageRemote: Codable {
    let server: String
    let user: String
    let serialized: String

    enum CodingKeys: String, CodingKey {
        case server
        case user
        case serialized = "_serialized"
    }
}
