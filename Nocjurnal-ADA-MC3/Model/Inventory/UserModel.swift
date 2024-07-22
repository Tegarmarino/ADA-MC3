//
//  UserModel.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 22/07/24.
//

import Foundation
import SwiftData

@Model
class User {
    var money: Int

    init(money: Int = 100) { // Default money is 100
        self.money = money
    }
}
