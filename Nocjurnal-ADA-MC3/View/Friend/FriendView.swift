//
//  FriendView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct FriendView: View {
    @State private var isModalPresented = false
    @State private var isDone: Bool = false
    @AppStorage("passcodeState") private var passcodeState: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Passcode")
                        Spacer()
                        Toggle("", isOn: $passcodeState)
                            .labelsHidden()
                    }
                    
                    Button(action: {
                        isModalPresented = true
                    }) {
                        HStack {
                            Image(systemName: "bell")
                            Text("Set a Reminder")
                        }
                    }
                    .sheet(isPresented: $isModalPresented) {
                        Notification(isDone: $isDone)
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview {
    FriendView()
}
