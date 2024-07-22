//
//  EditingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 17/07/24.
//

import SwiftUI

struct EditingView: View {
    let action: (() -> Void)
    @Binding var contents: [JournalContent]
    
    @State private var text: NSAttributedString = NSAttributedString(string: "")
    
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var isUnderline: Bool = false
    
    let VPW = UIScreen.main.bounds.size.width
    
    init(_ contents: Binding<[JournalContent]>, action: @escaping () -> Void) {
        _contents = contents
        self.action = action
    }
    
    var body: some View {
        ZStack {
            RichTextEditor(text: $text, isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline, placeholder: "Write here...")
                .font(Font.format.textBodyFour)
                .padding(EdgeInsets(top: 24.0, leading: 20, bottom: 48, trailing: 20))
            VStack {
                Spacer()
                JournalToolBar(isBold: $isBold, isItalic: $isItalic, isUnderline: $isUnderline) { action in
                    if action == .save {
                        contents.append(.text(convertToData(text)))
                        self.action()
                    }
                }
            }
            .frame(width: VPW)
        }
        .frame(width: VPW)
    }
}
