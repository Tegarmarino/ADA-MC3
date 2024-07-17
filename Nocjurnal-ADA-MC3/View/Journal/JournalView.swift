//
//  JournalView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) var context
    @Environment(Application.self) private var app
    @Query private var journalModel: [JournalModel]
    @State private var navigateToHome: Bool = false
    
    @State private var text: NSAttributedString = NSAttributedString(string: "")
    @State private var selectedDate: Date = Date() // Default to today's date
    
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var isUnderline: Bool = false
    
    @State private var keyboardHeight: CGFloat = 100
    
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
                
                DatePicker("Entry Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                
                
                RichTextEditor(text: $text, isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline, placeholder: "Type in here...")
                    .frame(height: 480)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
//                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
//                    EmptyView()
//                }
                
                //                Button("Save") {
                //                    print("Saving text: \(text.string)") // Debug print to check what text is being saved
                //                    let newJournal = JournalModel(text: text)
                //                    context.insert(newJournal)
                //                    text = NSAttributedString(string: "") // Reset after saving
                //                    navigateToHome = true
                //                }
                
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
                    closeKeyboardAction: closeKeyboard,
                    saveAction: saveText
                )
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .background(Color.white)
                .frame(height: 50)
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
    
    //    private func saveText() {
    //        print("Saving text: \(text.string)") // Debug print to check what text is being saved
    //        let newJournal = JournalModel(text: text)
    //        context.insert(newJournal)
    //        text = NSAttributedString(string: "") // Reset after saving
    //        navigateToHome = true
    //    }
    
//     Test teste 
    
    private func saveText() {
        print("Saving text: \(text.string)") // Debug print to check what text is being saved
        let newJournal = JournalModel(text: text, timestamp: selectedDate)  // Initialize with selected date
        context.insert(newJournal)
        text = NSAttributedString(string: "") // Reset after saving
//        navigateToHome = true
        let _ = app.path.popLast()
    }
    
    
    
    private func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
