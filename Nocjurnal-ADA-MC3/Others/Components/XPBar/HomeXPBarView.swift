//
//  HomeXPBarView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 23/07/24.
//

import SwiftUI
import SwiftData

struct HomeXPBarView: View {
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    @Query private var journalModel: [JournalModel]
    
    var curXP: CGFloat
    
    private let VPW = UIScreen.main.bounds.size.width
    
    var body: some View {
        HStack(spacing: 12) {
            // Background bar
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.backgroundColorTwoTheme)
                .overlay(
                    Text("\(users.first?.lvl ?? 1)")
                        .foregroundColor(Color.theme.fontPrimaryColorTheme)
                        .font(Font.format.textHeadlineOne)
                        .zIndex(4)
                )
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Nocy")
                        .font(Font.format.textHeadlineFour)
                        .foregroundColor(Color.theme.fontPrimaryColorTheme)
                    Spacer()
                    HStack(spacing: 18) {
                        HStack(spacing: 6) {
                            Image("Coins")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 18)
                            Text("\(users.first?.money ?? 0)")
                                .font(Font.format.textHeadlineFive)
                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                        }
                        HStack(spacing: 6) {
                            let streaks = calculateStreaks(for: journalModel)
                            Image(systemName: "flame.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 18)
                                .foregroundStyle(Color.theme.errorColorTheme)
                            Text("\(streaks.currentStreak) days")
                                .font(Font.format.textHeadlineFive)
                                .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                        }
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.theme.secondaryColorTheme)
                    .frame(width: VPW - 132, height: 24, alignment: .topLeading)
                    .background(
                        HStack {
                            Rectangle()
                                .fill(Color.theme.primaryColorTheme)
                                .frame(width: (VPW - 120) * curXP / 1000, height: 24)
                                .cornerRadius(12)
                            Spacer()
                        }
                    )
                    .overlay {
                        Text("\(Int(users.first?.xp ?? 0)) / 1000")
                            .font(Font.format.textHeadlineFive)
                            .foregroundColor(Color.theme.fontPrimaryColorTheme)
                    }
            }
            .frame(width: VPW - 132, height: 48, alignment: .bottomLeading)
        }
        .padding(12)
        .frame(width: VPW - 48, height: 72)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.theme.backgroundColorOneTheme)
        )
    }
}
