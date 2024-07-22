//
//  MoodCluster.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import SwiftUI
import SwiftData

class MoodCluster{
    var journals: [JournalModel]
    var rawMoods: [JournalMood] = []
    var moods: [MoodData]
    
    
    init(journals: [JournalModel]) {
        self.moods = []
        self.journals = journals
        
        loadJournals()
        
        calculatePercentage(entries: self.rawMoods)
    }
    
    func loadJournals() {
        moods.removeAll()
        
        print("journals")
        print(journals)
        
        for journal in journals {
            rawMoods.append(journal.mood)
        }
    }
    
    func calculatePercentage(entries: [JournalMood]) {
        var moodCount = [JournalMood: Int]()
        let totalEntries = entries.count
        
        // Count the occurrences of each mood
        for entry in entries {
            moodCount[entry, default: 0] += 1
        }
        
        // Calculate the percentage for each mood
        var moodPercentages = [JournalMood: Double]()
        for (mood, count) in moodCount {
            moodPercentages[mood] = (Double(count) / Double(totalEntries)) * 100
            let tempMood = MoodData(mood: mood)
            tempMood.setPercentage(percentage: Int(floor(moodPercentages[mood] ?? 0)))
            moods.append(tempMood)
        }
        print(moods)
    }
}
