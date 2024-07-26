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
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchUsers()
        fetchPurchasedItems()
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
    func updateActiveItem(newItem: UserInventoryItem?, itemType: ItemType) {
        if let user = users.first {
            if itemType == .clothes {
                if user.activeClothesImage != nil && newItem != nil {
                    replacingItemType = itemType
                    replacingNewItem = newItem
                    showReplaceConfirmation = true
                } else if let newItem = newItem {
                    user.activeClothesImage = newItem.image
                    try? modelContext.save()
                }
            } else if itemType == .hat{ // itemType == .hat
                if user.activeHatImage != nil && newItem != nil {
                    replacingItemType = itemType
                    replacingNewItem = newItem
                    showReplaceConfirmation = true
                } else if let newItem = newItem {
                    user.activeHatImage = newItem.image
                    try? modelContext.save()
                }
            } else if itemType == .wallpaper{ // itemType == .Wallpaper
                if user.activeWallpaperImage != nil && newItem != nil {
                    replacingItemType = itemType
                    replacingNewItem = newItem
                    showReplaceConfirmation = true
                } else if let newItem = newItem {
                    user.activeWallpaperImage = newItem.image
                    try? modelContext.save()
                }
            }
        }
    }

    func replaceItem() {
        if let user = users.first, let replacingItemType = replacingItemType, let replacingNewItem = replacingNewItem {
            if replacingItemType == .clothes {
                user.activeClothesImage = replacingNewItem.image
            } else if replacingItemType == .hat {
                user.activeHatImage = replacingNewItem.image
            } else if replacingItemType == .wallpaper {
                user.activeWallpaperImage = replacingNewItem.image
            }
            try? modelContext.save()
        }
        replacingItemType = nil
        replacingNewItem = nil
    }
}
