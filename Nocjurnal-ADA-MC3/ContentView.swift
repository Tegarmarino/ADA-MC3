//
//  ContentView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(Application.self) private var app
    @Environment(\.modelContext) var context
    @AppStorage("passcodeState") private var passcodeState: Bool = false // Use AppStorage for global state

    var body: some View {
        if app.page == .home {
            HomeView()
                .onAppear {
                    let newUser = User()
                    context.insert(newUser)
                }
        } else if app.page == .growth {
            ReportView()
        } else if app.page == .sharing {
            FriendView()
        }
    }
}

#Preview {
    ContentView()
}
