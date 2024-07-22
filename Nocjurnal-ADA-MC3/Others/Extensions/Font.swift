//
//  FontWeight.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

extension Font {
    static let format = FontFormat()
}

struct FontFormat {
    let textHeadlineOne = Font.custom("Kodchasan-Bold", size: 24)
    let textHeadlineTwo = Font.custom("Kodchasan-Bold", size: 20)
    let textHeadlineThree = Font.custom("Kodchasan-Bold", size: 18)
    let textHeadlineFour = Font.custom("Kodchasan-Bold", size: 16)
    let textHeadlineFive = Font.custom("Kodchasan-Bold", size: 14)
    let textBodyOne = Font.custom("Kodchasan-Medium", size: 20)
    let textBodyTwo = Font.custom("Kodchasan-Medium", size: 18)
    let textBodyThree = Font.custom("Kodchasan-Medium", size: 16)
    let textBodyFour = Font.custom("Kodchasan-Medium", size: 14)
    let textCaption = Font.custom("Kodchasan-Medium", size: 12)
}
