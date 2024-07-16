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
    
    init(color: Color, mood: String, percentage: Int, focused: Bool = false) {
        self.color = color
        self.mood = mood
        self.percentage = percentage
        self.focused = focused
        radius = CGFloat(percentage * 3 / 4 + 30)
    }
    
    func setPosition(position: CGPoint){
        self.position = position
    }
}
