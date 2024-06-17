//
//  ARBoard.swift
//  DouShouQi
//
//  Created by Emre Kartal on 17/06/2024.
//

import RealityKit

class ARBoard: Entity {
    let CELL_SIZE: Float = 0.1145
    
    required init(image: String) {
        super.init()
        if let boardEntity = try? Entity.load(named: image) {
            self.addChild(boardEntity)
        }
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
    
    func toRealCoordinates(atX x: Int, atY y: Int, nbColumns: Int, nbRows: Int) -> (x: Float, y: Float) {
        let xpos = Float(x - nbColumns / 2) * CELL_SIZE
        let ypos = Float(y - nbRows / 2) * CELL_SIZE
        return (xpos, ypos)
    }
}
