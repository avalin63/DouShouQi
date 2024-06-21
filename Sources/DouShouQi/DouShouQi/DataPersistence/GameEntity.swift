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
    var id: UUID?
    var startGameDate: Date?
    var isVersusAI: Bool?
    var firstUserName: String?
    var secondUserName: String?
    var isOver: Bool?
    var defeatReason: String?
    var nbRoundsPlayed: Int16? = 0
    var winPlayerName: String?
    public init() {

    }
    
}
