//
//  GameEntity.swift
//  
//
//  Created by Lucas Delanier on 12/06/2024.
//
//

import Foundation
import SwiftData


@Model public class GameEntity {
    var defeatReason: String?
    var firstUserName: String?
    var id: UUID?
    var isOver: Bool?
    var isVersusAI: Bool?
    var nbRoundsPlayed: Int16? = 0
    var secondUserName: String?
    var startGameDate: Date?
    var winPlayerName: String?
    var endGameDate: Date?
    public init() {

    }
    
}
