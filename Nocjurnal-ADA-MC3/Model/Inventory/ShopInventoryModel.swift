//
//  ShopInventoryModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ShopItem: Identifiable { // Conforming to Identifiable
    let id = UUID() // Unique identifier
    let type: ItemType
    let price: Int
    let image: String
}
//enum ItemType: String, CaseIterable, Codable {
//    case clothes = "Clothes"
//    case hat = "Hat"
//}
//
//struct ShopItem: Identifiable, Codable {
//    let id = UUID()
//    let name: String
//    let type: ItemType
//    let price: Int
//    let imageName: String
//}
