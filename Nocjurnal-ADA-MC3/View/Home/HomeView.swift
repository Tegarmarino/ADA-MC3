//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedIndex = 0

    var body: some View {
        NavigationStack{
            VStack {
                ZStack {
                    switch selectedIndex {
                    case 0:
                        VStack {
                            HStack{
                                NavigationLink(destination: ShopView()){
                                    CircleButton(icon: "bag.fill")
                                }
                                Spacer()
                                NavigationLink(destination: ProfileView()) {
                                    CircleButton(icon: "person.fill")
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    case 1:
                        ReportView()
                    case 2:
                        FriendView()
                    default:
                        VStack {
                            Text("Home View")
                                .font(FontWeightFormat().textHeadlineOne)
                            Text("Home View")
                                .font(FontWeightFormat().textHeadlineTwo)
                            Text("Home View")
                                .font(.custom("Kodchasan-Bold", size: 24))
                        }
                    }
                }
                Spacer()
                TabBar(tabBarIcon: ["house.fill", "chart.bar", "person.2"], tabBarTitle: ["Home", "Growth", "Friends"], selectedIndex: $selectedIndex)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
