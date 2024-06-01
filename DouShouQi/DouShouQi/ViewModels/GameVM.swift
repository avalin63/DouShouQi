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
    @Published var player1 = Player(withName: "First", andId: .player1)
    @Published var player2 = Player(withName: "Second", andId: .player2)
    
    func gameOnePerson() {
        
    }
    
}
