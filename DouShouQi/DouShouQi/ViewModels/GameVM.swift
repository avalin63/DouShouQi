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
    @Published var isVersusAI: Bool = false
    @Published var firstUser: User = User(image: "", name: "")
    @Published var secondUser: User = User(image: "", name: "")
    
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
            // game?.start()
        } catch {
            print("Error creating game : \(error)")
        }
        
    }
    
}
