//
//  JournalView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(Application.self) private var app
    @Environment(\.modelContext) var context
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Query private var journalModel: [JournalModel]
    
    @State private var draft = JournalDraft()
    
    @State private var pageHeaderHeight = 107.0
    @State private var pageIndex = 0
    @State private var pageOffset = 0.0
    @State private var pageState = ((0.0, 0.0, 1.0, 1.0, 1.0), (36.0, 10.0, 0.0, 0.85, 0.2), (36.0, 10.0, 0.0, 0.85, 0.2))
    
    @State private var backButtonState = ButtonState.idle
    @State private var submitButtonState = ButtonState.idle

    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                MoodPickingView($draft.mood) {
                    pageNext()
                }
                EditingView($draft.contents) {
                    closeKeyboard()
                    pageNext()
                }
                TaggingView($draft.tags) {
                    saveJournal()
                    app.path.append(.reward)
                }
            }
            .padding(EdgeInsets(top: pageHeaderHeight, leading: 0, bottom: 0, trailing: 0))
            .frame(width: 3 * VPW)
            .offset(x: pageOffset)

            VStack(alignment: .leading, spacing: 24) {
                HStack(spacing: 0) {
                    ButtonIcon("arrow.left", state: $backButtonState, type: .secondary) {
                        closeKeyboard()
                        if pageIndex != 0 {
                            pagePrev()
                        } else {
                            let _ = app.path.popLast()
                        }
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 12) {
                    ZStack(alignment: .leading) {
                        Text("How are you feeling today")
                            .font(Font.format.textHeadlineOne)
                            .offset(y: pageState.0.0)
                            .blur(radius: pageState.0.1)
                            .opacity(pageState.0.2)
                            .scaleEffect(pageState.0.3, anchor: .leading)
                        Text("What's on your mind?")
                            .font(Font.format.textHeadlineOne)
                            .offset(y: pageState.1.0)
                            .blur(radius: pageState.1.1)
                            .opacity(pageState.1.2)
                            .scaleEffect(pageState.1.3, anchor: .leading)
                        Text("Additional information")
                            .font(Font.format.textHeadlineOne)
                            .offset(y: pageState.2.0)
                            .blur(radius: pageState.2.1)
                            .opacity(pageState.2.2)
                            .scaleEffect(pageState.2.3, anchor: .leading)
                    }
                    HStack(spacing: 12) {
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme)
                            .frame(height: 4)
                            .cornerRadius(2)
                            .opacity(pageState.0.4)
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme)
                            .frame(height: 4)
                            .cornerRadius(2)
                            .opacity(pageState.1.4)
                        Rectangle()
                            .fill(Color.theme.primaryColorTheme)
                            .frame(height: 4)
                            .cornerRadius(2)
                            .opacity(pageState.2.4)
                    }
                }
            }
            .padding(EdgeInsets(top: safeAreaInsets.top, leading: 24, bottom: 0, trailing: 24))
            .frame(width: VPW)
            .ignoresSafeArea()
        }
        .frame(width: VPW, alignment: .topLeading)
        .background(Color.theme.backgroundColorOneTheme)
        .navigationBarBackButtonHidden(true)
    }
    
    private func saveJournal() {
        let model = JournalModel(mood: draft.mood, contents: draft.contents, tags: draft.tags, timestamp: Date())
        context.insert(model)
    }
    
    private func pageNext() {
        withAnimation(.spring(duration: 0.5)) {
            if pageIndex == 0 {
                pageState = ((-36.0, 10.0, 0.0, 0.85, 1.0), (0.0, 0.0, 1.0, 1.0, 1.0), (36.0, 10.0, 0.0, 0.85, 0.2))
                pageOffset = CGFloat(-VPW)
            } else {
                pageState = ((-36.0, 10.0, 0.0, 0.85, 1.0), (-36.0, 10.0, 0.0, 0.85, 1.0), (0.0, 0.0, 1.0, 1.0, 1.0))
                pageOffset = CGFloat(-VPW * 2)
            }
        } completion: {
            if pageIndex == 0 {
                pageIndex = 1
            } else {
                pageIndex = 2
            }
        }
    }
    private func pagePrev() {
        withAnimation(.spring(duration: 0.5)) {
            if pageIndex == 2 {
                pageState = ((-36.0, 10.0, 0.0, 0.85, 1.0), (0.0, 0.0, 1.0, 1.0, 1.0), (36.0, 10.0, 0.0, 0.85, 0.2))
                pageOffset = CGFloat(-VPW)
            } else {
                pageState = ((0.0, 0.0, 1.0, 1.0, 1.0), (36.0, 10.0, 0.0, 0.85, 0.2), (36.0, 10.0, 0.0, 0.85, 0.2))
                pageOffset = CGFloat(0)
            }
        } completion: {
            if pageIndex == 2 {
                pageIndex = 1
            } else {
                pageIndex = 0
            }
        }
    }

    private func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
