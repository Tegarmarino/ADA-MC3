//
//  App.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Kemal Dwi Heldy Muhammad on 15/07/24.
//

import SwiftUI

enum MainPageKind {
    case home
    case growth
    case sharing
}
enum PageKind: Hashable {
    case editor
    case shop
}

@Observable class Application {
    var page: MainPageKind
    var path: [PageKind]
    var tabBarShown: Bool
    
    init() {
        self.page = .home
        self.path = []
        self.tabBarShown = true
    }
}
