//
//  ReportView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct ReportView: View {
    
    @Environment(\.modelContext) var context
    @Query private var journalModel: [JournalModel]
    
    var body: some View {
        VStack{
            Text("Journal List")
                .font(.title)
            
            List {
                ForEach(groupedJournalEntries.keys.sorted(), id: \.self) { date in
                    Section(header: Text(date, style: .date)) {
                        ForEach(groupedJournalEntries[date]!, id: \.id) { entry in
                            NavigationLink(destination: JournalDetailView(journalEntry: entry)) {
                                VStack(alignment: .leading) {
                                    Text(entry.text.string)  // Convert NSAttributedString to String for use in Text view
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .foregroundColor(.primary)
                                    
                                    Text(entry.timestamp, style: .time)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
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
            
            
            
            //            List {
            //                ForEach(groupedJournalEntries.keys.sorted(), id: \.self) { date in
            //                    Section(header: Text(date, style: .date)) {
            //                        ForEach(groupedJournalEntries[date]!, id: \.id) { entry in
            //                            VStack(alignment: .leading) {
            ////                                                MARK : Untuk menampilkan styled text
            ////                                                AttributedText(attributedString: entry.text) // Display styled text
            ////                                                    .lineLimit(1)
            ////                                                    .truncationMode(.tail)
            //                                Text(entry.text.string)  // Convert NSAttributedString to String for use in Text view
            //                                    .lineLimit(1)
            //                                    .truncationMode(.tail)
            //
            //
            //                                Text(entry.timestamp, style: .time)
            //                                    .font(.caption)
            //                            }
            //                        }
            //                        .onDelete { indexSet in
            //                            for index in indexSet {
            //                                if let entry = groupedJournalEntries[date]?[index] {
            //                                    context.delete(entry)
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            //            .listStyle(PlainListStyle())
        }
    }
    
    private var groupedJournalEntries: [Date: [JournalModel]] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: journalModel) {
            calendar.startOfDay(for: $0.timestamp)  // Group by date only
        }
        return groups
    }
}

#Preview {
    ReportView()
}
