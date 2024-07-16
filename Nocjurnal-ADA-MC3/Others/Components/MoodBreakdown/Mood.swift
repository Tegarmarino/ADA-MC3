//
//  Mood.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import SwiftUI

struct Mood: View {
//    var color: Color = .white
//    var mood: String = ""
//    var percentage: Int = 100
//    var focused = false
    var mood : MoodData
    
    var body: some View {
        ZStack{
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.white, mood.color]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
                VStack{
                    Text(String(mood.percentage) + "%")
                        .font(FontWeightFormat().textBodyFour)

                    Text(mood.mood)
                        .font(FontWeightFormat().textBodyFour)
                }
            
        }
    }
}

#Preview {
    Mood(mood: MoodData(color: .blue, mood: "Sad", percentage: 70))
        .frame(width: 100, height: 100)
}
