//
//  Streak.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 24/07/24.
//

import Foundation

func filterUniqueDates(from journals: [JournalModel]) -> [JournalModel] {
    var dateDict = [Date: JournalModel]()
    let calendar = Calendar.current

    for journal in journals {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: journal.timestamp)
        let normalizedDate = calendar.date(from: dateComponents)!

        // Update the dictionary with the latest journal entry for each unique date
        dateDict[normalizedDate] = journal
    }

    return Array(dateDict.values)
}

func calculateStreaks(for journals: [JournalModel]) -> (highestStreak: Int, currentStreak: Int) {
    // Filter to unique dates
    let uniqueJournals = filterUniqueDates(from: journals)
    
    // Sort journals by timestamp in descending order
    let sortedJournals = uniqueJournals.sorted { $0.timestamp > $1.timestamp }
    
    var highestStreak = 0
    var currentStreak = 0
    var lastDate = Date.distantFuture
    
    let calendar = Calendar.current

    for journal in sortedJournals {
        let journalDate = journal.timestamp
        
        // Calculate the difference in days between current journal and the last date
        let components = calendar.dateComponents([.day], from: journalDate, to: lastDate)
        let dayDifference = components.day ?? 0
        
        if dayDifference == 1 {
            // Consecutive day
            currentStreak += 1
        } else if dayDifference == 0 {
            // Same day, continue streak
            currentStreak = max(currentStreak, 1)
        } else {
            // Not consecutive, reset streak
            currentStreak = 1
        }
        highestStreak = max(highestStreak, currentStreak)
        
        lastDate = journalDate
    }
    
    return (highestStreak, currentStreak)
}
