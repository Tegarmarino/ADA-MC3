//
//  ContentView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(Application.self) private var app
    
    var body: some View {
        if app.page == .home {
            HomeView()
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
