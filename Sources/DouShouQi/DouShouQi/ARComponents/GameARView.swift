//
//  GameARView.swift
//  DouShouQi
//
//  Created by Emre Kartal on 12/06/2024.
//

import SwiftUI
import ARKit
import RealityKit
import DouShouQiModel

class GameARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    convenience init(board: Board) {
        self.init(frame: UIScreen.main.bounds)
        displayBoard(board: board)
    }
    
    func displayBoard(board: Board) {
        let arBoard = ARBoard(image: "board")
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [1, 1])
        anchor.addChild(arBoard)
        self.scene.addAnchor(anchor)
        
        board.grid.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, cell) in
                let (xpos, ypos) = arBoard.toRealCoordinates(atX: x, atY: y, nbColumns: board.nbColumns, nbRows: board.nbRows)
                
                if let piece = cell.piece {
                    let arPiece = ARPiece(image: piece.animal.pieceObject, isPlayer2: piece.owner == .player2)
                    arPiece.position = [xpos, 0.02, ypos]
                    anchor.addChild(arPiece)
                    self.installGestures(.all, for: arPiece as Entity & HasCollision)
                }
            }
        }
    }
}
