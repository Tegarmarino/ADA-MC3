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
            VStack{
                Text("Home View")
                    .font(FontWeightFormat().textHeadlineOne)
                Text("Home View")
                    .font(FontWeightFormat().textHeadlineTwo)
                Text("Home View")
                    .font(.custom("Kodchasan-Bold", size: 24))
            }
                .tabItem { Image(systemName: "house.fill") }
            ReportView()
                .tabItem { Image(systemName: "chart.bar.fill") }
            MoodPickingView()
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
