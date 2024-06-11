//
//  GameVM.swift
//  DouShouQi
//
//  Created by Emre Kartal on 30/05/2024.
//

import Foundation
import DouShouQiModel

class GameVM: ObservableObject {
    
    @Published var game: Game?
    @Published var startGameDate: Date = .now
    @Published var isVersusAI: Bool = false
    @Published var firstUser: User = User(image: "", name: "")
    @Published var secondUser: User = User(image: "", name: "")
    @Published var currentPlayer: Player?
    @Published var isOver: Bool = false
    @Published var defeatReason: String = ""
    @Published var nbRoundsPlayed: Int = 0
    
    func startGame() {
        let firstPlayer = HumanPlayer(withName: firstUser.name, andId: .player1)
        var secondPlayer: Player?
        
        if isVersusAI {
            secondPlayer = IAPlayer(withName: "Bot", andId: .player2)
        } else {
            secondPlayer = HumanPlayer(withName: secondUser.name, andId: .player2)
        }
        
        do {
            game = try Game(withRules: ClassicRules(), andPlayer1: firstPlayer!, andPlayer2: secondPlayer!)
            game?.addGameStartedListener(updateStartGame)
            game?.addPlayerNotifiedListener(updateCurrentPlayer)
            game?.addGameOverListener(updateGameOver)
            Task {
                try await game?.start()
            }
        } catch {
            print("Error creating game : \(error)")
        }
        
    }
    
    func updateStartGame(board: Board) {
        startGameDate = .now
    }
    
    func updateCurrentPlayer(board: Board, player: Player) async throws {
        currentPlayer = player
    }
    
    func updateGameOver(board: Board, result: Result, player: Player?) {
        isOver = true
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
    }
}
