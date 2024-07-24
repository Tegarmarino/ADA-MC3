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
    
    var curXP: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                // Background bar
                ZStack {
                    Circle()
                        .fill(Color.theme.primaryColorTheme)
                        .frame(width: 80, height: 80)
                        .zIndex(3)
                    
                    Text("Level \(users.first?.lvl ?? 1)")
                        .foregroundColor(.white)
                        .font(Font.format.textHeadlineFour)
                        .zIndex(4)
                }
                .zIndex(2)
                
                Rectangle()
                    .fill(Color.theme.warningColorTheme.opacity(0.5))
                    .frame(width: geometry.size.width - 36,height: 45)
                    .cornerRadius(20)
                    .offset(x: 24)
                
                // Foreground bar (XP gained)
                Rectangle()
                    .fill(Color.theme.warningColorTheme)
                //.frame(width: (geometry.size.width - 36) * CGFloat((users.first?.xp ?? 0) / 1000), height: 45)
                    .frame(width: (geometry.size.width - 36) * curXP/1000, height: 45)
                    .cornerRadius(20)
                    .offset(x: 24)
                    .zIndex(1)
                
                // XP Indicator
                HStack {
                    Text("\(Int(users.first?.xp ?? 0)) / 1000")
                        .font(Font.format.textHeadlineFive)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .offset(x: geometry.size.width/2 - 36)
                        .padding(.bottom, 12)
                }
                .zIndex(4)
                
                Text("Nocy")
                    .font(Font.format.textHeadlineThree)
                    .foregroundColor(Color.theme.primaryColorTheme)
                    .offset(x: 80, y: -50)

                
            }
        }
        .frame(height: 30)
        .padding(.horizontal, 24)
    }
}
