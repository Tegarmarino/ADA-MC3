//
//  ShopView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode // To dismiss the modal
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @State private var showAlert = false
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    @Query var purchasedItems: [UserInventoryItem] // Fetch purchased items

    let shopItems: [ShopItem] = [
        ShopItem(type: .clothes, price: 50, image: "Clothes1"),
        ShopItem(type: .clothes, price: 100, image: "Clothes2"),
        ShopItem(type: .clothes, price: 150, image: "Clothes3"),
        ShopItem(type: .clothes, price: 200, image: "Clothes4"),
        ShopItem(type: .hat, price: 50, image: "Hat1"),
        ShopItem(type: .hat, price: 100, image: "Hat2"),
        ShopItem(type: .hat, price: 150, image: "Hat3"),
        ShopItem(type: .hat, price: 200, image: "Hat4"),
        ShopItem(type: .wallpaper, price: 50, image: "Wallpaper1"),
        ShopItem(type: .wallpaper, price: 100, image: "Wallpaper2"),
        ShopItem(type: .wallpaper, price: 150, image: "Wallpaper3"),
        ShopItem(type: .wallpaper, price: 200, image: "Wallpaper4"),
        ShopItem(type: .wallpaper, price: 250, image: "Wallpaper5"),
        // ... other items ...
    ]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the modal
                }) {
                    Image(systemName: "xmark") // Using SF Symbols for the close button
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()

            if let user = users.first { // Assuming you have one User
                Text("Money: $\(user.money)") // Display money
                HStack {
                    Button("Add Money") {
                        addMoney(to: user)
                    }
                    Spacer()
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Clothes category
                    Text("Clothes").font(.headline)
                    LazyVStack(spacing: 10) {
                        ForEach(shopItems) { item in // Iterate over ShopItem directly
                            if item.type == .clothes && !purchasedItems.contains(where: { $0.image == item.image }) {
                                ShopItemView(item: item) { // Pass ShopItem to ShopItemView
                                    buyItem(item)
                                }
                            }
                        }
                    }
                                
                    // Hats category (apply the same change as above)
                    Text("Hats").font(.headline).padding(.top, 20)
                    LazyVStack(spacing: 10) {
                        ForEach(shopItems) { item in
                            if item.type == .hat && !purchasedItems.contains(where: { $0.image == item.image }) {
                                ShopItemView(item: item) {
                                    buyItem(item)
                                }
                            }
                        }
                    }
                    
                    // Wallpaper category (apply the same change as above)
                    Text("Wallpaper").font(.headline).padding(.top, 20)
                    LazyVStack(spacing: 10) {
                        ForEach(shopItems) { item in
                            if item.type == .wallpaper && !purchasedItems.contains(where: { $0.image == item.image }) {
                                ShopItemView(item: item) {
                                    buyItem(item)
                                }
                            }
                        }
                    }
                }
                .padding()
            }

            Spacer()
            Text("Shop View")
        }
        .alert("Insufficient Funds", isPresented: $showAlert) { // The alert modifier
            Button("OK", role: .cancel) { }
        } message: {
            Text("You don't have enough money to buy this item.")
        }
        .padding(.horizontal, 10)
        .navigationBarBackButtonHidden(true) // Sembunyikan tombol kembali bawaan
    }
    
    func buyItem(_ item: ShopItem) { // Now accepts ShopItem
        if let user = users.first, user.money >= item.price {
            user.money -= item.price
            let newItem = UserInventoryItem(type: item.type, price: item.price, image: item.image)
            modelContext.insert(newItem)

            do {
                try modelContext.save()
            } catch {
                print("Error saving changes: \(error)")
            }
        } else {
            showAlert = true
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
