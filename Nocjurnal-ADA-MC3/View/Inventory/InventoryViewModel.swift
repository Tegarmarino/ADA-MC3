//
//  InventoryViewModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 25/07/24.
//

import Foundation
import SwiftUI
import SwiftData

class InventoryViewModel: ObservableObject {
    @Published var users: [User] = [] // Published property to trigger UI updates
    @Published var selectedClothesItem: UserInventoryItem?
    @Published var selectedHatItem: UserInventoryItem?
    @Published var selectedWallpaperItem: UserInventoryItem?
    @Published var showReplaceConfirmation = false
    @Published var replacingItemType: ItemType? = nil
    @Published var replacingNewItem: UserInventoryItem? = nil
    
    private let modelContext: ModelContext
    var purchasedItems: [UserInventoryItem] = []
    
//        init(modelContext: ModelContext) {
//            self.modelContext = modelContext
//            fetchUsers()
//            fetchPurchasedItems()
//        }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchUsers()
        fetchPurchasedItems()

        // Check if "Wallpaper1" exists, but ONLY if there are NO purchased items
        if purchasedItems.isEmpty { // Ensure this is the very first app launch
            let wallpaperItem = UserInventoryItem(type: .wallpaper, price: 0, image: "Wallpaper1")
            modelContext.insert(wallpaperItem)
            
            // Set "Wallpaper1" as default for the first user (if any)
            if let user = users.first {
                user.activeWallpaperImage = "Wallpaper1"
            }
            try? modelContext.save()

            // Re-fetch purchased items to include "Wallpaper1"
            fetchPurchasedItems()
        }
    }

    
    // Fetch users
    // Inside InventoryViewModel
    func fetchUsers() {
        let fetchDescriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\User.money, order: .reverse)]) // Use sortBy
        
        do {
            users = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    
    // Fetch purchased items
    func fetchPurchasedItems() {
        purchasedItems = (try? modelContext.fetch(FetchDescriptor<UserInventoryItem>())) ?? []
    }
    
    // Computed properties (moved from the view)
    var activeClothesItems: [UserInventoryItem] {
        guard let user = users.first else { return [] }
        let activeImage = user.activeClothesImage
        let purchasedItemsDict = Dictionary(grouping: purchasedItems) { $0.type }
        return purchasedItemsDict[.clothes]?.filter { $0.image == activeImage } ?? []
    }
    
    var activeHatItems: [UserInventoryItem] {
        guard let user = users.first else { return [] }
        let activeImage = user.activeHatImage
        let purchasedItemsDict = Dictionary(grouping: purchasedItems) { $0.type }
        return purchasedItemsDict[.hat]?.filter { $0.image == activeImage } ?? []
    }
    
    var activeWallpaperItems: [UserInventoryItem] {
        guard let user = users.first else { return [] }
        let activeImage = user.activeWallpaperImage
        let purchasedItemsDict = Dictionary(grouping: purchasedItems) { $0.type }
        return purchasedItemsDict[.wallpaper]?.filter { $0.image == activeImage } ?? []
    }
    
    // Function to update active item (moved from the view)
//    func updateActiveItem(newItem: UserInventoryItem?, itemType: ItemType) {
//        if let user = users.first {
//            if itemType == .clothes {
//                if user.activeClothesImage != nil && newItem != nil {
//                    replacingItemType = itemType
//                    replacingNewItem = newItem
//                    showReplaceConfirmation = true
//                } else if let newItem = newItem {
//                    user.activeClothesImage = newItem.image
//                    try? modelContext.save()
//                }
//            } else if itemType == .hat{ // itemType == .hat
//                if user.activeHatImage != nil && newItem != nil {
//                    replacingItemType = itemType
//                    replacingNewItem = newItem
//                    showReplaceConfirmation = true
//                } else if let newItem = newItem {
//                    user.activeHatImage = newItem.image
//                    try? modelContext.save()
//                }
//            } else if itemType == .wallpaper{ // itemType == .Wallpaper
//                if user.activeWallpaperImage != nil && newItem != nil {
//                    replacingItemType = itemType
//                    replacingNewItem = newItem
//                    showReplaceConfirmation = true
//                } else if let newItem = newItem {
//                    user.activeWallpaperImage = newItem.image
//                    try? modelContext.save()
//                }
//            }
//        }
//    }
//
//    func replaceItem() {
//        if let user = users.first, let replacingItemType = replacingItemType, let replacingNewItem = replacingNewItem {
//            if replacingItemType == .clothes {
//                user.activeClothesImage = replacingNewItem.image
//            } else if replacingItemType == .hat {
//                user.activeHatImage = replacingNewItem.image
//            } else if replacingItemType == .wallpaper {
//                user.activeWallpaperImage = replacingNewItem.image
//            }
//            try? modelContext.save()
//        }
//        replacingItemType = nil
//        replacingNewItem = nil
//    }
    
    
    
    func updateActiveItem(newItem: UserInventoryItem?, itemType: ItemType) {
            if let user = users.first {
                // Check if another item of the same type is already active
                let anotherItemIsActive = purchasedItems.contains {
                    $0.id != newItem?.id && $0.type == itemType &&
                    (itemType == .clothes && user.activeClothesImage == $0.image ||
                     itemType == .hat && user.activeHatImage == $0.image ||
                     itemType == .wallpaper && user.activeWallpaperImage == $0.image)
                }

                if anotherItemIsActive {
                    // If another item is active, set up for replacement confirmation
                    replacingItemType = itemType
                    replacingNewItem = newItem
                    showReplaceConfirmation = true
                } else {
                    // If no other item is active, update directly
                    switch itemType {
                    case .clothes:
                        user.activeClothesImage = newItem?.image
                        selectedClothesItem = newItem
                    case .hat:
                        user.activeHatImage = newItem?.image
                        selectedHatItem = newItem
                    case .wallpaper:
                        user.activeWallpaperImage = newItem?.image
                        selectedWallpaperItem = newItem
                    }
                    try? modelContext.save()
                }
            }
        }
    
    

//    func updateActiveItem(newItem: UserInventoryItem?, itemType: ItemType) {
//            if let user = users.first {
//                // Check if another item of the same type is already active
//                let anotherItemIsActive = purchasedItems.contains {
//                    $0.id != newItem?.id && $0.type == itemType &&
//                    (itemType == .clothes && user.activeClothesImage == $0.image ||
//                     itemType == .hat && user.activeHatImage == $0.image ||
//                     itemType == .wallpaper && user.activeWallpaperImage == $0.image)
//                }
//
//                if anotherItemIsActive {
//                    // If another item is active, set up for replacement confirmation
//                    replacingItemType = itemType
//                    replacingNewItem = newItem
//                    showReplaceConfirmation = true
//                } else {
//                    // If no other item is active, update directly
//                    switch itemType {
//                    case .clothes:
//                        user.activeClothesImage = newItem?.image
//                    case .hat:
//                        user.activeHatImage = newItem?.image
//                    case .wallpaper:
//                        user.activeWallpaperImage = newItem?.image
//                    }
//                    try? modelContext.save()
//                }
//            }
//        }
    

//        func updateActiveItem(newItem: UserInventoryItem?, itemType: ItemType) {
//            if let user = users.first {
//                switch itemType {
//                case .clothes:
//                    if user.activeClothesImage != newItem?.image {  // Check if there's a change
//                        user.activeClothesImage = newItem?.image
//                        try? modelContext.save() // Save the change immediately
//                    }
//                case .hat:
//                    if user.activeHatImage != newItem?.image {  // Check if there's a change
//                        user.activeHatImage = newItem?.image
//                        try? modelContext.save() // Save the change immediately
//                    }
//                case .wallpaper:
//                    if user.activeWallpaperImage != newItem?.image {  // Check if there's a change
//                        user.activeWallpaperImage = newItem?.image
//                        try? modelContext.save() // Save the change immediately
//                    }
//                }
//            }
//        }

        func replaceItem() {
            if let user = users.first, let replacingItemType = replacingItemType, let replacingNewItem = replacingNewItem {
                switch replacingItemType {
                case .clothes:
                    user.activeClothesImage = replacingNewItem.image
                case .hat:
                    user.activeHatImage = replacingNewItem.image
                case .wallpaper:
                    user.activeWallpaperImage = replacingNewItem.image
                }
                try? modelContext.save() // Save the change immediately
            }
            replacingItemType = nil
            replacingNewItem = nil
        }

}
