//
//  ReportView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//



import SwiftUI
import SwiftData

struct ReportView: View {
    @Environment(\.modelContext) var modelContext

    init() {
//        self._viewModel = StateObject(wrappedValue: ReportViewModel(modelContext: modelContext))
    }
    
    private var viewModel: ReportViewModel {
        get {
            return ReportViewModel(modelContext: modelContext)
        }
        nonmutating set {
            fatalError("viewModel is not directly modifiable")
        }
    }

    var body: some View {
        VStack {
            Text("Journal List")
                .font(.title)

            List {
                ForEach(viewModel.groupedJournalEntries.keys.sorted(), id: \.self) { date in
                    Section(header: Text(date, style: .date)) {
                        ForEach(viewModel.groupedJournalEntries[date]!, id: \.id) { entry in
                            NavigationLink(destination: JournalDetailView(journalEntry: entry)) {
                                VStack(alignment: .leading) {
                                    Text(entry.text.string)
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
                                if let entry = viewModel.groupedJournalEntries[date]?[index] {
                                    viewModel.delete(entry: entry)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}
