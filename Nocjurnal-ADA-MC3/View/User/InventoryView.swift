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

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: InventoryViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    // Clothes section
                    if !viewModel.purchasedItems.filter({ $0.type == .clothes }).isEmpty {
                        Text("Clothes")
                            .font(.headline)

                        ForEach(viewModel.purchasedItems.filter { $0.type == .clothes }) { item in
                            InventoryItemRow(
                                item: item,
                                selectedItem: $viewModel.selectedClothesItem,
                                itemType: .clothes,
                                isDisabled: viewModel.selectedClothesItem != nil && viewModel.selectedClothesItem?.id != item.id, isActiveItem: viewModel.activeClothesItems.contains(item)
                            )
                        }
                        .onDelete(perform: deleteItems) // Pass the delete function
                    }

                    // Hats section (similar modifications)
                    if !viewModel.purchasedItems.filter({ $0.type == .hat }).isEmpty {
                        Text("Hats")
                            .font(.headline)
                            .padding(.top, 20)

                        ForEach(viewModel.purchasedItems.filter { $0.type == .hat }) { item in
                            InventoryItemRow(
                                item: item,
                                selectedItem: $viewModel.selectedHatItem,
                                itemType: .hat,
                                isDisabled: viewModel.selectedHatItem != nil && viewModel.selectedHatItem?.id != item.id, isActiveItem: viewModel.activeHatItems.contains(item)
                            )
                        }
                        .onDelete(perform: deleteItems) // Pass the delete function
                    }
                    
                    // Hats section (similar modifications)
                    if !viewModel.purchasedItems.filter({ $0.type == .wallpaper }).isEmpty {
                        Text("Wallpapers")
                            .font(.headline)
                            .padding(.top, 20)

                        ForEach(viewModel.purchasedItems.filter { $0.type == .wallpaper }) { item in
                            InventoryItemRow(
                                item: item,
                                selectedItem: $viewModel.selectedWallpaperItem,
                                itemType: .wallpaper,
                                isDisabled: viewModel.selectedWallpaperItem != nil && viewModel.selectedWallpaperItem?.id != item.id, isActiveItem: viewModel.activeWallpaperItems.contains(item)
                            )
                        }
                        .onDelete(perform: deleteItems) // Pass the delete function
                    }
                }
                .padding()
            }
            // ... the rest of your view code
        }
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

    func deleteItems(at offsets: IndexSet) {
        // Access purchasedItems from the viewModel
        for index in offsets {
            context.delete(viewModel.purchasedItems[index])
        }
    }
}
