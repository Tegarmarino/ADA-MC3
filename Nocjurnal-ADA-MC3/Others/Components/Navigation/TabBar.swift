//
//  TabBar.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

struct TabBar: View {
    @Environment(Application.self) private var app
    
    @State private var pages: [(MainPageKind, String, String)] = [(.home, "house", "Home"), (.growth, "chart.bar", "Growth"), (.sharing, "person.2", "Sharing")]
    
    let VPW = UIScreen.main.bounds.size.width
    let VPH = UIScreen.main.bounds.size.height
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(pages, id: \.self.0) { page in
                    VStack(alignment: .center, spacing: 6) {
                        Image(systemName: page.1 + (app.page == page.0 ? ".fill" : ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .scaleEffect(page.0 == app.page ? 1 : 0.9)
                            .foregroundStyle(page.0 == app.page ? Color.theme.primaryColorTheme : Color.theme.fontTertiaryColorTheme)
                            .animation(.spring(duration: 0.25), value: page.0 == app.page)
                        
                        Text(page.2)
                            .font(.custom("Kodchasan-Bold", size: 10))
                            .foregroundStyle(page.0 == app.page ? Color.theme.primaryColorTheme : Color.theme.fontTertiaryColorTheme)
                            .scaleEffect(page.0 == app.page ? 1 : 0.9)
                            .animation(.spring(duration: 0.25), value: page.0 == app.page)
                        
                    }
                    .frame(width: (VPW - 156) / 3, height: 72)
                    .onTapGesture {
                        app.page = page.0
                    }
                }
            }
            .padding(.horizontal, 18)
            .frame(width: VPW - 138, height: 72)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 36)
                        .fill(.ultraThinMaterial)
                    RoundedRectangle(cornerRadius: 36)
                        .fill(Color.theme.fontPrimaryColorTheme)
                        .opacity(0.75)
                }
            )
            
            Button {
                app.path.append(.editor)
                print(app.path)
            } label: {
                Image(systemName: "pencil.and.scribble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 24)
            }
            .frame(width: 72, height: 72)
            .buttonStyle(NocjournalButtonStyle(.fab))
        }
        .frame(width: VPW - 48, height: 60)
    }
}
