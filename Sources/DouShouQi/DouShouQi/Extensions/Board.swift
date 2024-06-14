//
//  Board.swift
//  DouShouQi
//
//  Created by Arthur Valin on 14/06/2024.
//

import Foundation
import DouShouQiModel


extension Board {
    var gridHeight: Int { self.grid.count }
    var gridWidth: Int { self.grid.first!.count  }
    
    var gridSize: CGSize {
        CGSize(
            width: BoardSceneValues.CELL_SIZE * Double(gridWidth),
            height: BoardSceneValues.CELL_SIZE * Double(gridHeight)
        )
    }
}
