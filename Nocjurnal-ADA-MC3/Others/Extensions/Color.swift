//
//  Color.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let secondaryColorTheme = Color("SecondaryColorTheme").opacity(0.2)
    let primaryColorTheme = Color("PrimaryColorTheme")
    let successColorTheme = Color("SuccessColorTheme")
    let warningColorTheme = Color("WarningColorTheme")
    let backgroundColorOneTheme = Color("BackgroundColorOneTheme")
    let fontPrimaryColorTheme = Color("FontColorPrimaryTheme")
    let borderColorTheme = Color("BorderColorTheme")
    let backgroundColorTwoTheme = Color("BackgroundColorTwoTheme")
    let fontSecondaryColorTheme = Color("FontSecondaryColorTheme").opacity(0.5)
    let fontTertiaryColorTheme = Color("FontTertiaryColorTheme").opacity(0.5)
    let errorColorTheme = Color("ErrorColorTheme")
}
