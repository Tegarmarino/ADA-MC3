//
//  InventoryView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(\.modelContext) var context
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
            //            List {
            //                ForEach (purchasedItems) { item in
            //                    HStack {
            //                        Image(item.image)
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 50, height: 50)
            //
            //                        VStack(alignment: .leading) {
            //                            Text(item.type.rawValue) // Directly use the computed property
            //                            Text("$\(item.price)")
            //                        }
            //                    }
            //                }
            //                .onDelete { indexSet in
            //                for index in indexSet {
            //                    context.delete(purchasedItems[index])
            //                }
            //            }
            //            }
            
            ScrollView { // Add ScrollView for scrolling if there are many items
                VStack(alignment: .leading, spacing: 20) {
                    // Clothes section
                    Text("Clothes")
                        .font(.headline)
                    List{
                        ForEach(purchasedItems.filter { $0.type == .clothes }) { item in
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
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(purchasedItems[index])
                            }
                        }
                    }
                    
                    // Hats section
                    Text("Hats")
                        .font(.headline)
                        .padding(.top, 20) // Add spacing between sections
                    List{
                        ForEach(purchasedItems.filter { $0.type == .hat }) { item in
                            HStack {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(item.type.rawValue)
                                    Text("$\(item.price)")
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(purchasedItems[index])
                            }
                        }
                    }
                }
                .padding()
            }
            Spacer()
                .navigationTitle("Inventory")
        }
    }
}
