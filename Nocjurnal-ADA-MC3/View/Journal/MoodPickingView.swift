//
//  MoodPickingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct MoodPickingView: View {
    let action: (() -> Void)
    
    @Binding var selected: JournalMood
    
    @State private var buttonState = ButtonState.idle

    let VPW = UIScreen.main.bounds.size.width
    
    init(_ selected: Binding<JournalMood>, action: @escaping () -> Void) {
        _selected = selected
        self.action = action
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text("You are feeling")
                        .font(Font.format.textHeadlineFive)
                        .foregroundStyle(Color.theme.fontSecondaryColorTheme)
                    ZStack {
                        Text("Joyful")
                            .font(Font.format.textHeadlineTwo)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                            .blur(radius: selected == .happy ? 0.0 : 10.0)
                            .opacity(selected == .happy ? 1.0 : 0.0)
                            .animation(.spring(duration: 0.25), value: selected == .happy)
                        Text("Angry")
                            .font(Font.format.textHeadlineTwo)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                            .blur(radius: selected == .angry ? 0.0 : 10.0)
                            .opacity(selected == .angry ? 1.0 : 0.0)
                            .animation(.spring(duration: 0.25), value: selected == .angry)
                        Text("Disgusted")
                            .font(Font.format.textHeadlineTwo)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                            .blur(radius: selected == .disgusted ? 0.0 : 10.0)
                            .opacity(selected == .disgusted ? 1.0 : 0.0)
                            .animation(.spring(duration: 0.25), value: selected == .disgusted)
                        Text("Scared")
                            .font(Font.format.textHeadlineTwo)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                            .blur(radius: selected == .scared ? 0.0 : 10.0)
                            .opacity(selected == .scared ? 1.0 : 0.0)
                            .animation(.spring(duration: 0.25), value: selected == .scared)
                        Text("Sad")
                            .font(Font.format.textHeadlineTwo)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                            .blur(radius: selected == .sad ? 0.0 : 10.0)
                            .opacity(selected == .sad ? 1.0 : 0.0)
                            .animation(.spring(duration: 0.25), value: selected == .sad)
                    }
                }
                HStack(spacing: 24) {
                    Image("Joy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .opacity(selected == .happy ? 1.0 : 0.5)
                        .grayscale(selected == .happy ? 0.0 : 1.0)
                        .scaleEffect(selected == .happy ? 1.0 : 0.85)
                        .animation(.spring(duration: 0.25), value: selected == .happy)
                        .onTapGesture {
                            selected = .happy
                        }
                    Image("Anger")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .opacity(selected == .angry ? 1.0 : 0.5)
                        .grayscale(selected == .angry ? 0.0 : 1.0)
                        .scaleEffect(selected == .angry ? 1.0 : 0.85)
                        .animation(.spring(duration: 0.25), value: selected == .angry)
                        .onTapGesture {
                            selected = .angry
                        }
                    Image("Disgust")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .opacity(selected == .disgusted ? 1.0 : 0.5)
                        .grayscale(selected == .disgusted ? 0.0 : 1.0)
                        .scaleEffect(selected == .disgusted ? 1.0 : 0.85)
                        .animation(.spring(duration: 0.25), value: selected == .disgusted)
                        .onTapGesture {
                            selected = .disgusted
                        }
                    Image("Fear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .opacity(selected == .scared ? 1.0 : 0.5)
                        .grayscale(selected == .scared ? 0.0 : 1.0)
                        .scaleEffect(selected == .scared ? 1.0 : 0.85)
                        .animation(.spring(duration: 0.25), value: selected == .scared)
                        .onTapGesture {
                            selected = .scared
                        }
                    Image("Sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .opacity(selected == .sad ? 1.0 : 0.5)
                        .grayscale(selected == .sad ? 0.0 : 1.0)
                        .scaleEffect(selected == .sad ? 1.0 : 0.85)
                        .animation(.spring(duration: 0.25), value: selected == .sad)
                        .onTapGesture {
                            selected = .sad
                        }
                }
            }
            Spacer()
            ButtonRegular("Begin writing", state: $buttonState) {
                action()
            }
        }
        .padding(.horizontal, 24)
        .frame(width: VPW)
    }
}
