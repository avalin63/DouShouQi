//
//  TileSprite.swift
//  DouShouQi
//
//  Created by Arthur Valin on 25/05/2024.
//

import Foundation
import DouShouQiModel
import SpriteKit

class TileSprite: SKSpriteNode {
    public init?(withType type: CellType) {
        
        guard(type != .jungle && type != .unknown) else { return nil }
        
        super.init(
            texture: SKTexture(image: UIImage(named: type.tileImage!)!),
            color: UIColor(),
            size: CGSize(width: BoardSceneValues.CELL_SIZE, height: BoardSceneValues.CELL_SIZE)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
