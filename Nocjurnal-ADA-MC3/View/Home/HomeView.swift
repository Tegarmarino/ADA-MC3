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
    @Query private var journalModel: [JournalModel]
    
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
                if let activeWallpaperImage = users.first?.activeWallpaperImage {
                    Button(action: {
                        unselectType = .wallpaper
                        showUnselectConfirmation = true
                    }) {
                        Image(activeWallpaperImage)
                            .resizable()
                            .scaledToFit() // Or adjust to your preferred sizing
                    }
                    .buttonStyle(.plain)
                } else {
                    Image("Wallpaper1")
                        .resizable()
                        .scaledToFit()
                }
                VStack(spacing: 0) {
                    Spacer()
                }
                
                HStack{
                    ButtonIcon("bag", state: $buttonState, type: .secondary) {
                        showShopView.toggle()  // Toggle the modal sheet
                    }
                    .sheet(isPresented: $showShopView) {
                        ShopView()
                    }
                    Spacer()
                    ButtonIcon("xmark.bin", state: $buttonState, type: .secondary) {
                        showtInventoryView.toggle()
                    }
                    .sheet(isPresented: $showtInventoryView) {
                        InventoryView(modelContext: modelContext) // Pass modelContext here
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
                                .frame(width: activeClothesImage == "Clothes2" ? 220 : 240)
                                .position(x: 201, y: 479) // Customizable position
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
                                    width: activeHatImage == "Hat1" ? 130 : activeHatImage == "Hat2" ? 135 : activeHatImage == "Hat3" ? 130 : activeHatImage == "Hat4" ? 190 : 200,
                                    height: activeHatImage == "Hat1" ? 110 : activeHatImage == "Hat2" ? 115 : activeHatImage == "Hat3" ? 110 : activeHatImage == "Hat4" ? 190 : 200
                                )
                                .position(
                                    x: activeHatImage == "Hat1" ? 200 : activeHatImage == "Hat2" ? 200 : activeHatImage == "Hat3" ? 201 : activeHatImage == "Hat4" ? 200 : 200,
                                    y: activeHatImage == "Hat1" ? 315 : activeHatImage == "Hat2" ? 366 : activeHatImage == "Hat3" ? 370 : activeHatImage == "Hat4" ? 375 : 200
                                )
                        }
                        .buttonStyle(.plain)
                        .zIndex(3.0)
                    }
                    
                    
                    Image(journalModel.last?.mood == JournalMood.angry ? "FaceAngry" : journalModel.last?.mood == JournalMood.disgusted ? "FaceDisgusted" : journalModel.last?.mood == JournalMood.happy ? "FaceJoyful" : journalModel.last?.mood == JournalMood.sad ? "FaceSad" : journalModel.last?.mood == JournalMood.scared ? "FaceScared" : "FaceNormal")
                        .position(x:200,
                                  y: journalModel.last?.mood == JournalMood.angry ? 428 : journalModel.last?.mood == JournalMood.disgusted ? 425 : journalModel.last?.mood == JournalMood.scared ? 425 : 426
                        )
                        .zIndex(2.0)
                    Image("NocyNoFace") // Nocy will be centered by default
                        .position(x:200, y: 455)
                        .zIndex(1.0)
                    
                    HomeXPBarView(curXP: CGFloat(users.first?.xp ?? 0))
                        .offset(y: 150)
//                    VStack{
//
//                        
//                        // ini buat nantik jika bener perlu statisticsnya
//                        
////                        let streaks = calculateStreaks(for: journalModel)
////                        
////                        Text("Max Streak:\(streaks.highestStreak) | Cur Streak:\(streaks.currentStreak)")
////                            .font(Font.format.textHeadlineThree)
////                        
////                        Text("Total Words: \(calculateTotalWordCount(journals: journalModel)) | Total Journals: \(calculateTotalJournalEntries(journals: journalModel))")
////                            .font(Font.format.textHeadlineThree)
////                            .padding(.bottom, 35)
//                        
//                        
//                    }
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
