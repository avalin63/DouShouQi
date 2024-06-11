//
//  User.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 11/06/2024.
//

import Foundation
import DouShouQiModel

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
