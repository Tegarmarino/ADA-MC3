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
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: InventoryViewModel
    @State private var selectedTab = 0 // Start with the "Hats" tab
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: InventoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        //        NavigationView {
        //            ScrollView {
        //                LazyVStack(alignment: .leading, spacing: 20) {
        //                    // Clothes section
        //                    if !viewModel.purchasedItems.filter({ $0.type == .clothes }).isEmpty {
        //                        Text("Clothes")
        //                            .font(.headline)
        //
        //                        ForEach(viewModel.purchasedItems.filter { $0.type == .clothes }) { item in
        //                            InventoryItemRow(
        //                                item: item,
        //                                selectedItem: $viewModel.selectedClothesItem,
        //                                itemType: .clothes,
        //                                isDisabled: viewModel.selectedClothesItem != nil && viewModel.selectedClothesItem?.id != item.id, isActiveItem: viewModel.activeClothesItems.contains(item)
        //                            )
        //                        }
        //                        .onDelete(perform: deleteItems) // Pass the delete function
        //                    }
        //
        //                    // Hats section (similar modifications)
        //                    if !viewModel.purchasedItems.filter({ $0.type == .hat }).isEmpty {
        //                        Text("Hats")
        //                            .font(.headline)
        //                            .padding(.top, 20)
        //
        //                        ForEach(viewModel.purchasedItems.filter { $0.type == .hat }) { item in
        //                            InventoryItemRow(
        //                                item: item,
        //                                selectedItem: $viewModel.selectedHatItem,
        //                                itemType: .hat,
        //                                isDisabled: viewModel.selectedHatItem != nil && viewModel.selectedHatItem?.id != item.id, isActiveItem: viewModel.activeHatItems.contains(item)
        //                            )
        //                        }
        //                        .onDelete(perform: deleteItems) // Pass the delete function
        //                    }
        //
        //                    // Hats section (similar modifications)
        //                    if !viewModel.purchasedItems.filter({ $0.type == .wallpaper }).isEmpty {
        //                        Text("Wallpapers")
        //                            .font(.headline)
        //                            .padding(.top, 20)
        //
        //                        ForEach(viewModel.purchasedItems.filter { $0.type == .wallpaper }) { item in
        //                            InventoryItemRow(
        //                                item: item,
        //                                selectedItem: $viewModel.selectedWallpaperItem,
        //                                itemType: .wallpaper,
        //                                isDisabled: viewModel.selectedWallpaperItem != nil && viewModel.selectedWallpaperItem?.id != item.id, isActiveItem: viewModel.activeWallpaperItems.contains(item)
        //                            )
        //                        }
        //                        .onDelete(perform: deleteItems) // Pass the delete function
        //                    }
        //                }
        //                .padding()
        //            }
        //            // ... the rest of your view code
        //        }
        //        .onChange(of: viewModel.selectedClothesItem) { newItem in
        //            viewModel.updateActiveItem(newItem: newItem, itemType: .clothes) // Update but don't dismiss yet
        //        }
        //        .onChange(of: viewModel.selectedHatItem) { newItem in
        //            viewModel.updateActiveItem(newItem: newItem, itemType: .hat) // Update but don't dismiss yet
        //        }
        //        .onChange(of: viewModel.selectedWallpaperItem) { newItem in
        //            viewModel.updateActiveItem(newItem: newItem, itemType: .wallpaper) // Update but don't dismiss yet
        //        }
        //        .confirmationDialog("Replace Item?", isPresented: $viewModel.showReplaceConfirmation, titleVisibility: .visible) {
        //            Button("Replace") {
        //                viewModel.replaceItem()
        //                dismiss() // Dismiss only after confirmation
        //            }
        //            Button("Cancel", role: .cancel) { }
        //        }
        //        //        .confirmationDialog("Replace Item?", isPresented: $viewModel.showReplaceConfirmation, titleVisibility: .visible) {
        //        //            Button("Replace") {
        //        //                viewModel.replaceItem()
        //        //                dismiss()
        //        //            }
        //        //            Button("Cancel", role: .cancel) { }
        //    message: {
        //        Text("Are you sure you want to replace the currently equipped \(viewModel.replacingItemType?.rawValue ?? "")?")
        //    }
        //
        //
        //
        //
        //
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        NavigationView { // Use NavigationView to take over the full screen
            VStack(spacing: 0) {
                // Custom Navigation Bar (Removed the close button)
                HStack {
                    HStack(spacing: 30) {
                        Spacer()
                        Button("Hats") { selectedTab = 0 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 0 ? Font.format.textHeadlineTwo : Font.format.textHeadlineFive) // Corrected font selection
                            .fontWeight(selectedTab == 0 ? .bold : .regular) // Simplified fontWeight
                        
                        Button("Clothes") { selectedTab = 1 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 1 ? Font.format.textHeadlineTwo : Font.format.textHeadlineFive) // Corrected font selection
                            .fontWeight(selectedTab == 1 ? .bold : .regular)
                        
                        Button("Wallpaper") { selectedTab = 2 }
                            .foregroundColor(Color.theme.warningColorTheme)
                            .font(selectedTab == 2 ? Font.format.textHeadlineTwo : Font.format.textHeadlineFive) // Corrected font selection
                            .fontWeight(selectedTab == 2 ? .bold : .regular)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
                
                .padding(.horizontal)
                
                .background(Color.theme.primaryColorTheme) // Set the blue background
                
                
//                TabView(selection: $selectedTab) {
//                    InventoryItemsPage(
//                        items: viewModel.purchasedItems.filter { $0.type == .hat },
//                        equipAction: viewModel.updateActiveItem(newItem:itemType:)
//                    )
//                    .tag(0)
//
//
//                    InventoryItemsPage(
//                        items: viewModel.purchasedItems.filter { $0.type == .clothes },
//                        equipAction: viewModel.updateActiveItem(newItem:itemType:)
//                    )
//                    .tag(1)
//
//
//                    InventoryItemsPage(
//                        items: viewModel.purchasedItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" },
//                        equipAction: viewModel.updateActiveItem(newItem:itemType:)
//                    )
//                    .tag(2)
//
//                    //                    ItemsPage(shopItems: shopItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" },
//                    //                              purchasedItems: purchasedItems, buyAction: buyItem)
//                    //                    .tag(2)
//                }
                InventoryTabView(viewModel: viewModel, selectedTab: $selectedTab) // Use the new InventoryTabView
                                    .background(Color.theme.backgroundColorTwoTheme)
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .background(Color.theme.backgroundColorTwoTheme)
            .navigationTitle("") // Hide the default navigation title
            .navigationBarHidden(true) // Hide the default navigation bar
        } // End of NavigationView
        .onChange(of: viewModel.selectedClothesItem) { newItem in
            viewModel.updateActiveItem(newItem: newItem, itemType: .clothes) // Update but don't dismiss yet
        }
        .onChange(of: viewModel.selectedHatItem) { newItem in
            viewModel.updateActiveItem(newItem: newItem, itemType: .hat) // Update but don't dismiss yet
        }
        .onChange(of: viewModel.selectedWallpaperItem) { newItem in
            viewModel.updateActiveItem(newItem: newItem, itemType: .wallpaper) // Update but don't dismiss yet
        }
        .confirmationDialog("Replace Item?", isPresented: $viewModel.showReplaceConfirmation, titleVisibility: .visible) {
            Button("Replace") {
                viewModel.replaceItem()
                dismiss() // Dismiss only after confirmation
            }
            Button("Cancel", role: .cancel) { }
        }
        //        .confirmationDialog("Replace Item?", isPresented: $viewModel.showReplaceConfirmation, titleVisibility: .visible) {
        //            Button("Replace") {
        //                viewModel.replaceItem()
        //                dismiss()
        //            }
        //            Button("Cancel", role: .cancel) { }
        message: {
            Text("Are you sure you want to replace the currently equipped \(viewModel.replacingItemType?.rawValue ?? "")?")
        }
    }
}




//struct InventoryItemsPage: View {
//    let items: [UserInventoryItem]
//    //    let equipAction: (UserInventoryItem, ItemType) -> Void
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                ForEach(items) { item in
//                    InventoryItemRow(
//                        item: item,
//                        selectedItem: .constant(nil),
//                        itemType: item.type,
//                        isDisabled: false,
//                        isActiveItem: false  // You might need to adjust this based on your logic
//                        //                        equipAction: equipAction
//                    )
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.backgroundColorOneTheme)
//                    )
//                }
//            }
//            .padding()
//        }
//        .background(Color.theme.backgroundColorTwoTheme)
//    }
//}






struct InventoryItemsPage: View {
    let items: [UserInventoryItem]
    let equipAction: (UserInventoryItem, ItemType) -> Void // Add this line

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(items) { item in
                    InventoryItemRow(
                        item: item,
                        selectedItem: .constant(nil),
                        itemType: item.type,
                        isDisabled: false,
                        isActiveItem: false, // You might need to adjust this based on your logic
                        equipAction: equipAction // Pass equipAction here
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.backgroundColorOneTheme)
                    )
                }
            }
            .padding()
        }
        .background(Color.theme.backgroundColorTwoTheme)
    }
}



//struct InventoryCategoryView: View {
//    let items: [UserInventoryItem]
//    let equipAction: (UserInventoryItem, ItemType) -> Void
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                ForEach(items) { item in
//                    InventoryItemRow(
//                        item: item,
//                        selectedItem: .constant(nil),
//                        itemType: item.type,
//                        isDisabled: false,
//                        isActiveItem: false,
//                        equipAction: equipAction
//                    )
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.backgroundColorOneTheme)
//                    )
//                }
//            }
//            .padding()
//        }
//    }
//}

struct InventoryCategoryView: View {
    let items: [UserInventoryItem]
    @Binding var selectedItem: UserInventoryItem? // Binding to control item selection
    let equipAction: (UserInventoryItem, ItemType) -> Void
    let itemType: ItemType // Add this line

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(items) { item in
                    InventoryItemRow(
                        item: item,
                        selectedItem: $selectedItem, // Use the binding
                        itemType: itemType, // Use the passed itemType
                        isDisabled: false,
                        isActiveItem: false,
                        equipAction: equipAction
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.backgroundColorOneTheme)
                    )
                }
            }
            .padding()
        }
    }
}




//struct InventoryTabView: View {
//    @StateObject private var viewModel: InventoryViewModel
//    @Binding var selectedTab: Int // Binding to the selected tab in InventoryView
//
//    init(viewModel: InventoryViewModel, selectedTab: Binding<Int>) {
//        self._viewModel = StateObject(wrappedValue: viewModel)
//        self._selectedTab = selectedTab
//    }
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            InventoryCategoryView(items: viewModel.purchasedItems.filter { $0.type == .hat }, equipAction: viewModel.updateActiveItem(newItem:itemType:))
//                .tag(0)
//
//            InventoryCategoryView(items: viewModel.purchasedItems.filter { $0.type == .clothes }, equipAction: viewModel.updateActiveItem(newItem:itemType:))
//                .tag(1)
//
//            InventoryCategoryView(items: viewModel.purchasedItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" }, equipAction: viewModel.updateActiveItem(newItem:itemType:))
//                .tag(2)
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//    }
//}



struct InventoryTabView: View {
    @StateObject private var viewModel: InventoryViewModel
    @Binding var selectedTab: Int // Binding to the selected tab in InventoryView

    init(viewModel: InventoryViewModel, selectedTab: Binding<Int>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._selectedTab = selectedTab
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            InventoryCategoryView(
                items: viewModel.purchasedItems.filter { $0.type == .hat },
                selectedItem: $viewModel.selectedHatItem,
                equipAction: viewModel.updateActiveItem(newItem:itemType:),
                itemType: .hat)
                .tag(0)

            InventoryCategoryView(
                items: viewModel.purchasedItems.filter { $0.type == .clothes },
                selectedItem: $viewModel.selectedClothesItem,
                equipAction: viewModel.updateActiveItem(newItem:itemType:),
                itemType: .clothes)
                .tag(1)

            InventoryCategoryView(
                items: viewModel.purchasedItems.filter { $0.type == .wallpaper && $0.image != "Wallpaper1" },
                selectedItem: $viewModel.selectedWallpaperItem,
                equipAction: viewModel.updateActiveItem(newItem:itemType:),
                itemType: .wallpaper)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
