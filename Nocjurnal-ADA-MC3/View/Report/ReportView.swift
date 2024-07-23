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
    @State private var currentDate = Date()
    @State private var dateRange: String = ""
    var color = Color.white

    let VPW = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Your Journaling Report")
                            .font(Font.format.textHeadlineOne)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .frame(width: VPW, height: 48)
                    VStack {
                       HStack {
                           Button(action: {
                               updateDateRange(byAdding: -7)
                           }) {
                               Image(systemName: "arrow.left")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 15, height: 15)
                                   .padding()
                                   .background(Color.theme.secondaryColorTheme)
                                   .clipShape(Circle())
                                   .foregroundColor(.black)
                           }
                           Spacer()
                           Text(dateRange)
                               .font(.title3)
                           Spacer()
                           Button(action: {
                               updateDateRange(byAdding: 7)
                           }) {
                               Image(systemName: "arrow.right")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 15, height: 15)
                                   .padding()
                                   .background(Color.theme.secondaryColorTheme)
                                   .clipShape(Circle())
                                   .foregroundColor(.black)
                           }
                           
//                                   Button(action: {
//                                       updateDateRange(byAdding: 7)
//                                   }) {
//                                       Text("Next")
//                                   }
//                                   .padding()
                       }
                    }
                    .padding(.horizontal,24)
                    .onAppear {
                       updateDateRange(byAdding: 0)
                    }

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
                    
//                  MOOD CARD
                    ForEach(journalModel, id: \.self) { journal in
                        MoodCard(date: formatDateTime(journal.timestamp), mood: journal.mood.rawValue.capitalized, moodColor: getColor(for: journal.mood).color , moodImgColor: getColor(for: journal.mood).imageName, tags: journal.tags)
                    }
                    .padding(.horizontal, 24)

                    Rectangle()
                        .fill(.clear)
                        .frame(width: VPW, height: 72)
                }
            }
        }
    }
    func updateDateRange(byAdding days: Int) {
        currentDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate) ?? Date()
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) ?? Date()
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        let startDateString = dateFormatter.string(from: startOfWeek)
        
        dateFormatter.dateFormat = "d, yyyy"
        let endDateString = dateFormatter.string(from: endOfWeek)
            dateRange = "\(startDateString) - \(endDateString)"
    }
    
    private var groupedJournalEntries: [Date: [JournalModel]] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: journalModel) {
            calendar.startOfDay(for: $0.timestamp)  // Group by date only
        }
        return groups
    }
    
    private func formatDateTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func getColor(for mood: JournalMood) -> (color: Color, imageName: String) {
            switch mood {
            case .happy:
                return (.yellow, "Joy")
            case .sad:
                return (.blue, "Sad")
            case .angry:
                return (.red, "Anger")
            case .scared:
                return (.purple, "Fear")
            case .disgusted:
                return (.green, "Disgust")
            }
        }
}
