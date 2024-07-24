//
//  MoodCard.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 22/07/24.
//

import SwiftUI
import SwiftData

struct MoodCard: View {
    let VPW = UIScreen.main.bounds.size.width
    let date: String
    let mood: String
    let moodColor: Color
    let moodImgColor: String
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .font(Font.format.textCaption)
                }
            }
            Spacer()
            
            VStack(alignment: .leading){
                Text(date)
                    .font(Font.format.textCaption)
                    .foregroundColor(.secondary)
                HStack{
                    VStack(alignment: .leading){
                        Text("I'm feeling")
                            .bold()
                        Text(mood)
                            .bold()
                            .foregroundColor(moodColor)
                    }
                    Spacer()
                    Image(moodImgColor)
                        .resizable()
                        .frame(width: 72, height: 48)
                }
                .font(Font.format.textHeadlineFour)
                .padding(.top,-5)

            }
        }
        .padding(24)
        .frame(width: VPW-48, height: 196)
        .background(moodColor.opacity(0.2))
        .cornerRadius(24)

    }
    
}

