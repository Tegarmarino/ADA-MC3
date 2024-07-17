//
//  ReportViewModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 17/07/24.
//

import SwiftUI
import SwiftData

class ReportViewModel: ObservableObject {
    @Published var journalEntries: [JournalModel] = []

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchJournalEntries()
    }

    func fetchJournalEntries() {
        let fetchDescriptor = FetchDescriptor<JournalModel>() // Create a FetchDescriptor
        journalEntries = try! modelContext.fetch(fetchDescriptor)
    }

    private func groupByDate(entries: [JournalModel]) -> [Date: [JournalModel]] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: entries) {
            calendar.startOfDay(for: $0.timestamp) // Group by date only
        }
        return groups
    }

    var groupedJournalEntries: [Date: [JournalModel]] {
        return groupByDate(entries: journalEntries)
    }

    func delete(entry: JournalModel) {
        modelContext.delete(entry)
        fetchJournalEntries() // Refresh after deletion
    }
}

