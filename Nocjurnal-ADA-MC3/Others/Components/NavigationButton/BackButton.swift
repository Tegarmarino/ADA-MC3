//
//  BackButton.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
//            Text("ada")
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .padding()
                .background(Color.theme.secondaryColorTheme.opacity(0.2))
                .clipShape(Circle())
                .foregroundColor(.black)
        }
    }
}

#Preview {
    BackButton()
}
