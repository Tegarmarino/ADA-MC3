//
//  getColor.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 23/07/24.
//

import SwiftUI

func getColor(for mood: JournalMood) -> (color: Color, imageName: String) {
    switch mood {
        case .happy:
            return (.yellow, "Joy")
        case .sad:
            return (.blue, "Sad")
        case .angry:
            return (.red, "Anger")
        case .scared:
            return (.purple, "Fear")
        case .disgusted:
            return (.green, "Disgust")
    }
}
