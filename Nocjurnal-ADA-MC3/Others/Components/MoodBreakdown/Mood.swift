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
                .fill(mood.color)
            
            VStack(spacing: 0) {
                Text(String(mood.percentage) + "%")
                    .font(Font.format.textHeadlineFour)
                switch mood.mood {
                    case .sad:
                        Text("Sad")
                            .font(Font.format.textBodyFour)
                    case .angry:
                        Text("Angry")
                            .font(Font.format.textBodyFour)
                    case .scared:
                        Text("Scared")
                            .font(Font.format.textBodyFour)
                    case .disgusted:
                        Text("Disgusted")
                            .font(Font.format.textBodyFour)
                    case .happy:
                        Text("Happy")
                            .font(Font.format.textBodyFour)
                }
            }
        }
    }
}
