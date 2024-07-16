//
//  Nocjurnal_ADA_MC3App.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

@main
struct Nocjournal: App {
    @State private var app = Application()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $app.path) {
                    ContentView()
                        .navigationDestination(for: PageKind.self) { i in
                            if i == .editor {
                                JournalView()
                            } else {
                                EmptyView()
                            }
                        }
                }
                
                VStack(spacing: 0) {
                    Spacer()
                    TabBar()
                }
            }
            .environment(app)
        }
        .modelContainer(for: JournalModel.self)
    }
}
