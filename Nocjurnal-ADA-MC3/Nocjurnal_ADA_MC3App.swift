//
//  Nocjurnal_ADA_MC3App.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI
import SwiftData

@main
struct Nocjurnal_ADA_MC3App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalModel.self)
    }
}
