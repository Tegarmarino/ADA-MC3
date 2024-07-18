//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    @State private var buttonState = ButtonState.idle
    @State private var selectedIndex = 0
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                ButtonIcon("bag", state: $buttonState, type: .secondary) {
                    
                }
                Spacer()
                ButtonIcon("person", state: $buttonState, type: .secondary) {
                    
                }
                
                Text("Testing")
                    .foregroundColor(Color.redColorTheme)
            }
            .frame(width: VPW - 48)
            .padding(.horizontal, 10)
            
            Spacer()
        }
    }
    
}
