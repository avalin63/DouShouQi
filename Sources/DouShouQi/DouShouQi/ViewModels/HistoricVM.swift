//
//  HistoricVM.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 17/06/2024.
//

import Foundation
import DouShouQiModel
import CoreData
import UIKit

class HistoricVM: ObservableObject {
    
    @Published var gameHistory: [GameEntity] = []
    
    init(){
        loadGameHistory()

    }
    
    private let dataManager = DataManager.shared
    
    func loadGameHistory() {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            self.gameHistory = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch game history: \(error)")
        }
    }
    
    func saveCurrentGame(startGameDate: Date, endGameDate: Date?, isVersusAI:Bool, firstUser: User, secondUser:User?,isOver: Bool, defeatReason: String, nbRoundsPlayed: Int, winPlayer: String?, winningPicture: UIImage? ) {
        let context = dataManager.context
        let newGame = GameEntity(context: context)
        newGame.id = UUID()
        newGame.startGameDate = startGameDate
        newGame.endGameDate = endGameDate
        newGame.isVersusAI = isVersusAI
        newGame.firstUserName = firstUser.name
        newGame.secondUserName = secondUser?.name
        newGame.isOver = isOver
        newGame.defeatReason = defeatReason
        newGame.nbRoundsPlayed = Int16(nbRoundsPlayed)
        newGame.winPlayerName = winPlayer
        newGame.winningPicture = winningPicture?.base64
        dataManager.saveContext()
        loadGameHistory()
    }
}
