//
//  MoodCard.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 22/07/24.
//

import SwiftUI
import SwiftData

struct MoodCard: View {
    let journal: JournalModel
    
    private let VPW = UIScreen.main.bounds.size.width
    
    init(_ journal: JournalModel) {
        self.journal = journal
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 48){
            if !journal.tags.isEmpty {
                HStack {
                    ForEach(journal.tags, id: \.self) { tag in
                        if let tag {
                            Text(tag)
                                .font(Font.format.textCaption)
                                .padding(.horizontal, 12)
                                .frame(height: 24)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.theme.borderColorTheme, lineWidth: 1.0)
                                )
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(formatDateTime(journal.timestamp))
                    .font(Font.format.textCaption)
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading){
                        Text("I'm feeling")
                            .font(Font.format.textHeadlineFour)
                        Text(moodString(journal.mood))
                            .font(Font.format.textHeadlineFour)
                            .foregroundColor(moodColor(journal.mood))
                    }
                    Spacer()
                    switch journal.mood {
                        case .happy:
                            Image("Joy")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72)
                        case .angry:
                            Image("Anger")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72)
                        case .disgusted:
                            Image("Disgust")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72)
                        case .sad:
                            Image("Sad")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72)
                        case .scared:
                            Image("Fear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72)
                    }
                }
            }
        }
        .padding(18)
        .frame(width: VPW - 48)
        .background(moodGradient(journal.mood).opacity(0.5))
        .cornerRadius(24)
        
    }
    
    private func formatDateTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, HH:mm"
        return dateFormatter.string(from: date)
    }
    private func moodString(_ mood: JournalMood) -> String {
        switch mood {
            case .happy:
                return "Happy"
            case .angry:
                return "Angry"
            case .disgusted:
                return "Disgusted"
            case .sad:
                return "Sad"
            case .scared:
                return "Scared"
        }
    }
    private func moodColor(_ mood: JournalMood) -> Color {
        switch mood {
            case .happy:
                return Color(hex: 0xEBE895)
            case .angry:
                return Color(hex: 0xCB8687)
            case .disgusted:
                return Color(hex: 0x97CCA1)
            case .sad:
                return Color(hex: 0xDCECEE)
            case .scared:
                return Color(hex: 0xE1D0E5)
        }
    }
    private func moodGradient(_ mood: JournalMood) -> LinearGradient {
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
}
