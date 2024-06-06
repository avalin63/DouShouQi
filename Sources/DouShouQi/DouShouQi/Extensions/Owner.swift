//
//  Player.swift
//  DouShouQi
//
//  Created by Arthur Valin on 30/05/2024.
//

import Foundation
import DouShouQiModel
import SwiftUI

extension Owner {
    public var tileColor: String? {
        switch(self) {
        case .noOne:
            nil
        case .player1:
            "Player1Color"
        case .player2:
            "Player2Color"
        default:
            nil
        }
    }
    
    public var playerColor: Color? {
        switch(self) {
        case .noOne:
            nil
        case .player1:
            DSQColors.player1
        case .player2:
            DSQColors.player2
        default:
            nil
        }
    }
}
