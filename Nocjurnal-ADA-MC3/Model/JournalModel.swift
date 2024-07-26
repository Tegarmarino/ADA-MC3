//
//  JournalModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 15/07/24.
//

import Foundation
import SwiftData



enum JournalMood: String, Codable {
    case sad
    case angry
    case scared
    case disgusted
    case happy
}
enum JournalContent: Codable {
    case text(Data)
    case image(Data)
    case audio(Data)
    
    private enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    private enum CaseType: String, Codable {
        case text
        case image
        case audio
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            case .text(let value):
                try container.encode(CaseType.text, forKey: .type)
                try container.encode(value, forKey: .value)
            case .audio(let value):
                try container.encode(CaseType.audio, forKey: .type)
                try container.encode(value, forKey: .value)
            case .image(let value):
                try container.encode(CaseType.image, forKey: .type)
                try container.encode(value, forKey: .value)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(CaseType.self, forKey: .type)
        switch type {
            case .text:
                let value = try container.decode(Data.self, forKey: .value)
                self = .text(value)
            case .audio:
                let value = try container.decode(Data.self, forKey: .value)
                self = .audio(value)
            case .image:
                let value = try container.decode(Data.self, forKey: .value)
                self = .image(value)
        }
    }
}

struct JournalDraft {
    var mood: JournalMood
    var contents: [JournalContent]
    var tags: [String?]
    
    init() {
        self.mood = .happy
        self.contents = []
        self.tags = [nil, nil, nil]
    }
}

@Model
class JournalModel {
    var id: UUID
    var mood: JournalMood
    var contents: [JournalContent]
    var tags: [String?]
    var timestamp: Date
    
    init(mood: JournalMood, contents: [JournalContent], tags: [String?], timestamp: Date = Date()) {
        self.id = UUID()
        self.mood = mood
        self.contents = contents
        self.tags = tags
        self.timestamp = timestamp
    }
}

func convertToData(_ data: NSAttributedString) -> Data {
    return (try? data.data(from: NSRange(location: 0, length: data.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
}
func convertToString(_ data: Data) -> String {
    let data = (try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)) ?? NSAttributedString(string: "")
    return data.string
}
