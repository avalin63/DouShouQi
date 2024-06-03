//
//  BoardScene.swift
//  DouShouQi
//
//  Created by Arthur Valin on 23/05/2024.
//

import Foundation
import SpriteKit
import SwiftUI
import DouShouQiModel

class BoardScene: SKScene {
    @ObservedObject var state: GameViewState
    private let board: Board
    private var pieces: [(piece: Piece, node: SKSpriteNode)] = []
    private var moves: [(move: Move, node: SKShapeNode)] = []
    private var selectedMove: (move: Move, line: SKShapeNode, label: SKLabelNode)? = nil
    
    init(size: CGSize, colors: GameColors, board: Board, state: GameViewState) {
        print("InitBoard")
        self.board = board
        self.state = state
        super.init(size: size)
        
        scene?.size = size
        scene?.scaleMode = .fill
        scene?.backgroundColor = colors.boardColor
        
        board.grid.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, cell) in
                let (xpos, ypos) = toRealCoordinates(atX: x, atY: y)
                
                if (cell.cellType == .water) {
                    let water = SKShapeNode(
                        rect: CGRect(
                            x: (Double(x) * BoardSceneValues.CELL_SIZE),
                            y: (Double(y) * BoardSceneValues.CELL_SIZE),
                            width: BoardSceneValues.CELL_SIZE,
                            height: BoardSceneValues.CELL_SIZE)
                    )
                    water.fillColor = colors.waterColor
                    water.strokeColor = colors.waterColor
                    addChild(water)
                }
                
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
                rect.strokeColor = colors.boardGridColor
                addChild(rect)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.board = ClassicRules.createBoard()
        self.state = GameViewState()
        super.init(coder: aDecoder)
    }
    
    func insertPiece(piece: Piece, x: CGFloat, y: CGFloat) {
        let pieceNode = PieceSprite(withPiece: piece)
        pieceNode.position.x = x
        pieceNode.position.y = y
        pieceNode.zPosition = 10.0
        if (piece.owner == .player2) {
            pieceNode.zRotation = .pi
        }
        pieces.append((piece, pieceNode))
        addChild(pieceNode)
    }
    
    func insertTile(type: CellType, x: CGFloat, y: CGFloat) {
        if let tileNode = TileSprite(withType: type) {
            tileNode.position.x = x
            tileNode.position.y = y
            addChild(tileNode)
        }
    }
    
    func insertPossibleMove(move: Move, x: CGFloat, y: CGFloat) {
        let shape = SKShapeNode(circleOfRadius: (BoardSceneValues.CELL_SIZE / 2) - 10)
        let color = SKColor(named: state.currentPlayer.id.tileColor!)!
        shape.fillColor = color
        shape.strokeColor = color
        shape.alpha = 0.5
        shape.position.x = x
        shape.position.y = y
        shape.zPosition = 15.0
        
        moves.append((move, shape))
        addChild(shape)
    }

    private func toRealCoordinates(atX x: Int, atY y: Int) -> (x: Double, y: Double) {
        let xpos = (Double(x) * BoardSceneValues.CELL_SIZE) + (BoardSceneValues.CELL_SIZE / 2)
        let ypos = (Double(y) * BoardSceneValues.CELL_SIZE) + (BoardSceneValues.CELL_SIZE / 2)
        return (xpos, ypos)
    }
    
    private func getBoardCoordinates(atX x: Double, atY y: Double) -> (x: Int, y: Int) {
        (Int(x / BoardSceneValues.CELL_SIZE), Int(y / BoardSceneValues.CELL_SIZE))
    }

    private func refreshMoves() {
        moves.forEach { (_, node) in
            let color = SKColor(named: state.currentPlayer.id.tileColor!)!
            node.alpha = 0.5
            node.fillColor = color
            node.strokeColor = color
            node.children.forEach { child in
                child.removeFromParent()
            }
        }
    }
    
    private func clearMoves() {
        moves.forEach { (_, node) in
            node.removeFromParent()
        }
        
        moves.removeAll()
        clearSelectedMove()
    }
    
    private func clearSelectedMove() {
        if let move = selectedMove {
            move.label.removeFromParent()
            move.line.removeFromParent()
        }
        
        selectedMove = nil
    }
    
    private func findPieceNode(atX x: Int, atY y: Int, ofPlayer owner: Owner) -> (Piece, SKSpriteNode)? {
        return pieces.first(where: { (piece, node) in
            let pos = node.position
            let (posX, posY) = getBoardCoordinates(atX: pos.x, atY: pos.y)
            return (posX == x) && (posY == y) && (piece.owner == owner)
        })
    }
    
    private func findMoveNode(atX x: Int, atY y: Int) -> (Move, SKShapeNode)? {
        return moves.first(where: { (move, node) in
            let pos = node.position
            let (posX, posY) = getBoardCoordinates(atX: pos.x, atY: pos.y)
            return (posX == x) && (posY == y)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let (tileX, tileY) = getBoardCoordinates(atX: location.x, atY: location.y)
            
            if let (_, node) = findPieceNode(atX: tileX, atY: tileY, ofPlayer: state.currentPlayer.id) {
                node.size = CGSize(
                    width: BoardSceneValues.CELL_SIZE + 10,
                    height: BoardSceneValues.CELL_SIZE + 10
                )
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let (tileX, tileY) = getBoardCoordinates(atX: location.x, atY: location.y)
            
            if let (_, node) = findPieceNode(atX: tileX, atY: tileY, ofPlayer: state.currentPlayer.id) {
                node.size = CGSize(
                    width: BoardSceneValues.CELL_SIZE,
                    height: BoardSceneValues.CELL_SIZE
                )
                
                clearMoves()
                ClassicRules().getMoves(
                    in: board,
                    of: state.currentPlayer.id,
                    fromRow: tileY,
                    andColumn: tileX
                ).forEach { move in
                    print("Move : \(move.description)")
                    let (xpos, ypos) = toRealCoordinates(atX: move.columnDestination, atY: move.rowDestination)
                    insertPossibleMove(move: move, x: xpos, y: ypos)
                }

            } else if let (move, node) = findMoveNode(atX: tileX, atY: tileY) {
                refreshMoves()
                clearSelectedMove()
                node.alpha = 1.0
                
                let (xposStart, yposStart) = toRealCoordinates(atX: move.columnOrigin, atY: move.rowOrigin)
                let (xposEnd, yposEnd) = toRealCoordinates(atX: move.columnDestination, atY: move.rowDestination)
                
                let startPoint = CGPoint(x: xposStart, y: yposStart)
                let endPoint = CGPoint(x: xposEnd, y: yposEnd)
                
                let line = SKShapeNode()
                let path = CGMutablePath()
                path.move(to: startPoint)
                path.addLine(to: endPoint)
                
                line.path = path
                
                line.strokeColor = SKColor(named: state.currentPlayer.id.tileColor!)!
                line.lineWidth = 5
                
                addChild(line)
                                    
                let label = SKLabelNode(text: move.label)
                label.fontName = "Helvetica-Bold"
                label.fontSize = 15
                label.fontColor = SKColor.white
                label.verticalAlignmentMode = .center
                label.zPosition = 20
                
                node.addChild(label)
                
                selectedMove = (move, line, label)
            } else {
                clearMoves()
            }
        }
    }
}
