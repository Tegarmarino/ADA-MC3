//
//  JournalRewardView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 22/07/24.
//

import SwiftUI
import SwiftData

struct JournalRewardView: View {
    @Environment(Application.self) private var app
    @Environment(\.modelContext) var modelContext // SwiftData environment
    
    @Query(sort: \User.money, order: .reverse) var users: [User] // Fetch user data
    
    @State private var submitState = ButtonState.idle

    var body: some View {
        VStack{
            Image("Confetti")
            
            Text("Congratulations")
                .font(Font.format.textHeadlineOne)
            Text("You have written 500 words in this journalling session!")
                .font(Font.format.textBodyThree)
                .padding(.vertical, 10)
                .multilineTextAlignment(.center)
            
            HStack{
                Image("Coins")
                VStack{
                    Text("500")
                        .font(Font.format.textHeadlineFour)
                    Text("Noc Coins")
                        .font(Font.format.textBodyFour)
                }
                
                Spacer()
                
                Image("XP")
                VStack{
                    Text("300")
                        .font(Font.format.textHeadlineFour)
                    Text("XP")
                        .font(Font.format.textBodyFour)
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            .padding(20)
            .background(.white)
            .cornerRadius(20)
            
            
            VStack{
                HStack{
                    Image("OwlIcon")
                    VStack{
                        Text("The Nowl")
                            .font(Font.format.textHeadlineFour)
                        Text("Level " + String(users.first!.lvl))
                            .font(Font.format.textBodyFour)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }

                XPBarView()
                
                HStack{
                    Text(String(users.first!.xp))
                        .font(Font.format.textBodyFour)
                    Spacer()
                    Text("1000")
                        .font(Font.format.textBodyFour)

                }
                .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            .padding(20)
            .background(.white)
            .padding(.vertical)
            .cornerRadius(20)

            
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                ButtonRegular("Home", state: $submitState) {
                    app.path = []
                    users[0].money += 500
                }
                .padding(.bottom, 34)
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .ignoresSafeArea()
        .background(Color.theme.backgroundColorOneTheme)
        
    }
}
