//
//  Collection.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 25/07/24.
//

import Foundation
import SwiftUI

public extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
