//
//  ShopItemView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import SwiftUI

// Subview untuk menampilkan tiap item
struct ShopItemView: View {
    let item: (type: ItemType, price: Int, image: String)
    let onBuy: () -> Void // Aksi saat tombol "Buy" ditekan

    var body: some View {
        HStack {
            Image(item.image) // Tampilkan gambar (pastikan ada di Assets)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            VStack(alignment: .leading) {
                Text(item.type.rawValue) // Tampilkan tipe (Clothes atau Hat)
                Text("$\(item.price)") // Tampilkan harga
            }

            Spacer()

            Button("Buy") {
                onBuy()
            }
        }
    }
}


//#Preview {
//    ShopItemView()
//}
