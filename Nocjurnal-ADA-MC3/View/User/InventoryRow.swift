//
//  InventoryRow.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 23/07/24.
//

//import SwiftUI
//
//struct InventoryItemRow: View {
//    var item: UserInventoryItem
//    @Binding var selectedItem: UserInventoryItem?
//    var itemType: ItemType
//    var isDisabled: Bool
//    var isActiveItem: Bool
//
//    var body: some View {
////        Button(action: {
////            // Toggle selection only if not the active item
////            if !isActiveItem {
////                selectedItem = (selectedItem?.id == item.id) ? nil : item
////            }
////        }) {
////            HStack {
////                Image(item.image)
////                    .resizable()
////                    .scaledToFit()
////                    .frame(width: 50, height: 50)
////
////                VStack(alignment: .leading) {
////                    Text(item.type.rawValue)
////                    Text("$\(item.price)")
////                }
////
////                Spacer()
////
////                if selectedItem?.id == item.id {
////                    Image(systemName: "checkmark.circle.fill")
////                        .foregroundColor(.blue)
////                }
////            }
////            .padding()
////            .background(
////                RoundedRectangle(cornerRadius: 8)
////                    .fill(selectedItem?.id == item.id ? Color.blue.opacity(0.1) : Color.clear)
////            )
////            .opacity(isActiveItem ? 0.5 : 1.0) // Reduce opacity if it's the active item
////        }
////        .buttonStyle(.plain)
////        .disabled(isActiveItem) //
//
//
//
//
//        Button(action: {
//            // Toggle selection only if not the active item
//            if !isActiveItem {
//                selectedItem = (selectedItem?.id == item.id) ? nil : item
//            }
//        }) { // Wrap the entire content in a Button
//            VStack {
//                Image(item.image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 80, height: 80)
//                    .padding(.top, 10) // Add padding to the top of the image
//
//                VStack(alignment: .leading) {
//                    if selectedItem?.id == item.id {
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(.blue)
//                    }
//                }
//
//                //Spacer() // Removed Spacer - Button will now fill the available space
//            }
//            .padding() // Add padding around the content
////            .background(
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(Color.white)
////            )
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(selectedItem?.id == item.id ? Color.blue.opacity(0.1) : Color.clear)
//            )
//            .opacity(isActiveItem ? 0.5 : 1.0) // Reduce opacity if it's the active item
//        }
//        .buttonStyle(.plain) // Remove any default button styling
//    }
//}

//#Preview {
//    InventoryRow()
//}





import SwiftUI

struct InventoryItemRow: View {
    var item: UserInventoryItem
    @Binding var selectedItem: UserInventoryItem?
    var itemType: ItemType
    var isDisabled: Bool
    var isActiveItem: Bool
    let equipAction: (UserInventoryItem, ItemType) -> Void

    var body: some View {
        Button(action: {
            if !isActiveItem {
                equipAction(item, itemType)
            }
        }) {
            VStack {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 10) // Add padding to the top of the image

                VStack(alignment: .leading) {
                    // Checkmark for the selected item (only if not active)
                    if selectedItem?.id == item.id && !isActiveItem {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedItem?.id == item.id && !isActiveItem ? Color.blue.opacity(0.1) : Color.clear)
            )
        }
        .buttonStyle(.plain)
        .disabled(isActiveItem) // Disable if the item is active
        .opacity(isActiveItem ? 0.5 : 1.0) // Reduce opacity if it's the active item
    }
}
