//
//  BoardSceneValues.swift
//  DouShouQi
//
//  Created by Arthur Valin on 25/05/2024.
//

import Foundation
import DouShouQiModel

enum BoardSceneValues {
    static let CELL_SIZE = 53.0
    static let GRID_WIDTH = 7.0
    static let GRID_HEIGHT = 9.0
    
    static var GRID_SIZE: CGSize {
        CGSize(
            width: CELL_SIZE * GRID_WIDTH,
            height: CELL_SIZE * GRID_HEIGHT
        )
    }
}
