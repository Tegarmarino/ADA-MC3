//
//  MoodData.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import Foundation
import SwiftUI

struct MoodDataView: View {
    var body: some View {
        GeometryReader { proxy in
            Text("\(proxy.size.width)")
        }
    }
}


#Preview {
    MoodDataView()
}
