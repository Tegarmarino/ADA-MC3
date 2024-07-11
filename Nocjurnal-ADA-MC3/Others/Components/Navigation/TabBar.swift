//
//  TabBar.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct TabBar: View {
    
    var tabBarIcon: [String]
    var tabBarTitle: [String]
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            HStack{
                ForEach(tabBarIcon.indices, id: \.self) { index in
                    VStack {
                        Image(systemName: tabBarIcon[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(.horizontal,20)
                            
                
                        Text(tabBarTitle[index])
                            .font(.caption)
                            .padding(.horizontal, 13)
                    }
                    .padding(.vertical,20)
                    .foregroundColor(selectedIndex == index ? Color.theme.primaryColorTheme : .white)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedIndex = index
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(.black.opacity(0.70))
            .cornerRadius(.infinity)
            
            NavigationLink(destination: MoodPickingView()) {
                Image(systemName: "pencil.and.scribble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .padding()
                    .background(Color.theme.primaryColorTheme)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TabBar(tabBarIcon: ["house.fill", "chart.bar", "person.2"], tabBarTitle: ["Home", "Growth", "Sharing"], selectedIndex: .constant(0))
}
