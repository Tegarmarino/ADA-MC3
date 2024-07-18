//
//  JournalList.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 15/07/24.
//

import SwiftUI

struct JournalCard: View {
    
    var title: String
    var time: Date
    var VPW = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                    Text(formattedDate)
                        .font(.caption)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.blueColorTheme)
                }
            }
            .padding(10)
            .foregroundColor(Color.blueColorTheme)
        }
        .frame(width: VPW - 48,height: 50)
        .padding(10)
        .background(Color.creamColorTheme)
        .cornerRadius(10)
        
    }
    var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" // Customize the date format as needed
            return formatter.string(from: time)
        }
}

//
//#Preview {
//    JournalCard(title: "Jurnal Pagi", time: "5:45 AM")
//}
