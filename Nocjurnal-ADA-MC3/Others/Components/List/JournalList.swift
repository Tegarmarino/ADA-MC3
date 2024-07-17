//
//  JournalListAll.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 15/07/24.
//


import SwiftUI
import SwiftData
struct JournalList: View {
    @Environment(\.modelContext) var context
    @Query private var journalModel: [JournalModel]
    
    var body: some View {
        List {
            Text("Journal List")
                .font(.headline)
                .listRowSeparator(.hidden)
            ForEach(groupedJournalEntries.keys.sorted(), id: \.self) { date in
                Section(header:
                            Text(date, style: .date)) {
                    ForEach(groupedJournalEntries[date]!, id: \.id) { entry in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: JournalDetailView(journalEntry: entry)) {
                               EmptyView()
                            }
                            .opacity(0)
                            JournalCard(title: entry.text.string , time: entry.timestamp)
                                .lineLimit(1)
                        }
                        .listRowSeparator(.hidden)

                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            if let entry = groupedJournalEntries[date]?[index] {
                                context.delete(entry)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        

    }
    private var groupedJournalEntries: [Date: [JournalModel]] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: journalModel) {
            calendar.startOfDay(for: $0.timestamp)  // Group by date only
        }
        return groups
    }
}

//#Preview {
//    JournalList()
//}
