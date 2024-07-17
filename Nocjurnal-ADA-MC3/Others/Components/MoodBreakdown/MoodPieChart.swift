//
//  MoodPieChart.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import SwiftUI
import Charts

var data: [MoodData] = [
    MoodData(mood: "Happy", percentage: 30),
    MoodData(mood: "Mad", percentage: 25),
    MoodData(mood: "Sad", percentage: 20),
    MoodData(mood: "Fear", percentage: 15),
    MoodData(mood: "Disgust", percentage: 10),
]


struct MoodPieChart: View {
    var body: some View {
        Chart(data, id: \.mood) { element in
            SectorMark(
                angle: .value("Percentage", element.percentage),
                innerRadius: .ratio(0.6),
                angularInset: 3
            )
            .cornerRadius(30)
            .foregroundStyle(by: .value("Name", element.mood))
        }
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotAreaFrame]
                VStack {
                    Text("Mood Breakdown")
                        .font(FontWeightFormat().textHeadlineTwo)
                    Text("Mood Breakdown")
                        .font(FontWeightFormat().textBodyThree)
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
    }
}

#Preview {
    MoodPieChart()
}
