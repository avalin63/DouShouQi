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
    @Published var endGameDate: Date?
    @Published var currentPlayer: Player?
    @Published var isOver: Bool = false
    @Published var defeatReason: String = ""
    @Published var nbRoundsPlayed: Int = 2
    @Published var selectedMove: Move? = nil
    @Published var gameColors = GameColors()
    @Published var gameContext: GameContext? = nil
    @Published var winUser: User? = nil
    @Published var navigateToSummary = false
    
    init(firstUser: User, secondUser: User?) {
        self.firstUser = firstUser
        self.secondUser = secondUser
        self.rules = ClassicRules()
    }
    
    
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
            
            game?.addInvalidMoveCallbacksListener { (board, move, player, valid) in
                if valid {
                    self.nbRoundsPlayed += 1
                }
                self.gameContext?.executeMove(board: board, move: move, goodMove: valid)
            }
            
            game?.addPieceRemovedListener { (row, column, piece) in
                self.gameContext?.removePiece(row: row, column: column, piece: piece)
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
        createSpriteBoard(board: board)
    }
    
    func switchGameContext() {
        if (gameContext is BoardScene) {
            createARBoard(board: self.game!.board)
        } else {
            createSpriteBoard(board: self.game!.board)
        }
    }
    
    func createSpriteBoard(board: Board) {
        gameContext = BoardScene(
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
 
    func createARBoard(board: Board) {
        gameContext = GameARView(
            board: self.game?.board ?? board,
            currentPlayer: { self.currentPlayer! }
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
        winUser = firstUser.name == player?.name ? firstUser : secondUser
        defeatReason = result.description
        delayNavigateToSummary()
    }
    
    private func delayNavigateToSummary() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToSummary = true
        }
    }
}
