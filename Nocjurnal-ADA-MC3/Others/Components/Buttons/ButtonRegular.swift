//
//  ButtonRegular.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 15/07/24.
//

import SwiftUI

struct ButtonRegular: View {
    @Binding var state: ButtonState
    @State private var opacity = 1.0
    
    let label: String
    let type: ButtonType
    let action: (() -> Void)
    
    init(_ label: String, state: Binding<ButtonState>, type: ButtonType = .primary, action: @escaping (() -> Void)) {
        _state = state
        opacity = state.wrappedValue == .disabled ? 0.25 : 1.0
        
        self.label = label
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
                    Text(label)
                        .font(Font.format.textHeadlineFive)
                        .foregroundColor(type == .primary || type == .tertiary ? Color.white : Color.white)
                }
                Spacer()
            }
        })
        .buttonStyle(NocjournalButtonStyle(type))
        .opacity(opacity)
        .disabled(state == .disabled)
        .onChange(of: state) {
            if state == .disabled {
                withAnimation(.spring(duration: 0.25)) {
                    opacity = 0.25
                }
            } else {
                withAnimation(.spring(duration: 0.25)) {
                    opacity = 1.0
                }
            }
        }
    }
}
