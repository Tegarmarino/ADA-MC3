//
//  XPBarView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 22/07/24.
//

import SwiftUI
import SwiftData

struct XPBarView: View {
    @State private var currentXP: CGFloat = 0
    let maxXP: CGFloat = 1000
    let gainedXP: CGFloat = 300
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data

    var body: some View {
        VStack {
            // XP Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background bar
                    Rectangle()
                        .fill(Color.theme.warningColorTheme.opacity(0.5))
                        .frame(height: 10)
                        .cornerRadius(20)

                    // Foreground bar (XP gained)
                    Rectangle()
                        .fill(Color.theme.warningColorTheme)
                        .frame(width: geometry.size.width * (currentXP / maxXP), height: 10)
                        .animation(.smooth(duration: 3.0), value: currentXP) // Animation
                        .cornerRadius(20)


                    // XP Indicator
                    HStack {
                        //Text("\(Int(currentXP)) XP")
                        Text("   ")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(7)
                            .background(Color.theme.warningColorTheme)
                            .cornerRadius(20)
                            .offset(x: min(geometry.size.width * (currentXP / maxXP), geometry.size.width - 50))
                            .animation(.smooth(duration: 3.0), value: currentXP) // Animation
                    }
                }
            }
            .frame(height: 30)
        }
        .onAppear(){
            currentXP = CGFloat(users.first!.xp)
            withAnimation {
                users[0].gainXP(xp: 300)
                currentXP = CGFloat(users.first!.xp)
            }
        }
    }
}

#Preview {
    XPBarView()
}
