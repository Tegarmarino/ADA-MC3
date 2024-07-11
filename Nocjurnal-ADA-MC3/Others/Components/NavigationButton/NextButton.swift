//
//  NextButton.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct NextButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(Color.theme.primaryColorTheme)
            .foregroundColor(.black)
            .cornerRadius(35 / 2)
    }
}

#Preview {
    NextButton(title: "Next")
}
