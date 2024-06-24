//
//  GameContext.swift
//  DouShouQi
//
//  Created by Arthur Valin on 24/06/2024.
//

import Foundation
import DouShouQiModel

protocol GameContext {

    func executeMove(board: Board, move: Move, goodMove: Bool)
    func removePiece(row: Int, column: Int, piece: Piece)
    
}
