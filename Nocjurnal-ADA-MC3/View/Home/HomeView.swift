//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var selectedIndex = 0
    @State private var text: NSAttributedString = NSAttributedString(string: "")

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
                            
//                        List{
//                            ForEach (journalModel) { entry in
//                                VStack(alignment: .leading) {
//                                    AttributedText(attributedString: entry.text) // Display styled text
//                                    Text(entry.timestamp, style: .time)
//                                        .font(.caption)
//                                }
//                            }
//                            .onDelete { indexSet in
//                                for index in indexSet {
//                                  context.delete(journalModel[index])
//                                }
//                              }
//                        }
//                        .listStyle(PlainListStyle())
                            
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
