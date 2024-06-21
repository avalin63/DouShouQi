//
//  GameEntity+CoreDataProperties.swift
//  
//
//  Created by Lucas Delanier on 12/06/2024.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var defeatReason: String?
    @NSManaged public var firstUserName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isOver: Bool
    @NSManaged public var isVersusAI: Bool
    @NSManaged public var nbRoundsPlayed: Int16
    @NSManaged public var secondUserName: String?
    @NSManaged public var startGameDate: Date?
    @NSManaged public var winPlayerName: String?

}
