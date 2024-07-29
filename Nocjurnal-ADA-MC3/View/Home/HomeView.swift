//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    
    @State private var buttonState = ButtonState.idle
    @State private var selectedIndex = 0
    @State private var showShopView = false  // State to control the modal sheet
    @State private var showtInventoryView = false
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    @State private var showUnselectConfirmation = false
    @State private var unselectType: ItemType? = nil
    
    var body: some View {
        VStack{
            ZStack(alignment:.top) {
                if users.first?.activeWallpaperImage == nil {
                            Image("Wallpaper1") // Load "Wallpaper1" initially
                              .resizable()
                              .scaledToFit()
                } else if let activeWallpaperImage = users.first?.activeWallpaperImage {
                    Button(action: {
                        unselectType = .wallpaper
                        showUnselectConfirmation = true
                    }) {
                        Image(activeWallpaperImage)
                            .resizable()
                            .scaledToFit() // Or adjust to your preferred sizing
                    }
                    .buttonStyle(.plain)
                }
//                if let activeWallpaperImage = users.first?.activeWallpaperImage {
//                    Button(action: {
//                        unselectType = .wallpaper
//                        showUnselectConfirmation = true
//                    }) {
//                        Image(activeWallpaperImage)
//                            .resizable()
//                            .scaledToFit() // Or adjust to your preferred sizing
//                    }
//                    .buttonStyle(.plain)
//                }
                VStack(spacing: 0) {
                    Spacer()
                }
                
                HStack{
                    ButtonIcon("bag", state: $buttonState, type: .secondary) {
                        showShopView.toggle()  // Toggle the modal sheet
                    }
                    .sheet(isPresented: $showShopView) {
                        ShopView()
                            .presentationDetents([.medium])
                    }
                    Spacer()
                    ButtonIcon("xmark.bin", state: $buttonState, type: .secondary) {
                        showtInventoryView.toggle()
                    }
                    .sheet(isPresented: $showtInventoryView) {
                        InventoryView(modelContext: modelContext) // Pass modelContext here
                            .presentationDetents([.medium])
                    }
                }
                .padding(EdgeInsets(top: safeAreaInsets.top, leading: 24, bottom: 0, trailing: 24))
                .frame(width: VPW)
                .ignoresSafeArea()
                
                
                ZStack(alignment: .center){
                    Spacer() // Push hat and clothes to the top left
                    if let activeClothesImage = users.first?.activeClothesImage {
                        Button(action: {
                            unselectType = .clothes
                            showUnselectConfirmation = true
                        }) {
                            Image(activeClothesImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 241) // Customizable size
                                .position(x: 201, y: 490) // Customizable position
                        }
                        .buttonStyle(.plain)
                        .zIndex(3.0)
                    }
                    if let activeHatImage = users.first?.activeHatImage {
                        Button(action: {
                            unselectType = .hat
                            showUnselectConfirmation = true
                        }) {
                            Image(activeHatImage)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: activeHatImage == "Hat1" ? 130 : activeHatImage == "Hat2" ? 135 : activeHatImage == "Hat3" ? 150 : activeHatImage == "Hat4" ? 190 : 200,
                                    height: activeHatImage == "Hat1" ? 110 : activeHatImage == "Hat2" ? 115 : activeHatImage == "Hat3" ? 120 : activeHatImage == "Hat4" ? 190 : 200
                                )
                                .position(
                                    x: activeHatImage == "Hat1" ? 200 : activeHatImage == "Hat2" ? 200 : activeHatImage == "Hat3" ? 201 : activeHatImage == "Hat4" ? 200 : 200,
                                    y: activeHatImage == "Hat1" ? 315 : activeHatImage == "Hat2" ? 366 : activeHatImage == "Hat3" ? 425 : activeHatImage == "Hat4" ? 375 : 200
                                )
                        }
                        .buttonStyle(.plain)
                        .zIndex(3.0)
                    }


                    Image("FaceNormal")
                        .position(x:200, y: 427)
                        .zIndex(2.0)
                    Image("NocyNoFace") // Nocy will be centered by default
                        .position(x:200, y: 455)
                        .zIndex(1.0)
                    Text("Level " + String(users.first?.lvl ?? 100))
                        .position(x: 200, y: 590)
                        .zIndex(3.0)
                        
                    Text("Money " + String(users.first?.money ?? 100))
                        .position(x: 200, y: 610)
                        .zIndex(3.0)
                }
            }

            
            
            
        }
        .frame(width: VPW, height: VPH, alignment: .topLeading)
        .ignoresSafeArea()
        .background(Color.theme.backgroundColorTwoTheme)
        .navigationBarBackButtonHidden(true)
        .confirmationDialog("Unselect Item?", isPresented: $showUnselectConfirmation, titleVisibility: .visible) {
            Button("Unselect") {
                if let user = users.first, let unselectType = unselectType {
                    if unselectType == .clothes {
                        user.activeClothesImage = nil
                    } else if unselectType == .hat {
                        user.activeHatImage = nil
                    } else if unselectType == .wallpaper {
                        user.activeWallpaperImage = nil
                    }
                    try? modelContext.save()
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to unselect the currently equipped \(unselectType?.rawValue ?? "")?")
        }
    }
    
}
