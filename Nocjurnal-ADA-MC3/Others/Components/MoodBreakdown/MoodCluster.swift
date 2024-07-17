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
        
        // only for generating temporary data
        generateTempData()
    }
    
    func generateTempData(){
        moods.removeAll()
        moods.append(MoodData(mood: "Happy", percentage: 50))
        moods.append(MoodData(mood: "Mad", percentage: 20))
        moods.append(MoodData(mood: "Sad", percentage: 10))
        moods.append(MoodData(mood: "Fear", percentage: 10))
        moods.append(MoodData(mood: "Disgust", percentage: 10))
    }
    
    
}
