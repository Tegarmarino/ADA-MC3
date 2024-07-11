//
//  MoodPickingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct MoodPickingView: View {
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: JournalView()){
                    Text("Pergi ke journal view")
                }
                NavigationLink(destination: JournalView()) {
                    NextButton(title: "Begin Writing")
                }
            }
        }
    }
}

#Preview {
    MoodPickingView()
}
