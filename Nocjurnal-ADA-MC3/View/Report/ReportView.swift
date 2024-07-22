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
    
    let VPW = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("My Journals")
                            .font(Font.format.textHeadlineOne)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .frame(width: VPW, height: 48)
                    
                    MoodBreakDown(journals: journalModel)
                        .padding(.horizontal, 24)

                    ForEach(groupedJournalEntries.keys.sorted(), id: \.self) { date in
                        Section(header: Text(date, style: .date).font(Font.format.textHeadlineFour)) {
                            ForEach(groupedJournalEntries[date]!, id: \.id) { journal in
                                VStack(alignment: .leading, spacing: 3) {
                                    if let content = journal.contents.first {
                                        switch content {
                                            case .text(let data):
                                                Text(convertToString(data))// Convert NSAttributedString to String for use in Text view
                                                    .font(Font.format.textHeadlineFour)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                            case .image(_):
                                                Text("Image ...")  // Convert NSAttributedString to String for use in Text view
                                                    .font(Font.format.textHeadlineFour)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                            case .audio(_):
                                                Text("Audio ...")  // Convert NSAttributedString to String for use in Text view
                                                    .font(Font.format.textHeadlineFour)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                        }
                                    }
                                    
                                    Text(journal.timestamp, style: .time)
                                        .font(Font.format.textCaption)
                                        .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                }
                            }
                            //                            .onDelete { indexSet in
                            //                                for index in indexSet {
                            //                                    if let entry = groupedJournalEntries[date]?[index] {
                            //                                        context.delete(entry)
                            //                                    }
                            //                                }
                            //                            }
                        }
                        .padding(.horizontal, 24)
                        .frame(width: VPW, alignment: .leading)
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(width: VPW, height: 72)
                }
            }
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
