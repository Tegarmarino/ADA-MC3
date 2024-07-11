//
//  ProfileView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            HStack {
                BackButton()
                Spacer()
            }
            
            Spacer()
            Text("Profile View")
        }
        .padding(.horizontal, 10)
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}
