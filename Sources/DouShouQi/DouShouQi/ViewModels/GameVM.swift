//
//  GameVM.swift
//  DouShouQi
//
//  Created by Emre Kartal on 30/05/2024.
//

import Foundation
import DouShouQiModel
import CoreData

class GameVM: ObservableObject {
    
    @Published var rules: Rules = ClassicRules()
    @Published var firstUser: User
    @Published var secondUser: User?
    @Published var game: Game?
    @Published var startGameDate: Date = .now
    @Published var endGameDate: Date?
    @Published var currentPlayer: Player?
    @Published var isOver: Bool = false
    @Published var defeatReason: String = ""
    @Published var nbRoundsPlayed: Int = 2
    @Published var gameColors = GameColors()
    @Published var gameScene: BoardScene? = nil
    @Published var winPlayer: Player? = nil
    @Published var gameHistory: [GameEntity] = []
    
    @Published var navigateToSummary = false
    
    
    init(firstUser: User, secondUser: User? = nil) {
        self.firstUser = firstUser
        self.secondUser = secondUser
        self.rules = ClassicRules()
        loadGameHistory()
    }
    
    private let dataManager = DataManager.shared
    
    var isVersusAI: Bool { secondUser == nil }
    
    
    func startGame() {
        let firstPlayer = HumanPlayer(withName: firstUser.name, andId: .player1)!
        let secondPlayer: Player =  if let secondUser {
            HumanPlayer(withName: secondUser.name, andId: .player2)!
        } else {
            RandomPlayer(withName: "Bot", andId: .player2)!
        }
        
        do {
            game = try Game(withRules: rules, andPlayer1: firstPlayer, andPlayer2: secondPlayer)
            game?.addGameStartedListener(updateStartGame)
            game?.addPlayerNotifiedListener(updateCurrentPlayer)
            game?.addGameOverListener(updateGameOver)
            game?.addMoveChosenCallbacksListener { (board, move, player) in
                self.nbRoundsPlayed += 1
                self.gameScene?.executeMove(move: move)
            }
            
            Task {
                try await game?.start()
            }
        } catch {
            print("Error creating game : \(error)")
        }
        
    }
    
    func updateStartGame(board: Board) {
        startGameDate = .now
        gameScene = BoardScene(            
            board: { self.game?.board ?? board },
            currentPlayer: { self.currentPlayer! },
            rules: rules,
            onValidateMove: { move in
                Task {
                    try await self.game?.onPlayed(with: move, from: self.currentPlayer!)
                }
            }
        )
    }
    
    func updateCurrentPlayer(board: Board, player: Player) async throws {
        currentPlayer = player
        
        if !(self.currentPlayer is HumanPlayer) {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            try await self.currentPlayer?.chooseMove(in: board, with: rules)
        }
    }
    
    func updateGameOver(board: Board, result: Result, player: Player?) {
        isOver = true
        endGameDate = Date()
        winPlayer = player
        saveCurrentGame()
        switch result {
        case .notFinished:
            print("**********************************")
            print("Partie non terminée.")
            print("**********************************")
        case .even:
            print("**********************************")
            print("Partie terminée avec égalité !")
            print("**********************************")
        case let .winner(owner, reason):
            switch reason {
            case .denReached:
                print("**********************************")
                print("Partie terminée !!!\nEt le gagnant est... Player \(owner) !\nTanière atteinte !")
                print("**********************************")
            case .noMorePieces:
                print("**********************************")
                print("Partie terminée !!!\nEt le gagnant est... Player \(owner) !\nPlus de pièces !")
                print("**********************************")
            case .noMovesLeft:
                print("**********************************")
                print("Partie terminée !!!\nEt le gagnant est... Player \(owner) !\nAucun coup possible !")
                print("**********************************")
            case .tooManyOccurences:
                print("**********************************")
                print("Partie terminée !!!\nEt le gagnant est... Player \(owner) !\nTrop d'occurrences !")
                print("**********************************")
            }
        }
        delayNavigateToSummary()
    }
    
    private func saveCurrentGame() {
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
        newGame.winPlayerName = winPlayer?.name
        dataManager.saveContext()
        print("Game saved: \(newGame)")
        loadGameHistory()
    }
    
    private func loadGameHistory() {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            self.gameHistory = try context.fetch(fetchRequest)
            print("Games load: \(gameHistory)")
        } catch {
            print("Failed to fetch game history: \(error)")
        }
    }
    
    private func delayNavigateToSummary() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToSummary = true
        }
    }
}
