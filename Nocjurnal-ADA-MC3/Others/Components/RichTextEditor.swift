//
//  RichTextEditor.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 15/07/24.
//

import SwiftUI
import UIKit

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var isUnderline: Bool
    
    var placeholder: String

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor
        var textView: UITextView?
        var placeholderLabel: UILabel?

        init(parent: RichTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
            updatePlaceholderVisibility(textView: textView)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            updatePlaceholderVisibility(textView: textView)
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            updatePlaceholderVisibility(textView: textView)
        }

        func updatePlaceholderVisibility(textView: UITextView) {
            guard let placeholderLabel = placeholderLabel else { return }
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.attributedText = text
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(Color.theme.backgroundColorOneTheme)
        
        textView.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
        ])
        
        context.coordinator.textView = textView
        context.coordinator.placeholderLabel = placeholderLabel
        context.coordinator.updatePlaceholderVisibility(textView: textView)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        guard let textView = context.coordinator.textView else { return }

        // Check if there's a selected range to update the attributes; otherwise, update the typing attributes directly
        let currentAttributes = textView.typingAttributes

        // Safely extract the font from current attributes or use the default system font
        var font = (currentAttributes[NSAttributedString.Key.font] as? UIFont) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        var traits: UIFontDescriptor.SymbolicTraits = font.fontDescriptor.symbolicTraits

        // Apply or remove bold trait
        if isBold {
            traits.insert(.traitBold)
        } else {
            traits.remove(.traitBold)
        }

        // Apply or remove italic trait
        if isItalic {
            traits.insert(.traitItalic)
        } else {
            traits.remove(.traitItalic)
        }

        // Create a new font descriptor with the updated traits
        if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
            font = UIFont(descriptor: descriptor, size: font.pointSize)
        }

        // Update the typing attributes for new input in the text view
        textView.typingAttributes[NSAttributedString.Key.font] = font

        // Manage underline style separately, applying or removing it
        if isUnderline {
            textView.typingAttributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        } else {
            textView.typingAttributes.removeValue(forKey: NSAttributedString.Key.underlineStyle)
        }

        // Ensure the attributed text is updated to reflect any changes if needed
        if textView.attributedText != text {
            textView.attributedText = text
        }
        context.coordinator.updatePlaceholderVisibility(textView: textView)
    }



}
