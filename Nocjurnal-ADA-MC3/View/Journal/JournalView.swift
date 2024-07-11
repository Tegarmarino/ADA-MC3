//
//  JournalView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct JournalView: View {
    var body: some View {
        VStack{
            HStack {
                BackButton()
                Spacer()
            }
            
            
            Text("What on your mind?")
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
            Spacer()
            
            JournalToolBar(JournalToolBarIcon: ["photo.badge.plus", "mic.badge.plus", "bold", "italic", "underline"])
            
        }
        .padding(.horizontal, 10)
        .background(Color.theme.backgroundColorOne.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    JournalView()
}
