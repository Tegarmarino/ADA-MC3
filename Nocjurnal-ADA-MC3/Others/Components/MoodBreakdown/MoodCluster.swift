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
    var rawMoods: [String] = []
    var moods: [MoodData]
    
    
    init(journals: [JournalModel]) {
        self.moods = []
        self.journals = journals
        
        // only for generating temporary data
        //generateTempData()
        loadJournals()
        
        calculatePercentage(entries: rawMoods)
    }
    
    func loadJournals(){
        moods.removeAll()
        
        print("journals")
        print(journals)
        
        
        for journal in journals{
            rawMoods.append(journal.mood)
        }
        
        //        print("rawmoods")
        //        print(rawMoods)
    }
    
    func calculatePercentage(entries: [String]){
        var moodCount = [String: Int]()
        let totalEntries = entries.count
        
        // Count the occurrences of each mood
        for entry in entries {
            moodCount[entry, default: 0] += 1
        }
        
        // Calculate the percentage for each mood
        var moodPercentages = [String: Double]()
        for (mood, count) in moodCount {
            moodPercentages[mood] = (Double(count) / Double(totalEntries)) * 100
            let tempMood = MoodData(mood: mood)
            tempMood.setPercentage(percentage: Int(floor(moodPercentages[mood] ?? 0)))
            moods.append(tempMood)
        }
        print("moods")
        print(moods)
    }
    
    func generateTempData(){
        moods.removeAll()
        moods.append(MoodData(mood: "Happy"))
        moods.append(MoodData(mood: "Mad"))
        moods.append(MoodData(mood: "Sad"))
        moods.append(MoodData(mood: "Fear"))
        moods.append(MoodData(mood: "Disgust"))
        
    }
}
