//
//  GameEntity.swift
//  
//
//  Created by Lucas Delanier on 22/06/2024.
//
//

import Foundation
import SwiftData


@Model public class GameEntity {
    var defeatReason: String?
    var endGameDate: Date?
    var firstUserId: UUID?
    var id: UUID?
    var isOver: Bool?
    var isVersusAI: Bool?
    var nbRoundsPlayed: Int16? = 0
    var secondUserId: UUID?
    var startGameDate: Date?
    var winPlayerId: UUID?
    public init() {

    }
    
}
