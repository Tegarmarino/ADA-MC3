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
            DispatchQueue.main.async {
                self.parent.text = NSAttributedString(attributedString: textView.attributedText)
            }
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
        placeholderLabel.font = UIFont(name: "Kodchasan-Medium", size: 14)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.attributedText = text
        textView.font = UIFont(name: "Kodchasan-Medium", size: 14)
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
    
    func updateAttributes(_ attributes: inout [NSAttributedString.Key: Any], isBold: Bool, isItalic: Bool, isUnderline: Bool) {
        let currentFont = attributes[.font] as? UIFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let boldTrait = isBold ? UIFontDescriptor.SymbolicTraits.traitBold : UIFontDescriptor.SymbolicTraits()
        let italicTrait = isItalic ? UIFontDescriptor.SymbolicTraits.traitItalic : UIFontDescriptor.SymbolicTraits()
        let combinedTraits = UIFontDescriptor.SymbolicTraits(arrayLiteral: boldTrait, italicTrait)
        
        if let newFontDescriptor = currentFont.fontDescriptor.withSymbolicTraits(combinedTraits) {
            attributes[.font] = UIFont(descriptor: newFontDescriptor, size: currentFont.pointSize)
        }
        
        let underlineStyle = isUnderline ? NSUnderlineStyle.single.rawValue : 0
        attributes[.underlineStyle] = underlineStyle
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        guard let textView = context.coordinator.textView else { return }
        
        if textView.attributedText.length == 0 && textView.text.isEmpty {
            print("Attributed Text is empty")
            // Ensure we do not apply attributes when there is no text
            return
        }
        
        if let selectedRange = textView.selectedTextRange {
            let location = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            let length = textView.offset(from: selectedRange.start, to: selectedRange.end)
            let nsRange = NSRange(location: location, length: length)
            
            // Check if nsRange is valid before attempting to apply attributes
            if nsRange.location != NSNotFound && nsRange.location < textView.attributedText.length {
                print("Applying attributes: Location = \(nsRange.location), Length = \(nsRange.length)")
                let currentAttributes = textView.attributedText.attributes(at: nsRange.location, effectiveRange: nil)
                var newAttributes = currentAttributes
                
                updateAttributes(&newAttributes, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline)
                
                if nsRange.location + nsRange.length <= textView.attributedText.length {
                    textView.attributedText = updateAttributedString(textView.attributedText, range: nsRange, attributes: newAttributes)
                }
            } else {
                print("Attempted to apply attributes out of bounds")
            }
        }
        
        // Always ensure typing attributes are safe to apply
        updateTypingAttributes(textView)
        
        // Update binding text to reflect any changes
        DispatchQueue.main.async {
            self.text = NSAttributedString(attributedString: textView.attributedText)
        }
    }
    
    func updateTypingAttributes(_ textView: UITextView) {
        var typingAttributes = textView.typingAttributes as [NSAttributedString.Key: Any]
        let currentFont = typingAttributes[.font] as? UIFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // Apply bold and italic traits
        let boldTrait = isBold ? UIFontDescriptor.SymbolicTraits.traitBold : UIFontDescriptor.SymbolicTraits()
        let italicTrait = isItalic ? UIFontDescriptor.SymbolicTraits.traitItalic : UIFontDescriptor.SymbolicTraits()
        let combinedTraits = UIFontDescriptor.SymbolicTraits(arrayLiteral: boldTrait, italicTrait)
        
        if let newFontDescriptor = currentFont.fontDescriptor.withSymbolicTraits(combinedTraits) {
            typingAttributes[.font] = UIFont(descriptor: newFontDescriptor, size: currentFont.pointSize)
        }
        
        // Apply underline style
        let underlineStyle = isUnderline ? NSUnderlineStyle.single.rawValue : 0
        typingAttributes[.underlineStyle] = underlineStyle
        
        textView.typingAttributes = typingAttributes
    }
    
    func updateAttributedString(_ attributedString: NSAttributedString, range: NSRange, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttributedString.addAttributes(attributes, range: range)
        return mutableAttributedString
    }
    
    func updateFontTrait(_ font: UIFont?, trait: UIFontDescriptor.SymbolicTraits, isEnabled: Bool) -> UIFont {
        guard let font = font else { return UIFont.systemFont(ofSize: UIFont.systemFontSize) }
        var traits = font.fontDescriptor.symbolicTraits
        if isEnabled {
            traits.insert(trait)
        } else {
            traits.remove(trait)
        }
        if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: font.pointSize)
        } else {
            return font
        }
    }
}
