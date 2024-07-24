//
//  AuthenticationViewModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 24/07/24.
//

import LocalAuthentication
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @Published var authError: String?

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Check if biometric or passcode authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate to access the app."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.authError = authenticationError?.localizedDescription ?? "Failed to authenticate"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.authError = error?.localizedDescription ?? "Authentication not available"
            }
        }
    }

    func clearAuthentication() {
        self.isAuthenticated = false
    }
}
