//
//  MoodPickingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct MoodPickingView: View {
    var body: some View {
        VStack{
            HStack {
                BackButton()
                Spacer()
            }
            
            
            Text("How are you feeling today?")
                .font(FontWeightFormat().textHeadlineOne)
            HStack(spacing: 10) {
                Rectangle()
                    .fill(Color.theme.primaryColorTheme)
                    .frame(height: 7)
                    .cornerRadius(5)
                
                Rectangle()
                    .fill(Color.theme.primaryColorTheme.opacity(0.2))
                    .frame(height: 7)
                    .cornerRadius(5)
                
                Rectangle()
                    .fill(Color.theme.primaryColorTheme.opacity(0.2))
                    .frame(height: 7)
                    .cornerRadius(5)
            }
            .padding(.vertical, 20)
            Spacer()
            
            NavigationLink(destination: JournalView()) {
                NextButton(title: "Begin Writing")
            }
            .padding(.bottom, 30)
            
        }
        .padding(.horizontal, 10)
        .background(Color.theme.backgroundColorOneTheme.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MoodPickingView()
}
