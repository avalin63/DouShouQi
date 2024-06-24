//
//  ARBoard.swift
//  DouShouQi
//
//  Created by Emre Kartal on 17/06/2024.
//

import RealityKit

class ARBoard: Entity {
    
    required init(image: String) {
        super.init()
        if let boardEntity = try? Entity.load(named: image) {
            self.addChild(boardEntity)
        }
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
}
