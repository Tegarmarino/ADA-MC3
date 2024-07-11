//
//  CircleButton.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct CircleButton: View {
    
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .padding()
            .background(Color.black.opacity(0.7))
            .clipShape(Circle())
            .foregroundColor(Color.theme.primaryColorTheme)
    }
}

#Preview {
    CircleButton(icon: "person.fill")
}
