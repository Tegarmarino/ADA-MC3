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
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showJournalView = false
    @StateObject private var viewModel = AuthenticationViewModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ZStack {
                if hasCompletedOnboarding {
                    NavigationStack(path: $app.path) {
                        ContentView()
                            .navigationDestination(for: PageKind.self) { i in
                                if i == .editor {
                                    JournalView()
                                } else if i == .reward {
                                    JournalRewardView()
                                } else if i == .entries {
                                    JournalListView()
                                } else {
                                    EmptyView()
                                }
                            }
                            .onChange(of: scenePhase) { newPhase in
                                if newPhase == .background {
                                    viewModel.clearAuthentication()
                                }
                            }
                    }

                    VStack(spacing: 0) {
                        Spacer()
                        TabBar()
                    }
                } else {
                    OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                }
            }
            .environment(app)
        }
        .onChange(of: app.path) {
            if app.path.isEmpty {
                app.tabBarShown = true
            } else {
                app.tabBarShown = false
            }
        }
        .modelContainer(for: [JournalModel.self, UserInventoryItem.self, User.self])
    }
}
