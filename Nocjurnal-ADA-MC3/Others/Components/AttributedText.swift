//
//  AttributedText.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 15/07/24.
//

import SwiftUI
import UIKit

struct AttributedText: UIViewRepresentable {
    var attributedString: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
