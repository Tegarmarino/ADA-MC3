//
//  ShopView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import Foundation
import SwiftUI
import SwiftData

//enum ViewMode {
//    case shop
//    case inventory
//}

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    @State private var showAlert = false
    @State private var selectedTab = 0 // Start with the "Hats" tab
    
    @Query(sort: \User.money, order: .reverse) var users: [User]
    @Query var purchasedItems: [UserInventoryItem]
    
    
    //    @Environment(\.presentationMode) var presentationMode // To dismiss the modal
    //    @Environment(\.modelContext) var modelContext // SwiftData environment
    //
    //    @State private var showAlert = false
    //
    //    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    //    @Query var purchasedItems: [UserInventoryItem] // Fetch purchased items
    
    let shopItems: [ShopItem] = [
        ShopItem(type: .clothes, price: 150, image: "Clothes1"),
        ShopItem(type: .clothes, price: 300, image: "Clothes2"),
        ShopItem(type: .clothes, price: 450, image: "Clothes3"),
        ShopItem(type: .clothes, price: 600, image: "Clothes4"),
        ShopItem(type: .hat, price: 150, image: "Hat1"),
        ShopItem(type: .hat, price: 300, image: "Hat2"),
        ShopItem(type: .hat, price: 450, image: "Hat3"),
        ShopItem(type: .hat, price: 600, image: "Hat4"),
        ShopItem(type: .wallpaper, price: 150, image: "Wallpaper1"),
        ShopItem(type: .wallpaper, price: 300, image: "Wallpaper2"),
        ShopItem(type: .wallpaper, price: 450, image: "Wallpaper3"),
        ShopItem(type: .wallpaper, price: 600, image: "Wallpaper4"),
        ShopItem(type: .wallpaper, price: 850, image: "Wallpaper5"),
        // ... other items ...
    ]
    
    let VPW = UIScreen.main.bounds.size.width
    
    var body: some View {
        //        VStack {
        //            HStack {
        //                Button(action: {
        //                    presentationMode.wrappedValue.dismiss() // Dismiss the modal
        //                }) {
        //                    Image(systemName: "xmark") // Using SF Symbols for the close button
        //                        .font(.title)
        //                        .foregroundColor(.black)
        //                }
        //                Spacer()
        //            }
        //            .padding()
        //
        //            if let user = users.first { // Assuming you have one User
        //                Text("Money: $\(user.money)") // Display money
        //                HStack {
        //                    Button("Add Money") {
        //                        addMoney(to: user)
        //                    }
        //                    Spacer()
        //                }
        //            }
        //
        //            ScrollView {
        //                VStack(alignment: .leading, spacing: 20) {
        //                    // Clothes category
        //                    Text("Clothes").font(.headline)
        //                    LazyVStack(spacing: 10) {
        //                        ForEach(shopItems) { item in // Iterate over ShopItem directly
        //                            if item.type == .clothes && !purchasedItems.contains(where: { $0.image == item.image }) {
        //                                ShopItemView(item: item) { // Pass ShopItem to ShopItemView
        //                                    buyItem(item)
        //                                }
        //                            }
        //                        }
        //                    }
        //
        //                    // Hats category (apply the same change as above)
        //                    Text("Hats").font(.headline).padding(.top, 20)
        //                    LazyVStack(spacing: 10) {
        //                        ForEach(shopItems) { item in
        //                            if item.type == .hat && !purchasedItems.contains(where: { $0.image == item.image }) {
        //                                ShopItemView(item: item) {
        //                                    buyItem(item)
        //                                }
        //                            }
        //                        }
        //                    }
        //                    Text("Wallpaper").font(.headline).padding(.top, 20)
        //                    LazyVStack(spacing: 10) {
        //                        ForEach(shopItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" }) { item in // Filter out Wallpaper1
        //                            ShopItemView(item: item) {
        //                                buyItem(item)
        //                            }
        //                        }
        //                    }
        //                }
        //                .padding()
        //            }
        //
        //            Spacer()
        //            Text("Shop View")
        //        }
        
        //        .alert("Insufficient Funds", isPresented: $showAlert) {
        //            Button("OK", role: .cancel) { }
        //        } message: {
        //            Text("You don't have enough money to buy this item.")
        //        }
        
        NavigationView { // Use NavigationView to take over the full screen
            VStack(spacing: 0) {
                // Custom Navigation Bar (Removed the close button)
                HStack {
                    HStack(spacing: 20) {
                        Spacer()
                        Button("Hats") { selectedTab = 0 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 0 ? Font.format.textHeadlineFour : Font.format.textBodyFour) // Corrected font selection
                            .fontWeight(selectedTab == 0 ? .bold : .regular) // Simplified fontWeight
                        
                        Button("Clothes") { selectedTab = 1 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 1 ? Font.format.textHeadlineFour : Font.format.textBodyFour) // Corrected font selection
                            .fontWeight(selectedTab == 1 ? .bold : .regular)
                        
                        Button("Wallpaper") { selectedTab = 2 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 2 ? Font.format.textHeadlineFour : Font.format.textBodyFour) // Corrected font selection
                            .fontWeight(selectedTab == 2 ? .bold : .regular)
                        Spacer()
                    }
                    .padding(.vertical, 25)
                }
                .padding(.horizontal)
                .background(Color.theme.primaryColorTheme) // Set the blue background
                
                
                TabView(selection: $selectedTab) {
                    ShopItemsPage(shopItems: shopItems.filter { $0.type == .hat },
                                  purchasedItems: purchasedItems, buyAction: buyItem)
                    .tag(0)
                    
                    ShopItemsPage(shopItems: shopItems.filter { $0.type == .clothes },
                                  purchasedItems: purchasedItems, buyAction: buyItem)
                    .tag(1)
                    
                    ShopItemsPage(shopItems: shopItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" },
                                  purchasedItems: purchasedItems, buyAction: buyItem)
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .background(Color.theme.backgroundColorTwoTheme)
            .navigationTitle("") // Hide the default navigation title
            .navigationBarHidden(true) // Hide the default navigation bar
        } // End of NavigationView
        .frame(width: VPW)
        .alert("Insufficient Funds", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You don't have enough money to buy this item.")
        }
        
        .alert("Insufficient Funds", isPresented: $showAlert) { // The alert modifier
            Button("OK", role: .cancel) { }
        } message: {
            Text("You don't have enough money to buy this item.")
        }
        //        .padding(.horizontal, 10)
        .navigationBarBackButtonHidden(true) // Sembunyikan tombol kembali bawaan
        
    }
    
    func buyItem(_ item: ShopItem) { // Now accepts ShopItem
        guard let user = users.first, user.money >= item.price else {
            showAlert = true
            return
        }
        
        // Check if the item is a wallpaper and has already been purchased
        let alreadyPurchased = purchasedItems.contains {
            $0.type == item.type && $0.image == item.image
        }
        
        if item.type == .wallpaper && alreadyPurchased {
            // Show an alert or provide feedback that the wallpaper is already owned
            showAlert = true // You might want to create a different alert message here
            return
        }
        
        user.money -= item.price
        let newItem = UserInventoryItem(type: item.type, price: item.price, image: item.image)
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving changes: \(error)")
        }
    }
    
    
    func addMoney(to user: User) {
        user.money += 50 // Add 50 money (you can customize this)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}


struct CustomToolbarButtonStyle: ButtonStyle {
    let isActive: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isActive ? Color.white : Color.clear) // Active tab gets white background
            .foregroundColor(isActive ? Color.black : Color.white) // Active tab gets black text
            .cornerRadius(10)
    }
}


// View to display items in a grid
//struct ItemsPage: View {
//    let shopItems: [ShopItem]
//    let purchasedItems: [UserInventoryItem]
//    let buyAction: (ShopItem) -> Void
//
//
//    var body: some View {
//        ScrollView { // Added ScrollView for vertical scrolling
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                ForEach(shopItems) { item in
//                    if !purchasedItems.contains(where: { $0.image == item.image }) {
//                        ShopItemView(item: item) { buyAction(item) }
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.backgroundColorOneTheme)
//                            )
//                    }
//                }
//            }
//            .padding()
//        }
//        .background(Color.theme.backgroundColorTwoTheme) // Background color for the section
//    }
//}



import SwiftUI

struct ShopItemsPage: View {
    let shopItems: [ShopItem]
    let purchasedItems: [UserInventoryItem]
    let buyAction: (ShopItem) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(shopItems) { item in
                    if !purchasedItems.contains(where: { $0.image == item.image }) {
                        ShopItemView(item: item) { buyAction(item) }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.backgroundColorOneTheme)
                            )
                    }
                }
            }
            .padding()
        }
        .background(Color.theme.backgroundColorTwoTheme)
    }
}

