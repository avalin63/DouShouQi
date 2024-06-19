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
    private let rules: Rules
    private let currentPlayer: () -> Player
    private let board: () -> Board
    private let setSelectedMove: (Move?) -> Void
    private let selectedMove: () -> Move?
    let onValidateMove: (Move) -> Void
    
    private var pieceNodes: [PieceSprite] { get { filterNodes(type: .piece) } }
    private var gridNodes: [SKShapeNode] { get { filterNodes(type: .grid) } }
    private var waterNodes: [SKShapeNode] { get { filterNodes(type: .water) } }
    private var moveNodes: [SKShapeNode] { get { filterNodes(type: .possibleMove) } }
    private var selectedMoveNodes: [SKShapeNode] { get { filterNodes(type: .selectedMove) } }
    
    private func filterNodes<T: SKNode>(type: NodeType) -> [T] {
        scene?.children.filter { $0.hasType(type: type) && $0 is T }.map { ($0 as! T) } ?? [T]()
    }
    
    init(
        board: @escaping () -> Board,
        currentPlayer: @escaping () -> Player,
        rules: Rules,
        onValidateMove: @escaping (Move) -> Void,
        setSelectedMove: @escaping (Move?) -> Void,
        selectedMove: @escaping () -> Move?
    ) {
        let colors = GameColors()
        self.board = board
        self.rules = rules
        self.currentPlayer = currentPlayer
        self.onValidateMove = onValidateMove
        self.setSelectedMove = setSelectedMove
        self.selectedMove = selectedMove
        super.init(size: board().gridSize)
        
        scene?.size = size
        scene?.scaleMode = .fill
        scene?.backgroundColor = colors.boardColor
        
        board().grid.enumerated().forEach { (y, row) in
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
                    water.userData = ["type": NodeType.water]
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
                rect.userData = ["type": NodeType.grid]
                addChild(rect)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rules = ClassicRules()
        self.board = { ClassicRules.createBoard() }
        self.currentPlayer = { HumanPlayer(withName: "", andId: .player1)! }
        self.onValidateMove = { _ in }
        self.setSelectedMove = { _ in }
        self.selectedMove = { nil }
        super.init(coder: aDecoder)
    }
    
    func executeMove(move: Move) {
        refreshPieces()
        clearMoves()
        let startPiece = findPieceNode(atX: move.columnOrigin, atY: move.rowOrigin)
        let endPiece = findPieceNode(atX: move.columnDestination, atY: move.rowDestination)
        
        let xMove = Double(move.columnDestination - move.columnOrigin) * BoardSceneValues.CELL_SIZE
        let yMove = Double(move.rowDestination - move.rowOrigin) * BoardSceneValues.CELL_SIZE
        
        startPiece?.node.run(SKAction.moveBy(x: xMove, y: yMove, duration: 0.3))
        endPiece?.node.run(SKAction.scale(by: 0, duration: 0.15))
        endPiece?.node.run(SKAction.fadeOut(withDuration: 0.15)) {
            endPiece?.node.removeFromParent()
        }
    }
    
    func updateColor(colors: GameColors) {
        scene?.backgroundColor = colors.boardColor
        waterNodes.forEach { water in
            water.fillColor = colors.waterColor
            water.strokeColor = colors.waterColor
        }
        
        gridNodes.forEach { rect in
            rect.strokeColor = colors.boardGridColor
        }
    }
    
    private func insertPiece(piece: Piece, x: CGFloat, y: CGFloat) {
        let pieceNode = PieceSprite(withPiece: piece)
        pieceNode.position.x = x
        pieceNode.position.y = y
        pieceNode.zPosition = 10
        if (piece.owner == .player2) {
            pieceNode.zRotation = .pi
        }
        pieceNode.userData = ["type": NodeType.piece, "piece": piece, "selected": false]
        
        addChild(pieceNode)
    }
    
    private func insertTile(type: CellType, x: CGFloat, y: CGFloat) {
        if let tileNode = TileSprite(withType: type) {
            tileNode.position.x = x
            tileNode.position.y = y
            addChild(tileNode)
        }
    }
    
    private func insertPossibleMove(move: Move, x: CGFloat, y: CGFloat) {
        let (xpos, ypos) = toRealCoordinates(atX: move.columnDestination, atY: move.rowDestination)
        
        let shape = SKShapeNode(circleOfRadius: (BoardSceneValues.CELL_SIZE / 2) - 10)
        let color = SKColor(named: currentPlayer().id.tileColor!)!
        shape.fillColor = color
        shape.strokeColor = color
        shape.alpha = 0.5
        shape.position.x = x
        shape.position.y = y
        shape.zPosition = 15.0
        
        shape.run(SKAction.move(to: CGPoint(x: xpos, y: ypos), duration: 0.15))
        
        shape.userData = ["type": NodeType.possibleMove, "move": move]
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

    private func refreshPieces() {
        pieceNodes
            .filter { $0.getUserData(key: "selected") == true }
            .forEach { node in
                node.run(SKAction.resize(
                    toWidth: BoardSceneValues.CELL_SIZE,
                    height: BoardSceneValues.CELL_SIZE,
                    duration: 0.2
                ))
                node.zPosition = 10
                node.userData?["selected"] = false
            }
    }
    
    private func refreshMoves() {
        moveNodes.forEach { node in
            let color = SKColor(named: currentPlayer().id.tileColor!)!
            node.alpha = 0.5
            node.fillColor = color
            node.strokeColor = color
            node.children.forEach { child in
                child.removeFromParent()
            }
        }
    }
    
    private func clearMoves() {
        moveNodes.forEach { $0.removeFromParent() }
        clearSelectedMove()
    }
    
    private func clearSelectedMove() {
        selectedMoveNodes.forEach { node in
            node.removeFromParent()
        }
        
        setSelectedMove(nil)
    }
    
    private func findPieceNode(atX x: Int, atY y: Int, ofPlayer owner: Owner? = nil) -> (piece: Piece, node: SKSpriteNode)? {
        return pieceNodes.first(where: { node in
            let piece: Piece? = node.getUserData(key: "piece")
            let pos = node.position
            let (posX, posY) = getBoardCoordinates(atX: pos.x, atY: pos.y)
            return (posX == x) && (posY == y) && (owner == nil || (piece?.owner == owner))
        }).map { node in
            let piece: Piece = node.getUserData(key: "piece")!
            return (piece, node)
        }
    }
    
    private func findMoveNode(atX x: Int, atY y: Int) -> (Move, SKShapeNode)? {
        return moveNodes.first(where: { node in
            let move: Move? = node.getUserData(key: "move")
            let pos = node.position
            let (posX, posY) = getBoardCoordinates(atX: pos.x, atY: pos.y)
            return (posX == x) && (posY == y) && move != nil
        }).map { node in
            let move: Move = node.getUserData(key: "move")!
            return (move, node)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPlayer() is HumanPlayer {
            for touch in touches {
                
                let location = touch.location(in: self)
                let (tileX, tileY) = getBoardCoordinates(atX: location.x, atY: location.y)
                                
                if let (_, node) = findPieceNode(atX: tileX, atY: tileY, ofPlayer: currentPlayer().id) {
                    if (node.getUserData(key: "selected") == false) {
                        refreshPieces()
                        node.run(SKAction.resize(
                            toWidth: BoardSceneValues.CELL_SIZE + 10,
                            height: BoardSceneValues.CELL_SIZE + 10,
                            duration: 0.2
                        ))
                        node.zPosition = 23
                        node.userData?["selected"] = true
                        
                        clearMoves()
                        rules.getMoves(
                            in: board(),
                            of: currentPlayer().id,
                            fromRow: tileY,
                            andColumn: tileX
                        ).forEach { move in
                            insertPossibleMove(move: move, x: node.position.x, y: node.position.y)
                        }
                    }
                } else if let (move, node) = findMoveNode(atX: tileX, atY: tileY) {
                    
                    if move == selectedMove() {
                        onValidateMove(move)
                    } else {
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
                        
                        line.strokeColor = SKColor(named: currentPlayer().id.tileColor!)!
                        line.lineWidth = 5
                        line.zPosition = 20
                        line.userData = ["type": NodeType.selectedMove]
                        
                        addChild(line)
                        
                        let label = SKLabelNode(text: move.label)
                        label.fontName = "Helvetica-Bold"
                        label.fontSize = 15
                        label.fontColor = SKColor.white
                        label.verticalAlignmentMode = .center
                        label.zPosition = 20
                        
                        node.addChild(label)
                        
                        setSelectedMove(move)
                    }
                } else {
                    refreshPieces()
                    clearMoves()
                }
            }
        }
    }
}
