//
//  BoardScene.swift
//  DouShouQi
//
//  Created by Arthur Valin on 23/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class BoardScene: SKScene {
    private let board: Board = ClassicRules.createBoard()
    private var pieces: [Piece: SKSpriteNode] = [:]
    
    func insertPiece(piece: Piece, x: CGFloat, y: CGFloat) {
        let pieceNode = PieceSprite(withPiece: piece)
        pieceNode.position.x = x
        pieceNode.position.y = y
        if (piece.owner == .player2) {
            pieceNode.zRotation = .pi
        }
        pieces[piece] = pieceNode
        addChild(pieceNode)
    }
    
    func insertTile(type: CellType, x: CGFloat, y: CGFloat) {
        if let tileNode = TileSprite(withType: type) {
            tileNode.position.x = x
            tileNode.position.y = y
            addChild(tileNode)
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        scene?.size = size
        scene?.scaleMode = .fill
        scene?.backgroundColor = UIColor(named: "BoardColor")!
        
        board.grid.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, cell) in
                let xpos = (Double(x) * BoardSceneValues.CELL_SIZE) + (BoardSceneValues.CELL_SIZE / 2)
                let ypos = (Double(y) * BoardSceneValues.CELL_SIZE) + (BoardSceneValues.CELL_SIZE / 2)
                
                insertTile(type: cell.cellType, x: xpos, y: ypos)
                if let piece = cell.piece {
                    insertPiece(piece: piece, x: xpos, y: ypos)
                }
            
                let rect = SKShapeNode(
                    rect: CGRect(
                        x: (Double(x) * BoardSceneValues.CELL_SIZE),
                        y: (Double(y) * BoardSceneValues.CELL_SIZE),
                        width: BoardSceneValues.CELL_SIZE,
                        height: BoardSceneValues.CELL_SIZE)
                )
                rect.strokeColor = UIColor(named: "BoardGridColor")!
                addChild(rect)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
