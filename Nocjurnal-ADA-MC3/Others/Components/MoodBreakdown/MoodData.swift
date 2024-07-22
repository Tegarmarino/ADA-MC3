//
//  MoodData.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import Foundation
import SwiftUI

class MoodData{
    var mood: JournalMood
    var color = Color.white
    var percentage = 0
    var focused = false
    var position = CGPoint(x: UIScreen.main.bounds.width / 2 - 24, y: UIScreen.main.bounds.width / 2 - 24)
    var radius = CGFloat(0)
    
    init(mood: JournalMood, focused: Bool = false) {
        self.mood = mood
        self.focused = focused
        radius = CGFloat(percentage * 3 / 4 + 30)
        
        switch mood {
            case .happy:
                color = .yellow
            case .sad:
                color = .blue
            case .angry:
                color = .red
            case .scared:
                color = .purple
            case .disgusted:
                color = .green
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
