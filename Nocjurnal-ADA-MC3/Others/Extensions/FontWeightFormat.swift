//
//  FontWeight.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(name: String, size: CGFloat) -> Font {
        return .custom(name, size: size)
    }
}

struct FontWeightFormat {
    let textHeadlineOne = Font.customFont(name: "Kodchasan-Bold", size: 24)
    let textHeadlineTwo = Font.customFont(name: "Kodchasan-Bold", size: 20)
    let textHeadlineThree = Font.customFont(name: "Kodchasan-Bold", size: 18)
    let textHeadlineFour = Font.customFont(name: "Kodchasan-Bold", size: 16)
    let textHeadlineFive = Font.customFont(name: "Kodchasan-Bold", size: 14)
    let textBodyOne = Font.customFont(name: "Kodchasan-Medium", size: 20)
    let textBodyTwo = Font.customFont(name: "Kodchasan-Medium", size: 18)
    let textBodyThree = Font.customFont(name: "Kodchasan-Medium", size: 16)
    let textBodyFour = Font.customFont(name: "Kodchasan-Medium", size: 14)
    let textBodyFive = Font.customFont(name: "Kodchasan-Medium", size: 12)
}
