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

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.currentWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

struct NocjournalButtonStyle: ButtonStyle {
    let type: ButtonType
    let icon: Bool
    let pill: Bool
    
    @State private var scale = CGFloat(1.0)
    @State private var opacity = CGFloat(0.0)
    @State private var pressing = false
    @State private var holding = false
    @State private var animating = false
    @State private var released = false
    
    init(_ type: ButtonType, icon: Bool = false, pill: Bool = false) {
        self.type = type
        self.icon = icon
        self.pill = pill
    }
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        if self.pill {
            configuration.label
                .padding(.horizontal, 12)
                .frame(height: 36, alignment: .center)
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .animation(.spring(duration: 0.25)) { content in
                                switch type {
                                    case .primary:
                                        content.foregroundStyle(Color.theme.primaryColorTheme)
                                    case .secondary:
                                        content.foregroundStyle(Color.theme.secondaryColorTheme)
                                    case .tertiary:
                                        content.foregroundStyle(Color.theme.warningColorTheme)
                                    case .quartenary:
                                        content.foregroundStyle(Color.theme.backgroundColorOneTheme)
                                    default:
                                        content.foregroundStyle(Color.theme.backgroundColorTwoTheme)
                                }
                            }
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.theme.fontPrimaryColorTheme)
                            .opacity(opacity)
                    }
                }
                .onChange(of: configuration.isPressed) {
                    if configuration.isPressed {
                        animating = true
                        pressing = true
                        withAnimation(.spring(duration: 0.25)) {
                            scale = CGFloat(0.9)
                            opacity = CGFloat(0.1)
                        } completion: {
                            finish()
                        }
                    } else {
                        release()
                    }
                }
                .scaleEffect(scale)
        } else if type == .fab {
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
                            case .tertiary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.warningColorTheme)
                            case .quartenary:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.backgroundColorTwoTheme)
                            default:
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.theme.backgroundColorTwoTheme)
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

