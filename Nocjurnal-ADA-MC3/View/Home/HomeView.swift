//
//  HomeView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State private var buttonState = ButtonState.idle
    @State private var selectedIndex = 0
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                Spacer()
            }

            HStack{
                ButtonIcon("bag", state: $buttonState, type: .secondary) {
                }
                Spacer()
                ButtonIcon("person", state: $buttonState, type: .secondary) {
                }
            }
            .padding(EdgeInsets(top: safeAreaInsets.top, leading: 24, bottom: 0, trailing: 24))
            .frame(width: VPW)
            .ignoresSafeArea()
        }
        .frame(width: VPW, height: VPH, alignment: .topLeading)
        .ignoresSafeArea()
        .background(Color.theme.backgroundColorTwoTheme)
    }
    
}
