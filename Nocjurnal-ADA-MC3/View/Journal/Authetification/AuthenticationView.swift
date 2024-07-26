//
//  AuthenticationView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 24/07/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var submitState = ButtonState.idle
    @Binding var passcodeState: Bool

    var body: some View {
        if !passcodeState{
            ReportView() // Navigate to your main view here
        }
        else{
            VStack {
                if viewModel.isAuthenticated {
                    ReportView() // Navigate to your main view here
                } else {
                    VStack(spacing: 20) {
                        Text("hoo are u?")
                            .font(Font.format.textHeadlineOne)
                        
                        Image("Nocy")
                        
                        ButtonRegular("Authenticate", state: $submitState){
                            viewModel.authenticate()
                        }
                        .padding(.horizontal, 72)
                        
                        if let error = viewModel.authError {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AuthenticationView(passcodeState: .constant(false))
}
