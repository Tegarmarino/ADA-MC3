//
//  JournalView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct JournalView: View {
    @State private var text: NSAttributedString = NSAttributedString(string: "")
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var isUnderline: Bool = false
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButton()
                    Spacer()
                }
                .padding(.top, geometry.safeAreaInsets.top)

                VStack {
                    Text("What's on your mind?")
                        .font(FontWeightFormat().textHeadlineOne)
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme)
                            .frame(height: 7)
                            .cornerRadius(5)
                        
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme)
                            .frame(height: 7)
                            .cornerRadius(5)
                        
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme.opacity(0.2))
                            .frame(height: 7)
                            .cornerRadius(5)
                    }
                    .padding(.vertical, 20)
                }

                RichTextEditor(text: $text, isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline, placeholder: "Type in here...")
                    .frame(height: 480)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(Color.theme.backgroundColorOneTheme.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .overlay(
                JournalToolBar(
                    JournalToolBarIcon: ["photo.badge.plus", "mic.badge.plus", "bold", "italic", "underline", "keyboard.chevron.compact.down"],
                    isBold: $isBold,
                    isItalic: $isItalic,
                    isUnderline: $isUnderline,
                    closeKeyboardAction: closeKeyboard
                )
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .background(Color.white) // Or any other background color for the toolbar
                .frame(height: 50) // Or the height of your toolbar
                .offset(y: keyboardHeight == 0 ? 200 : -keyboardHeight)
                ,alignment: .bottom
            )
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                    keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                }
            }
        }
    }

    private func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}




//struct JournalView: View {
//    @State private var text: NSAttributedString = NSAttributedString(string: "")
//    @State private var isBold: Bool = false
//    @State private var isItalic: Bool = false
//    @State private var isUnderline: Bool = false
//    
//    var body: some View {
//        VStack {
//            HStack {
//                BackButton()
//                Spacer()
//            }
//            
//            Text("What's on your mind?")
//                .font(FontWeightFormat().textHeadlineOne)
//            HStack(spacing: 10) {
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme)
//                    .frame(height: 7)
//                    .cornerRadius(5)
//                                
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme)
//                    .frame(height: 7)
//                    .cornerRadius(5)
//                                
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme.opacity(0.2))
//                    .frame(height: 7)
//                    .cornerRadius(5)
//            }
//            .padding(.vertical, 20)
//            
//            RichTextEditor(text: $text, isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline, placeholder: "Type in here...")
//                .frame(height: 480)
//                .cornerRadius(8)
//                .padding(.horizontal, 10)
//            Spacer()
//            
//            JournalToolBar(
//                JournalToolBarIcon: ["photo.badge.plus", "mic.badge.plus", "bold", "italic", "underline"],
//                isBold: $isBold,
//                isItalic: $isItalic,
//                isUnderline: $isUnderline
//            )
//            .padding(.bottom, 30)
//        }
//        .padding(.horizontal, 10)
//        .background(Color.theme.backgroundColorOneTheme.ignoresSafeArea())
//        .navigationBarBackButtonHidden(true)
//        .keyboardResponsive() // Apply the keyboard responsive modifier here
//    }
//}
//
//#Preview {
//    JournalView()
//}





//struct JournalView: View {
//    @State private var text: NSAttributedString = NSAttributedString(string: "")
//    @State private var isBold: Bool = false
//    @State private var isItalic: Bool = false
//    @State private var isUnderline: Bool = false
//    
//    var body: some View {
//        VStack {
//            HStack {
//                BackButton()
//                Spacer()
//            }
//            
//            Text("What's on your mind?")
//                .font(FontWeightFormat().textHeadlineOne)
//            HStack(spacing: 10) {
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme)
//                    .frame(height: 7)
//                    .cornerRadius(5)
//                                
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme)
//                    .frame(height: 7)
//                    .cornerRadius(5)
//                                
//                Rectangle()
//                    .fill(Color.theme.primaryColorTheme.opacity(0.2))
//                    .frame(height: 7)
//                    .cornerRadius(5)
//            }
//            .padding(.vertical, 20)
//            
//            RichTextEditor(text: $text, isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline, placeholder: "Type in here...")
//                .frame(height: 480)
//                .cornerRadius(8)
//                .padding(.horizontal, 10)
//            Spacer()
//            
//            JournalToolBar(
//                JournalToolBarIcon: ["photo.badge.plus", "mic.badge.plus", "bold", "italic", "underline"],
//                isBold: $isBold,
//                isItalic: $isItalic,
//                isUnderline: $isUnderline
//            )
//            .padding(.bottom, 30)
//        }
//        .padding(.horizontal, 10)
//        .background(Color.theme.backgroundColorOneTheme.ignoresSafeArea())
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    JournalView()
//}
