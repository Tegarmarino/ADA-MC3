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
    var color: LinearGradient
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
                self.color = Color.mood.happy
            case .sad:
                self.color = Color.mood.sad
            case .angry:
                self.color = Color.mood.angry
            case .scared:
                self.color = Color.mood.scared
            case .disgusted:
                self.color = Color.mood.disgusted
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
