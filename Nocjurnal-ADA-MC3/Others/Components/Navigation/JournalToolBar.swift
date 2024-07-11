//
//  JournalToolBar.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct JournalToolBar: View {
    var JournalToolBarIcon: [String]
    
//    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            HStack{
                ForEach(JournalToolBarIcon.indices, id: \.self) { index in
                    VStack {
                        Image(systemName: JournalToolBarIcon[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(.horizontal,13)
                            
                    }
                    .padding(.vertical,12)
                    .foregroundColor(.black)
//                    .onTapGesture {
//                        withAnimation(.easeInOut) {
//                            selectedIndex = index
//                        }
//                    }
                }
            }
            .padding(.horizontal)
            .background(.black.opacity(0.5))
            .cornerRadius(.infinity)
            
            NavigationLink(destination: HomeView()) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.all,12)
                    .background(Color.theme.primaryColorTheme)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    JournalToolBar(JournalToolBarIcon: ["photo.badge.plus", "mic.badge.plus", "bold", "italic", "underline"])
}
