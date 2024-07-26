//
//  Color.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let mood = MoodGradient()
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct ColorTheme {
    let secondaryColorTheme = Color("SecondaryColorTheme").opacity(0.2)
    let primaryColorTheme = Color("PrimaryColorTheme")
    let successColorTheme = Color("SuccessColorTheme")
    let warningColorTheme = Color("WarningColorTheme")
    let backgroundColorOneTheme = Color("BackgroundColorOneTheme")
    let borderColorTheme = Color("BorderColorTheme")
    let backgroundColorTwoTheme = Color("BackgroundColorTwoTheme")
    let fontPrimaryColorTheme = Color("FontColorPrimaryTheme")
    let fontSecondaryColorTheme = Color("FontSecondaryColorTheme").opacity(0.5)
    let fontTertiaryColorTheme = Color("FontTertiaryColorTheme").opacity(0.5)
    let errorColorTheme = Color("ErrorColorTheme")
}

struct MoodGradient {
    let disgusted = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0x97CCA1), Color(hex: 0xC6DFC0)]),
        startPoint: .top,
        endPoint: .bottom
    )
    let angry = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0xCB8687), Color(hex: 0xDFB9AF)]),
        startPoint: .top,
        endPoint: .bottom
    )
    let scared = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0xE1D0E5), Color(hex: 0xEDE2E5)]),
        startPoint: .top,
        endPoint: .bottom
    )
    let sad = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0xDCECEE), Color(hex: 0xDCECEE)]),
        startPoint: .top,
        endPoint: .bottom
    )
    let happy = LinearGradient(
        gradient: Gradient(colors: [Color(hex: 0xF2F0BD), Color(hex: 0xF2F0BD)]),
        startPoint: .top,
        endPoint: .bottom
    )
}
