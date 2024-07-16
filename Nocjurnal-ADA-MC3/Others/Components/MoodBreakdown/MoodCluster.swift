//
//  MoodCluster.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import SwiftUI


class MoodCluster{
    var moods: [MoodData]
    
    init(moods: [MoodData]) {
        self.moods = moods
        generateTempData()
    }
    
    func generateTempData(){
        moods.removeAll()
        moods.append(MoodData(color: .yellow, mood: "Happy", percentage: 80))
        moods.append(MoodData(color: .red, mood: "Mad", percentage: 20))
//        moods.append(MoodData(color: .blue, mood: "Sad", percentage: 10))
//        moods.append(MoodData(color: .purple, mood: "Fear", percentage: 10))
//        moods.append(MoodData(color: .green, mood: "Disgust", percentage: 10))
    }

    func toggleFocus(index: Int){
        for mood in data{
            mood.focused = false
        }
        data[index].focused = true
    }
    
    
}
