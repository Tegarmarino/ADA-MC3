//
//  MoodData.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import Foundation
import SwiftUI

class MoodData{
    var color: Color = .white
    var mood: String = ""
    var percentage: Int = 100
    var focused = false
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var radius: CGFloat = 0
    
    init(mood: String, percentage: Int, focused: Bool = false) {
        self.mood = mood
        self.percentage = percentage
        self.focused = focused
        radius = CGFloat(percentage * 3 / 4 + 30)
        if focused{
            radius *= 1.2
        }
        switch mood{
        case "Happy":
            color = .yellow
        case "Sad":
            color = .blue
        case "Mad":
            color = .red
        case "Fear":
            color = .purple
        case "Disgust":
            color = .green
        default:
            color = .clear
        }

    }
    
    func setPosition(position: CGPoint){
        self.position = position
    }
}
