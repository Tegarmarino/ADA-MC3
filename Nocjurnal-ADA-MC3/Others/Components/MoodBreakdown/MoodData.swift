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
    var percentage: Int = 0
    var focused = false
    var position: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
    var radius: CGFloat = 0
    
    init(mood: String, focused: Bool = false) {
        self.mood = mood
        self.focused = focused
        radius = CGFloat(percentage * 3 / 4 + 30)
        
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
        
        func setPercentage(percentage: Int){
            self.percentage = percentage
            radius = CGFloat(percentage * 3 / 4 + 30)
        }
    }

