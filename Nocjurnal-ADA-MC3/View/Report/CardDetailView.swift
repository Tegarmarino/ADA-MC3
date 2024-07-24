//
//  CardDetailView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 23/07/24.
//

import SwiftUI

struct CardDetailView: View {
    var journal: JournalModel

    var body: some View {
        ScrollView{
            HStack{
                VStack(alignment: .leading) {
                    BackButton()
                        .padding(.bottom)
                    HStack {
                        Text("I'm Feeling")
                        Text(journal.mood.rawValue.capitalized)
                            .foregroundColor(getColor(for: journal.mood).color)
                    }
                    .font(Font.format.textHeadlineOne)
                    
                    
                    Text(formatDateTime(journal.timestamp))
                        .font(Font.format.textBodyFour)
                        .foregroundColor(.secondary)
                    
                    HStack{
                        ForEach(journal.tags, id: \.self) { tag in
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
                    .padding(.vertical)

                    
                    
                    ForEach(journal.contents.indices, id: \.self) { index in
                        switch journal.contents[index] {
                        case .text(let data):
                            Text(convertToString(data))
                                .font(Font.format.textBodyThree)
                        case .image(let data):
                            if let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                        case .audio(_):
                            Text("Audio content")
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal,24)
            .navigationBarBackButtonHidden(true)
            .padding(.bottom,80)

        }

    }
    private func formatDateTime(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, HH:mm"
            return dateFormatter.string(from: date)
        }
        
        private func convertToString(_ data: Data) -> String {
            return (try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil))?.string ?? ""
        }
}
//
//#Preview {
//    CardDetailView()
//}
