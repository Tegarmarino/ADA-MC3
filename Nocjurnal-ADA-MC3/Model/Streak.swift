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
        if let normalizedDate = calendar.date(from: dateComponents) {
            // Update the dictionary with the latest journal entry for each unique date
            dateDict[normalizedDate] = journal
        }
    }

    return Array(dateDict.values)
}

func checkAndResetStreakIfMissedYesterday(for journals: [JournalModel]) -> Int {
    // Filter to unique dates
    let uniqueJournals = filterUniqueDates(from: journals)
    
    // Sort journals by timestamp in ascending order (earliest to latest)
    let sortedJournals = uniqueJournals.sorted { $0.timestamp < $1.timestamp }
    
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
    
    var didJournalYesterday = false
    
    for journal in sortedJournals {
        let journalDate = calendar.startOfDay(for: journal.timestamp)
        if journalDate == yesterday {
            didJournalYesterday = true
            break
        }
    }
    
    if !didJournalYesterday {
        return 0
    }
    
    return calculateStreaks(for: journals).currentStreak
}

func calculateStreaks(for journals: [JournalModel]) -> (highestStreak: Int, currentStreak: Int) {
    // Filter to unique dates
    let uniqueJournals = filterUniqueDates(from: journals)
    
    // Sort journals by timestamp in ascending order (earliest to latest)
    let sortedJournals = uniqueJournals.sorted { $0.timestamp < $1.timestamp }
    
    var highestStreak = 0
    var currentStreak = 0
    var lastDate: Date?
    
    let calendar = Calendar.current

    for journal in sortedJournals {
        let journalDate = calendar.startOfDay(for: journal.timestamp) // Normalize to start of the day
        
        if let lastDate = lastDate {
            let components = calendar.dateComponents([.day], from: lastDate, to: journalDate)
            let dayDifference = components.day ?? 0
            
            if dayDifference == 1 {
                // Consecutive day
                currentStreak += 1
            } else if dayDifference > 1 {
                // Not consecutive, reset streak
                currentStreak = 1
            }
            // Else if dayDifference == 0, it's the same day, do nothing
        } else {
            // First entry, start streak
            currentStreak = 1
        }
        
        highestStreak = max(highestStreak, currentStreak)
        lastDate = journalDate
    }
    
    return (highestStreak, currentStreak)
}
