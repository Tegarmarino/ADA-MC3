//
//  InventoryModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import Foundation
import SwiftData

// Enum untuk tipe item
enum ItemType: String {
    case clothes = "Clothes"
    case hat = "Hat"
}

// Model untuk menyimpan item yang sudah dibeli (SwiftData)
@Model
class UserInventoryItem {
    var typeRawValue: String
//    var type: ItemType
    var price: Int
    var image: String

    init(type: ItemType, price: Int, image: String) {
        self.typeRawValue = type.rawValue
//        self.type = type
        self.price = price
        self.image = image
    }
    
     
    var type: ItemType {
        get { ItemType(rawValue: typeRawValue)! }
        set { typeRawValue = newValue.rawValue }
    }
}


//@Model
//final class InventoryModel {
//    var type: String
//    var price: Int
//    var image: String
//    
//    init(type: String, price: Int, image: String) {
//        self.type = type
//        self.price = price
//        self.image = image
//    }
//}
