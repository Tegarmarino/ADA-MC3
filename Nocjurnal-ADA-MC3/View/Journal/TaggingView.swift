//
//  TaggingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 17/07/24.
//

import SwiftUI

struct TaggingView: View {
    @Binding var tags: [String?]
    let action: () -> Void
    
    @State private var activity = ["Working", "Resting", "Fitness", "Hanging out", "Eating"]
    @State private var company = ["Co-workers", "Friends", "Family", "Pets", "Partner", "By myself"]
    @State private var place = ["Office", "Home", "College", "School", "Commuting"]
    
    @State private var selected: (String?, String?, String?) = (nil, nil, nil)
    
    @State private var submitState = ButtonState.idle
    
    let VPW = UIScreen.main.bounds.size.width
    
    init(_ tags: Binding<[String?]>, action: @escaping () -> Void) {
        _tags = tags
        self.action = action
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What are you doing?")
                            .font(Font.format.textBodyFour)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                        VerticalFlow(items: $activity) { item in
                            Button {
                                if selected.0 != item {
                                    selected.0 = item
                                } else {
                                    selected.0 = nil
                                }
                            } label: {
                                Text(item)
                                    .font(Font.format.textHeadlineFive)
                            }
                            .buttonStyle(NocjournalButtonStyle(selected.0 == item ? .primary : .quartenary, pill: true))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Who are you with?")
                            .font(Font.format.textBodyFour)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                        VerticalFlow(items: $company) { item in
                            Button {
                                if selected.1 != item {
                                    selected.1 = item
                                } else {
                                    selected.1 = nil
                                }
                            } label: {
                                Text(item)
                                    .font(Font.format.textHeadlineFive)
                            }
                            .buttonStyle(NocjournalButtonStyle(selected.1 == item ? .primary : .quartenary, pill: true))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Where are you?")
                            .font(Font.format.textBodyFour)
                            .foregroundStyle(Color.theme.fontPrimaryColorTheme)
                        VerticalFlow(items: $place) { item in
                            Button {
                                if selected.2 != item {
                                    selected.2 = item
                                } else {
                                    selected.2 = nil
                                }
                            } label: {
                                Text(item)
                                    .font(Font.format.textHeadlineFive)
                            }
                            .buttonStyle(NocjournalButtonStyle(selected.2 == item ? .primary : .quartenary, pill: true))
                        }
                    }
                    
                }
            }
            VStack(spacing: 0) {
                Spacer()
                ButtonRegular("Finish writing", state: $submitState) {
                    if let activity = selected.0 {
                        tags[0] = activity
                    }
                    if let company = selected.1 {
                        tags[1] = company
                    }
                    if let place = selected.2 {
                        tags[2] = place
                    }
                    
                    action()
                }
            }
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 0, trailing: 24))
        .frame(width: VPW)
    }
}
