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
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data

    // Hardcoded shop items (replace with your actual data)
    let shopItems: [(type: ItemType, price: Int, image: String)] = [
        (.clothes, 50, "Clothes"),
        (.hat, 25, "HighHat"),
        (.clothes, 80, "Clothes"),
        (.hat, 35, "CowboyHat")
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
            
            ScrollView { // Agar item bisa di-scroll jika banyak
                LazyVStack(spacing: 20) {
                    ForEach(shopItems, id: \.price) { item in
                        ShopItemView(item: item) { // Tiap item bisa dibeli
                            buyItem(item)
                        }
                    }
                }
                .padding()
            }

            Spacer()
            Text("Shop View")
        }
        .padding(.horizontal, 10)
        .navigationBarBackButtonHidden(true) // Sembunyikan tombol kembali bawaan
    }

    // Fungsi untuk membeli item
//    func buyItem(_ item: (type: ItemType, price: Int, image: String)) {
//            // Buat objek UserInventoryItem baru
//            let newItem = UserInventoryItem(type: item.type, price: item.price, image: item.image)
//
//            // Simpan ke SwiftData
//            modelContext.insert(newItem)
//        }
    
    func buyItem(_ item: (type: ItemType, price: Int, image: String)) {
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
                // Handle insufficient funds (e.g., show an alert)
                print("Not enough money!")
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

//#Preview {
//    ShopView()
//}

//struct ShopView: View {
//    var body: some View {
//        VStack{
//            HStack {
//                BackButton()
//                Spacer()
//            }
//            
//            Spacer()
//            Text("Shop View")
//        }
//        .padding(.horizontal, 10)
//        .navigationBarBackButtonHidden()
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    ShopView()
//}
