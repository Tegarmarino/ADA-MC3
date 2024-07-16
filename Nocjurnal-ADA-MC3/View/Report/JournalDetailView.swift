//
//  JournalDetailView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 16/07/24.
//

import SwiftUI

struct JournalDetailView: View {
    
    var journalEntry: JournalModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(journalEntry.text.string)  // Display the complete NSAttributedString as a String
                    .padding()
                        
                Text("Created at: \(journalEntry.timestamp, style: .date) \(journalEntry.timestamp, style: .time)")
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
