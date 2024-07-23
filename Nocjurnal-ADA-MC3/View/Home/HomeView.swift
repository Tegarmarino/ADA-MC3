//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    
    @State private var buttonState = ButtonState.idle
    @State private var selectedIndex = 0
    @State private var showShopView = false  // State to control the modal sheet
    @State private var showtInventoryView = false
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack{
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    Spacer()
                }
                
                HStack{
                    ButtonIcon("bag", state: $buttonState, type: .secondary) {
                        showShopView.toggle()  // Toggle the modal sheet
                    }
                    .sheet(isPresented: $showShopView) {
                        ShopView()
                    }
                    Spacer()
                    ButtonIcon("xmark.bin", state: $buttonState, type: .secondary) {
                        showtInventoryView.toggle()
                    }
                    .sheet(isPresented: $showtInventoryView) {
                        InventoryView()
                    }
                }
                .padding(EdgeInsets(top: safeAreaInsets.top, leading: 24, bottom: 0, trailing: 24))
                .frame(width: VPW)
                .ignoresSafeArea()
            }
            
            Image("Nocy")
            Text("Level " + String(users.first?.lvl ?? 100))
            Text("Money " + String(users.first?.money ?? 100))

        }
        .frame(width: VPW, height: VPH, alignment: .topLeading)
        .ignoresSafeArea()
        .background(Color.theme.backgroundColorTwoTheme)
    }
    
}
