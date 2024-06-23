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
    
    public var selectedMove: Move?
    var currentPlayer: () -> Player = { return Player(withName: "", andId: .noOne)! }
    var cell_size: Float = 0
    var nbRows = 0
    var nbColumns = 0
    var rowOrigin = 0
    var columnOrigin = 0
    var pieces: [Owner: [Animal: ARPiece]] = [:]
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    convenience init(board: Board, imageBoard: String = "board", cell_size: Float = 0.1145, currentPlayer: @escaping () -> Player) {
        self.init(frame: UIScreen.main.bounds)
        self.nbRows = board.nbRows
        self.nbColumns = board.nbColumns
        self.cell_size = cell_size
        self.currentPlayer = currentPlayer
        initBoard(withBoard: board, andImage: imageBoard)
    }
    
    func initBoard(withBoard board: Board, andImage image: String) {
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(1, 1)))
        let arBoard = ARBoard(image: image)
        anchor.addChild(arBoard)
        self.scene.addAnchor(anchor)
        
        board.grid.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, cell) in
                let (xpos, ypos) = toRealCoordinates(atX: x, atY: y)
                
                if let piece = cell.piece {
                    let arPiece = ARPiece(image: piece.animal.pieceObject, row: x, column: y, isPlayer1: piece.owner == .player1)
                    arPiece.position = [xpos, 0.02, ypos]
                    arBoard.addChild(arPiece)
                    self.installGestures([.all], for: arPiece as Entity & HasCollision).forEach { gestureRecognizer in
                        gestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
                    }
                    
                    if pieces[piece.owner] == nil {
                        pieces[piece.owner] = [piece.animal: arPiece]
                    } else {
                        pieces[piece.owner]![piece.animal] = arPiece
                    }
                }
            }
        }
    }
    
    func movePiece(board: Board, move: Move, goodMove: Bool) {
        
        guard move.rowOrigin >= 0 && move.rowOrigin < board.nbRows && move.columnOrigin >= 0 && move.columnOrigin < board.nbColumns else {
            print("Move origin is out of range.")
            reorderBoard(board: board)
            return
        }
        
        let cell = board.grid[move.rowOrigin][move.columnOrigin]
        
        guard let piece = cell.piece else {
            print("No piece found in the cell.")
            reorderBoard(board: board)
            return
        }
        
        guard let arPiece = pieces[piece.owner]?[piece.animal] else {
            print("No AR piece found for the given player and animal.")
            return
        }
        
        let (newX, newY) = goodMove ? toRealCoordinates(atX: move.columnDestination, atY: move.rowDestination) : toRealCoordinates(atX: move.columnOrigin, atY: move.rowOrigin)
        var newTransform = arPiece.transform
        newTransform.translation = SIMD3<Float>(newX, 0.02, newY)
        
        arPiece.move(to: newTransform, relativeTo: arPiece.parent, duration: 1)
        
        selectedMove = nil
    }
    
    func reorderBoard(board: Board) {
        board.grid.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, cell) in
                let (xpos, ypos) = toRealCoordinates(atX: x, atY: y)
                
                if let piece = cell.piece {
                    let arPiece = pieces[piece.owner]?[piece.animal]
                    var newTransform = arPiece?.transform
                    newTransform?.translation = SIMD3<Float>(xpos, 0.02, ypos)
                    
                    arPiece?.move(to: newTransform!, relativeTo: arPiece?.parent, duration: 1)
                }
            }
        }
    }
    
    func removePiece(piece: Piece) {
        pieces[piece.owner]?[piece.animal]?.removeFromParent()
        pieces[piece.owner]?.removeValue(forKey: piece.animal)
        print("Captured and removed piece: \(piece)")
    }
    
    @objc private func handleGesture(_ recognizer: UIGestureRecognizer) {
        guard let translationGesture = recognizer as? EntityTranslationGestureRecognizer, let entity = translationGesture.entity else { return }
        
        switch translationGesture.state {
        case .began:
            let (column, row) = getBoardCoordinates(atX: entity.position.x, atY: entity.position.z)
            print("Gesture began. Initial position: \(entity.position). Board coordinates: (\(column), \(row))")
            rowOrigin = row
            columnOrigin = column
        case .ended:
            let (column, row) = getBoardCoordinates(atX: entity.position.x, atY: entity.position.z)
            print("Gesture ended. Final position: \(entity.position). Board coordinates: (\(column), \(row))")
            selectedMove = Move(of: currentPlayer().id, fromRow: rowOrigin, andFromColumn: columnOrigin, toRow: row, andToColumn: column)
        default:
            break
        }
    }
    
    func toRealCoordinates(atX x: Int, atY y: Int) -> (x: Float, y: Float) {
        let xpos = Float(x - nbColumns/2) * cell_size
        let ypos = Float(y - nbRows/2) * -cell_size
        return (xpos, ypos)
    }
    
    private func getBoardCoordinates(atX x: Float, atY y: Float) -> (x: Int, y: Int) {
        let xCoordinate = Int(round(x / cell_size)) + nbColumns / 2
        let yCoordinate = nbRows / 2 - Int(round(y / cell_size))
        return (xCoordinate, yCoordinate)
    }
}
