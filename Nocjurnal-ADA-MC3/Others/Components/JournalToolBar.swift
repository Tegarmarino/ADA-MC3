//
//  JournalToolBar.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

enum JournalToolBarAction {
    case save
    case image
    case voice
}

struct JournalToolBar: View {
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var isUnderline: Bool
    
    @State private var submitState = ButtonState.idle
    
    let action: (JournalToolBarAction) -> Void
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        HStack(spacing: 18) {
            HStack(spacing: 4) {
                HStack(spacing: 0) {
                    Button {
                        action(.image)
                    } label: {
                        Image(systemName: "photo.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundStyle(Color.theme.fontTertiaryColorTheme)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 48)
                    Button {
                        action(.voice)
                    } label: {
                        Image(systemName: "mic.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundStyle(Color.theme.fontTertiaryColorTheme)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 48)
                }
                Rectangle()
                    .fill(Color.theme.fontTertiaryColorTheme)
                    .opacity(0.5)
                    .frame(width: 1, height: 24)
                HStack(spacing: 0) {
                    Button {
                        isBold.toggle()
                    } label: {
                        Image(systemName: "bold")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundStyle(isBold ? Color.theme.primaryColorTheme : Color.theme.fontTertiaryColorTheme)
                            .scaleEffect(isBold ? 1 : 0.9)
                            .animation(.spring(duration: 0.25), value: isBold)

                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 48)
                    Button {
                        isItalic.toggle()
                    } label: {
                        Image(systemName: "italic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundStyle(isItalic ? Color.theme.primaryColorTheme : Color.theme.fontTertiaryColorTheme)
                            .scaleEffect(isItalic ? 1 : 0.9)
                            .animation(.spring(duration: 0.25), value: isItalic)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 48)
                    Button {
                        isUnderline.toggle()
                    } label: {
                        Image(systemName: "underline")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundStyle(isUnderline ? Color.theme.primaryColorTheme : Color.theme.fontTertiaryColorTheme)
                            .scaleEffect(isUnderline ? 1 : 0.9)
                            .animation(.spring(duration: 0.25), value: isUnderline)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 48)
                }
            }
            .padding(.horizontal, 12)
            .frame(width: VPW - 114)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.ultraThinMaterial)
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.theme.fontPrimaryColorTheme)
                        .opacity(0.75)
                }
            )
            
            ButtonIcon("checkmark", state: $submitState) {
                action(.save)
            }
        }
    }
}
