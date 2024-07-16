//
//  JournalModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 15/07/24.
//

import Foundation
import SwiftData

//@Model
//class JournalModel {
//    var id: UUID
//    var textData: Data
//    var timestamp: Date
//
//    init(text: NSAttributedString) {
//        self.id = UUID()
//        self.textData = (try? text.data(from: NSRange(location: 0, length: text.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
//        self.timestamp = Date()
//    }
//
//    var text: NSAttributedString {
//        get {
//            return (try? NSAttributedString(data: textData, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)) ?? NSAttributedString(string: "")
//        }
//        set {
//            textData = (try? newValue.data(from: NSRange(location: 0, length: newValue.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
//        }
//    }
//}
//

@Model
class JournalModel {
    var id: UUID
    var textData: Data
    var timestamp: Date

    init(text: NSAttributedString, timestamp: Date = Date()) {
        self.id = UUID()
        self.textData = (try? text.data(from: NSRange(location: 0, length: text.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
        self.timestamp = timestamp
    }

    var text: NSAttributedString {
        get {
            return (try? NSAttributedString(data: textData, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)) ?? NSAttributedString(string: "")
        }
        set {
            textData = (try? newValue.data(from: NSRange(location: 0, length: newValue.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
        }
    }
}
