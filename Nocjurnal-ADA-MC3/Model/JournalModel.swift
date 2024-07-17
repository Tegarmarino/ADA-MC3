
//
//  JournalModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 15/07/24.
//

import Foundation
import SwiftData

@Model
class JournalModel {
    var id: UUID
    var textData: Data
    var timestamp: Date
    var mood = "None"
    var attributes: [String]
    
    init(text: NSAttributedString, timestamp: Date = Date()) {
        self.id = UUID()
        self.textData = (try? text.data(from: NSRange(location: 0, length: text.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])) ?? Data()
        self.timestamp = timestamp
        //self.mood = mood
        //self.attributes = attributes
        mood = ""
        attributes = []
        
        getRandomMood()
    }
    
    init(){
        self.id = UUID()
        self.textData = Data()
        self.timestamp = Date()
        //self.mood = mood
        //self.attributes = attributes
        mood = ""
        attributes = []
        
        getRandomMood()
    }
    
    func getRandomMood(){
        let moods = ["Happy", "Sad", "Mad", "Fear", "Disgust"]
        mood = moods.randomElement() ?? "Happy"
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
