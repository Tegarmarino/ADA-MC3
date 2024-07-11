//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            Text("Home View")
                .tabItem { Image(systemName: "house.fill") }
            ReportView()
                .tabItem { Image(systemName: "chart.bar.fill") }
            JournalView()
                .tabItem { Image(systemName: "book.closed.fill") }
            FriendView()
                .tabItem { Image(systemName: "person.2.fill") }
            ProfileView()
                .tabItem { Image(systemName: "person.fill") }
        }
        
    }
}

#Preview {
    HomeView()
}
