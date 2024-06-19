//
//  GameVM.swift
//  DouShouQi
//
//  Created by Emre Kartal on 30/05/2024.
//

import Foundation
import DouShouQiModel

class GameVM: ObservableObject {
    
    @Published var rules: Rules = ClassicRules()
    @Published var firstUser: User
    @Published var secondUser: User?
    @Published var game: Game?
    @Published var startGameDate: Date = .now
    @Published var currentPlayer: Player?
    @Published var isOver: Bool = false
    @Published var defeatReason: String = ""
    @Published var nbRoundsPlayed: Int = 2
    @Published var winPlayer: Player? = nil
    @Published var selectedMove: Move? = nil
    
    var gameScene: BoardScene? = nil
    
    var isVersusAI: Bool { secondUser == nil }
    
    init(firstUser: User, secondUser: User?) {
        self.firstUser = firstUser
        self.secondUser = secondUser
    }
        
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
            },
            setSelectedMove: { move in self.selectedMove = move },
            selectedMove: { self.selectedMove }
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
        winPlayer = player
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
