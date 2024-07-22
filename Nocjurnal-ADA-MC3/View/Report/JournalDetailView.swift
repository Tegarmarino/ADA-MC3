//
//  JournalDetailView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 16/07/24.
//

import SwiftUI

struct JournalDetailView: View {
    
    var entry: JournalModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(entry.contents.enumerated()), id: \.offset) { index, content in
                    if case let .text(data) = content {
                        Text(convertToString(data))
                    }
                }
//                Text(journalEntry.text.string)  // Display the complete NSAttributedString as a String
//                    .padding()
                
                Text("Created at: \(entry.timestamp, style: .date) \(entry.timestamp, style: .time)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("Journal Entry Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    JournalDetailView()
//}
