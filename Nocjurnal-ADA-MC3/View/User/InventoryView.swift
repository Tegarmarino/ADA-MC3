//
//  InventoryView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Query var purchasedItems: [UserInventoryItem] // Ambil data dari SwiftData

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
            List(purchasedItems) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(item.type.rawValue) // Directly use the computed property
                        Text("$\(item.price)")
                    }
                }
            }
            .navigationTitle("Inventory")
        }
    }
}

//struct InventoryView: View {
//    @Query var purchasedItems: [UserInventoryItem] // Ambil data dari SwiftData
//
//    var body: some View {
//        NavigationView { // Navigasi untuk tampilan daftar item
//            List(purchasedItems) { item in
//                HStack {
//                    Image(item.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//                    
//                    VStack(alignment: .leading) {
//                        Text(item.type.rawValue)
//                        Text("$\(item.price)")
//                    }
//                }
//            }
//            .navigationTitle("Inventory")
//        }
//    }
//}



//#Preview {
//    InventoryView()
//}
