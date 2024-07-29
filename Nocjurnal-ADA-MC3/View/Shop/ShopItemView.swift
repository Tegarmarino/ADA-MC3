//
//  ShopItemView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import SwiftUI

// Subview untuk menampilkan tiap item
//struct ShopItemView: View {
//    let item: (type: ItemType, price: Int, image: String)
//    let onBuy: () -> Void // Aksi saat tombol "Buy" ditekan
//
//    var body: some View {
//        HStack {
//            Image(item.image) // Tampilkan gambar (pastikan ada di Assets)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 80, height: 80)
//
//            VStack(alignment: .leading) {
//                Text(item.type.rawValue) // Tampilkan tipe (Clothes atau Hat)
//                Text("$\(item.price)") // Tampilkan harga
//            }
//
//            Spacer()
//
//            Button("Buy") {
//                onBuy()
//            }
//        }
//    }
//}





//struct ShopItemView: View {
//    let item: ShopItem // Now takes ShopItem
//    let onBuy: () -> Void
//
//    var body: some View {
//        VStack {
//            Image(item.image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 80, height: 80)
//
//            VStack(alignment: .leading) {
////                Text(item.type.rawValue)
//                Text("$\(item.price)")
//            }
//
////            Spacer()
//
////            Button("Buy") {
////                onBuy()
////            }
//        }
//    }
//}


struct ShopItemView: View {
    let item: ShopItem
    let onBuy: () -> Void

    var body: some View {
        Button(action: {
            onBuy()
        }) { // Wrap the entire content in a Button
            VStack {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 10) // Add padding to the top of the image

                VStack(alignment: .leading) {
                    //Text(item.type.rawValue)
                    Text("$\(item.price)")
                        .font(.headline)
                        .padding(.bottom, 10) // Add padding to the bottom of the price
                }

                //Spacer() // Removed Spacer - Button will now fill the available space
            }
            .padding() // Add padding around the content
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            )
        }
        .buttonStyle(.plain) // Remove any default button styling
    }
}



//#Preview {
//    ShopItemView()
//}
