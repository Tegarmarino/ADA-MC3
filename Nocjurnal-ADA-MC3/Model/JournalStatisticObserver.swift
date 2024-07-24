//
//  JournalStatisticObserver.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 24/07/24.
//

import Foundation
import SwiftData


func calculateTotalWordCount(journals: [JournalModel]) -> Int {
    var totalWordCount = 0
    
    for journal in journals {
        // Iterate over all contents in the journal entry
        for content in journal.contents {
            switch content {
            case .text(let data):
                let text = convertToString(data)
                
                // Split the text into words and count them
                let wordCount = text.split { $0.isWhitespace || $0.isPunctuation }.count
                totalWordCount += wordCount
            default:
                break
            }
        }
    }
    
    return totalWordCount
}

func calculateTotalJournalEntries(journals: [JournalModel]) -> Int{
    let TJE = journals.count
    
    return TJE
}
