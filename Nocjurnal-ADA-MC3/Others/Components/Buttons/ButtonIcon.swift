//
//  ButtonIcon.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 16/07/24.
//

import SwiftUI

struct ButtonIcon: View {
    @Binding var state: ButtonState
    
    let icon: String
    let type: ButtonType
    let action: (() -> Void)
    
    init(_ icon: String, state: Binding<ButtonState>, type: ButtonType = .primary, action: @escaping (() -> Void)) {
        _state = state
        self.icon = icon
        self.type = type
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                if self.state == .loading {
                    ProgressView()
                } else {
                    Image(systemName: icon)
                        .foregroundColor(type == .primary || type == .tertiary ? Color.theme.fontSecondaryColorTheme : Color.theme.fontPrimaryColorTheme)
                        .font(.system(size: 14))
                        .fontWeight(.heavy)
                }
                Spacer()
            }
        })
        .frame(width: 48, height: 48)
        .buttonStyle(NocjournalButtonStyle(type, icon: true))
        .opacity(state == .disabled ? 0.25 : 1)
        .disabled(state == .disabled)
    }
}
