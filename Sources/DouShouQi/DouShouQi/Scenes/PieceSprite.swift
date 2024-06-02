//
//  PieceSprite.swift
//  DouShouQi
//
//  Created by Arthur Valin on 23/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class PieceSprite : SKSpriteNode {
    public init(withPiece piece: Piece) {
        super.init(
            texture: SKTexture(image: UIImage(named: piece.animal.pieceImage)!),
            color: UIColor(),
            size: CGSize(width: BoardSceneValues.CELL_SIZE, height: BoardSceneValues.CELL_SIZE)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
