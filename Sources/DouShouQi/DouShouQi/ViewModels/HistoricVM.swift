//
//  HistoricVM.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 17/06/2024.
//

import Foundation
import DouShouQiModel
import CoreData
import PhotosUI

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
    
    
    func saveCurrentGame(startGameDate: Date, endGameDate: Date?, isVersusAI:Bool, firstUser: User, secondUser:User?,isOver: Bool, defeatReason: String, nbRoundsPlayed: Int, winPlayer: User) {
        let context = dataManager.context
        let newGame = GameEntity(context: context)
        newGame.id = UUID()
        newGame.startGameDate = startGameDate
        newGame.endGameDate = endGameDate
        newGame.isVersusAI = isVersusAI
        newGame.firstUserId = firstUser.id
        newGame.secondUserId = secondUser?.id
        newGame.isOver = isOver
        newGame.defeatReason = defeatReason
        newGame.nbRoundsPlayed = Int16(nbRoundsPlayed)
        newGame.winPlayerId = winPlayer.id
        dataManager.saveContext()
        loadGameHistory()
    }
    
    func deleteAllGames() {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GameEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            dataManager.saveContext()
            loadGameHistory()
        } catch {
            print("Failed to delete all games: \(error)")
        }
    }
    
    func getWinLossStatistics() -> [UUID: (wins: Int, losses: Int)] {
            var statistics: [UUID: (wins: Int, losses: Int)] = [:]
            
            for game in gameHistory {
                guard let winnerId = game.winPlayerId else { continue }
                let firstUserId = game.firstUserId
                let secondUserId = game.secondUserId
                
                // Update win count for the winner
                if let currentStats = statistics[winnerId] {
                    statistics[winnerId] = (wins: currentStats.wins + 1, losses: currentStats.losses)
                } else {
                    statistics[winnerId] = (wins: 1, losses: 0)
                }
                
                // Update loss count for the loser
                if let firstUserId = firstUserId, firstUserId != winnerId {
                    if let currentStats = statistics[firstUserId] {
                        statistics[firstUserId] = (wins: currentStats.wins, losses: currentStats.losses + 1)
                    } else {
                        statistics[firstUserId] = (wins: 0, losses: 1)
                    }
                }
                
                if let secondUserId = secondUserId, secondUserId != winnerId {
                    if let currentStats = statistics[secondUserId] {
                        statistics[secondUserId] = (wins: currentStats.wins, losses: currentStats.losses + 1)
                    } else {
                        statistics[secondUserId] = (wins: 0, losses: 1)
                    }
                }
            }
            
            return statistics
        }
}
