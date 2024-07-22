//
//  Style.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 15/07/24.
//

import SwiftUI

enum ButtonType {
    case primary
    case secondary
    case tertiary
    case quartenary
    case fab
}

enum ButtonState {
    case idle
    case loading
    case disabled
}

struct NocjournalButtonStyle: ButtonStyle {
    let type: ButtonType
    let icon: Bool
    
    @State private var scale = CGFloat(1.0)
    @State private var opacity = CGFloat(0.0)
    @State private var pressing = false
    @State private var holding = false
    @State private var animating = false
    @State private var released = false
    
    init(_ type: ButtonType, icon: Bool = false) {
        self.type = type
        self.icon = icon
    }
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        if type == .fab {
            configuration.label
                .frame(width: 72, height: 72, alignment: .center)
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color.theme.primaryColorTheme)
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color.theme.fontPrimaryColorTheme)
                            .opacity(opacity)
                    }
                }
                .onChange(of: configuration.isPressed) {
                    if configuration.isPressed {
                        animating = true
                        pressing = true
                        withAnimation(.spring(duration: 0.25)) {
                            if icon {
                                scale = CGFloat(0.9)
                            } else {
                                scale = CGFloat(0.95)
                            }
                            opacity = CGFloat(0.1)
                        } completion: {
                            finish()
                        }
                    } else {
                        release()
                    }
                }
                .scaleEffect(scale)

        } else {
            configuration.label
                .frame(height: type == .fab ? 72 : 48, alignment: .center)
                .background {
                    ZStack {
                        switch type {
                            case .primary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.primaryColorTheme)
                            case .secondary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.secondaryColorTheme)
                                    .strokeBorder(Color.theme.borderColorTheme, lineWidth: 1)
                            case .tertiary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.warningColorTheme)
                                    .strokeBorder(Color.theme.borderColorTheme, lineWidth: 1)
                            case .quartenary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.backgroundColorTwoTheme)
                                    .strokeBorder(Color.theme.borderColorTheme, lineWidth: 1)
                            default:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.backgroundColorTwoTheme)
                                    .strokeBorder(Color.theme.borderColorTheme, lineWidth: 1)
                        }
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.theme.fontPrimaryColorTheme)
                            .opacity(opacity)
                    }
                }
                .onChange(of: configuration.isPressed) {
                    if configuration.isPressed {
                        animating = true
                        pressing = true
                        withAnimation(.spring(duration: 0.25)) {
                            if icon {
                                scale = CGFloat(0.9)
                            } else {
                                scale = CGFloat(0.95)
                            }
                            opacity = CGFloat(0.1)
                        } completion: {
                            finish()
                        }
                    } else {
                        release()
                    }
                }
                .scaleEffect(scale)

        }
    }
    func finish() {
        animating = false
        if pressing {
            holding = true
        } else if released {
            reset()
        }
    }
    func release() {
        pressing = false
        if animating {
            released = true
        } else if holding {
            reset()
        }
    }
    func reset() {
        withAnimation(.spring(duration: 0.25)) {
            scale = 1.0
            opacity = 0.0
        }
    }
}
