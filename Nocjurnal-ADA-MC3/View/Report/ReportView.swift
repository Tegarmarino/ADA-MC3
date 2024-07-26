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
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Query private var journalModel: [JournalModel]
    @State private var currentDate = Date()
    @State private var dateRange: String = ""
    
    @State private var dictCompanies: [String: ([JournalMood: Int], Int)] = [:]
    @State private var dictActivities: [String: ([JournalMood: Int], Int)] = [:]
    @State private var dictPlaces: [String: ([JournalMood: Int], Int)] = [:]

    @State private var datePrevState = ButtonState.idle
    @State private var dateNextState = ButtonState.idle
    
    @State private var scrollState = CGFloat(0.0)
    @State private var scroll: CGPoint = .zero
    
    var color = Color.white

    private let VPW = UIScreen.main.bounds.size.width
    private let VPH = UIScreen.main.bounds.size.height
    
    var scrollPassed: Bool {
        if scroll.y <= -24 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Emotions you've felt this week")
                            .font(Font.format.textHeadlineThree)
                            .foregroundStyle(.fontColorPrimaryTheme)
                        MoodBreakDown(journals: journalModel)
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.theme.backgroundColorOneTheme)
                    )

                    //                    ForEach(groupedJournalEntries.keys.sorted(), id: \.self) { date in
                    //                        Section(header: Text(date, style: .date).font(Font.format.textHeadlineFour)) {
                    //                            ForEach(groupedJournalEntries[date]!, id: \.id) { journal in
                    //                                VStack(alignment: .leading, spacing: 3) {
                    //                                    if let content = journal.contents.first {
                    //                                        switch content {
                    //                                            case .text(let data):
                    //                                                Text(convertToString(data))// Convert NSAttributedString to String for use in Text view
                    //                                                    .font(Font.format.textHeadlineFour)
                    //                                                    .lineLimit(1)
                    //                                                    .truncationMode(.tail)
                    //                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                    //                                            case .image(_):
                    //                                                Text("Image ...")  // Convert NSAttributedString to String for use in Text view
                    //                                                    .font(Font.format.textHeadlineFour)
                    //                                                    .lineLimit(1)
                    //                                                    .truncationMode(.tail)
                    //                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                    //                                            case .audio(_):
                    //                                                Text("Audio ...")  // Convert NSAttributedString to String for use in Text view
                    //                                                    .font(Font.format.textHeadlineFour)
                    //                                                    .lineLimit(1)
                    //                                                    .truncationMode(.tail)
                    //                                                    .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                    //                                        }
                    //                                    }
                    //
                    //                                    Text(journal.timestamp, style: .time)
                    //                                        .font(Font.format.textCaption)
                    //                                        .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                    //
                    //
                    //                                }
                    //                            }
                    //                        }
                    //                        .padding(.horizontal, 24)
                    //                        .frame(width: VPW, alignment: .leading)
                    //                    }
                    //
                    //                    ForEach(journalModel, id: \.self) { journal in
                    //                        MoodCard(journal)
                    //                    }
                    //                    .padding(.horizontal, 24)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        Text("What you do and what you feel")
                            .font(Font.format.textHeadlineThree)
                            .foregroundStyle(.fontColorPrimaryTheme)
                        
                        ForEach(dictActivities.keys.sorted(), id: \.self) { key in
                            VStack(alignment: .leading, spacing: 6) {
                                if let value = dictActivities[key] {
                                    HStack(alignment: .center, spacing: 6) {
                                        Text(key)
                                            .font(Font.format.textHeadlineFive)
                                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                        if value.1 > 1 {
                                            Text("(\(value.1) entries)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        } else {
                                            Text("(\(value.1) entry)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        }
                                    }
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.clear)
                                        .fill(.clear)
                                        .overlay(
                                            HStack(spacing: 0) {
                                                if let count = value.0[.angry] {
                                                    Rectangle()
                                                        .fill(moodColor(.angry).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                }
                                                if let count = value.0[.sad] {
                                                    Rectangle()
                                                        .fill(moodColor(.sad).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SAD: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.disgusted] {
                                                    Rectangle()
                                                        .fill(moodColor(.disgusted).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - DISGUSTED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.happy] {
                                                    Rectangle()
                                                        .fill(moodColor(.happy).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - HAPPY: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                                if let count = value.0[.scared] {
                                                    Rectangle()
                                                        .fill(moodColor(.scared).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SCARED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                            }
                                        )
                                        .frame(width: VPW - 84, height: 24)
                                        .clipShape(.rect(cornerRadius: 12))
                                }
                            }
                        }
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.theme.backgroundColorOneTheme)
                    )
                    .frame(width: VPW - 48, alignment: .topLeading)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        Text("Who are you with and what you feel")
                            .font(Font.format.textHeadlineThree)
                            .foregroundStyle(.fontColorPrimaryTheme)
                        
                        ForEach(dictCompanies.keys.sorted(), id: \.self) { key in
                            VStack(alignment: .leading, spacing: 6) {
                                if let value = dictCompanies[key] {
                                    HStack(alignment: .center, spacing: 6) {
                                        Text(key)
                                            .font(Font.format.textHeadlineFive)
                                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                        if value.1 > 1 {
                                            Text("(\(value.1) entries)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        } else {
                                            Text("(\(value.1) entry)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        }
                                    }
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.clear)
                                        .overlay(
                                            HStack(spacing: 0) {
                                                if let count = value.0[.angry] {
                                                    Rectangle()
                                                        .fill(moodColor(.angry).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - ANGRY: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                                if let count = value.0[.sad] {
                                                    Rectangle()
                                                        .fill(moodColor(.sad).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SAD: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.disgusted] {
                                                    Rectangle()
                                                        .fill(moodColor(.disgusted).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - DISGUSTED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.happy] {
                                                    Rectangle()
                                                        .fill(moodColor(.happy).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - HAPPY: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                                if let count = value.0[.scared] {
                                                    Rectangle()
                                                        .fill(moodColor(.scared).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SCARED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                            }
                                        )
                                        .frame(width: VPW - 84, height: 24)
                                        .clipShape(.rect(cornerRadius: 12))
                                }
                            }
                        }
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.theme.backgroundColorOneTheme)
                    )
                    .frame(width: VPW - 48, alignment: .topLeading)

                    VStack(alignment: .leading, spacing: 18) {
                        Text("Where are you and what you feel")
                            .font(Font.format.textHeadlineThree)
                            .foregroundStyle(.fontColorPrimaryTheme)
                        
                        ForEach(dictPlaces.keys.sorted(), id: \.self) { key in
                            VStack(alignment: .leading, spacing: 6) {
                                if let value = dictPlaces[key] {
                                    HStack(alignment: .center, spacing: 6) {
                                        Text(key)
                                            .font(Font.format.textHeadlineFive)
                                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                        if value.1 > 1 {
                                            Text("(\(value.1) entries)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        } else {
                                            Text("(\(value.1) entry)")
                                                .font(Font.format.textCaption)
                                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                                        }
                                    }
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.clear)
                                        .fill(.clear)
                                        .overlay(
                                            HStack(spacing: 0) {
                                                if let count = value.0[.angry] {
                                                    Rectangle()
                                                        .fill(moodColor(.angry).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - ANGRY: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                                if let count = value.0[.sad] {
                                                    Rectangle()
                                                        .fill(moodColor(.sad).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SAD: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.disgusted] {
                                                    Rectangle()
                                                        .fill(moodColor(.disgusted).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - DISGUSTED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                    
                                                }
                                                if let count = value.0[.happy] {
                                                    Rectangle()
                                                        .fill(moodColor(.happy).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - HAPPY: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                                if let count = value.0[.scared] {
                                                    Rectangle()
                                                        .fill(moodColor(.scared).opacity(0.5))
                                                        .overlay(
                                                            Text("\(String(format: "%.2f", CGFloat(count) / CGFloat(value.1) * 100.0))%")
                                                                .font(Font.format.textCaption)
                                                                .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                                                        )
                                                        .frame(width: CGFloat(VPW - 84) * CGFloat(count) / CGFloat(value.1), height: 24)
                                                        .onAppear {
                                                            print("\(key) - SCARED: \(count) / \(value.1) = \(CGFloat(count) / CGFloat(value.1))")
                                                        }
                                                }
                                            }
                                        )
                                        .frame(width: VPW - 84, height: 24)
                                        .clipShape(.rect(cornerRadius: 12))
                                }
                            }
                        }
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.theme.backgroundColorOneTheme)
                    )
                    .frame(width: VPW - 48, alignment: .topLeading)

                    Rectangle()
                        .fill(.clear)
                        .frame(height: 72)
                }
                .padding(EdgeInsets(top: safeAreaInsets.top + 72, leading: 24, bottom: 0, trailing: 24))
                .frame(width: VPW)
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scroll = value
                }
            }
            .coordinateSpace(name: "scroll")
            
            VStack(spacing: 0) {
                HStack {
                    Text("Weekly")
                        .font(Font.format.textHeadlineOne)
                        .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                
                HStack {
                    ButtonIcon("arrow.left", state: $datePrevState, type: .secondary) {
                        updateDateRange(byAdding: -7)
                    }
                    Spacer()
                    Text(dateRange)
                        .font(Font.format.textHeadlineFive)
                    Spacer()
                    ButtonIcon("arrow.right", state: $dateNextState, type: .secondary) {
                        updateDateRange(byAdding: 7)
                    }
                }
                
            }
            .padding(EdgeInsets(top: safeAreaInsets.top, leading: 24, bottom: 24, trailing: 24))
            .background(
                Rectangle()
                    .fill(.thinMaterial)
                    .opacity(scrollState)
            )
            .ignoresSafeArea()
        }
        .background(Color.theme.backgroundColorTwoTheme)
        .frame(width: VPW)
        .onChange(of: scrollPassed) {
            if scrollPassed {
                withAnimation(.spring(duration: 0.25)) {
                    scrollState = CGFloat(1)
                }
            } else {
                withAnimation(.spring(duration: 0.25)) {
                    scrollState = CGFloat(0)
                }
            }
        }
        .onAppear {
            updateDateRange(byAdding: 0)
            getCharts()
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
    
    private func getCharts() {
        for journal in journalModel {
            if let activity = journal.tags[0] {
                if var moodCount = dictActivities[activity] {
                    moodCount.0[journal.mood]! += 1
                    moodCount.1 += 1
                    dictActivities[activity] = moodCount
                } else {
                    var moodCount = [JournalMood.angry: 0, JournalMood.disgusted: 0, JournalMood.happy: 0, JournalMood.sad: 0, JournalMood.scared: 0]
                    moodCount[journal.mood]! += 1
                    dictActivities[activity] = (moodCount, 1)
                }
            }
            if let company = journal.tags[1] {
                if var moodCount = dictCompanies[company] {
                    moodCount.0[journal.mood]! += 1
                    moodCount.1 += 1
                    dictCompanies[company] = moodCount
                } else {
                    var moodCount = [JournalMood.angry: 0, JournalMood.disgusted: 0, JournalMood.happy: 0, JournalMood.sad: 0, JournalMood.scared: 0]
                    moodCount[journal.mood]! += 1
                    dictCompanies[company] = (moodCount, 1)
                }
            }
            if let place = journal.tags[0] {
                if var moodCount = dictPlaces[place] {
                    moodCount.0[journal.mood]! += 1
                    moodCount.1 += 1
                    dictPlaces[place] = moodCount
                } else {
                    var moodCount = [JournalMood.angry: 0, JournalMood.disgusted: 0, JournalMood.happy: 0, JournalMood.sad: 0, JournalMood.scared: 0]
                    moodCount[journal.mood]! += 1
                    dictPlaces[place] = (moodCount, 1)
                }
            }
        }
    }
    
    private func moodColor(_ mood: JournalMood) -> LinearGradient {
        switch mood {
            case .happy:
                return Color.mood.happy
            case .angry:
                return Color.mood.angry
            case .disgusted:
                return Color.mood.disgusted
            case .sad:
                return Color.mood.sad
            case .scared:
                return Color.mood.scared
        }
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
