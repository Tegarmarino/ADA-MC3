//
//  UserModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, ObservableObject {
    var money: Int
    var lvl: Int
    var xp: Int
    var activeClothesImage: String?
    var activeHatImage: String?
    var activeWallpaperImage: String?

    init(money: Int = 100, lvl : Int = 1, xp: Int = 0) { // Default money is 100
        self.money = money
        self.lvl = lvl
        self.xp = xp
    }
    
    // sambungo iki sesok
    func gainXP(xp: Int){
        if self.xp + xp >= 1000{
            lvl += 1
            self.xp += xp
            self.xp -= 1000
        } else {
            self.xp += xp
        }
    }
}
