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
                        .foregroundColor(Color(red: 19 / 255, green: 112 / 255, blue: 160 / 255))
                }
            }
            .padding(10)
            .foregroundColor(Color(red: 19 / 255, green: 112 / 255, blue: 160 / 255))
        }
        .frame(width: VPW - 48,height: 50)
        .padding(10)
        .background(Color(red: 139 / 255, green: 193 / 255, blue: 222 / 255))
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
