//
//  ARPiece.swift
//  DouShouQi
//
//  Created by Emre Kartal on 17/06/2024.
//

import RealityKit

class ARPiece: Entity, HasCollision {
    required init(image: String, isPlayer2: Bool = false) {
        super.init()
        if let pieceEntity = try? Entity.loadModel(named: image) {
            self.addChild(pieceEntity)
            if isPlayer2 {
                self.transform.rotation = self.transform.rotation * simd_quatf(angle: .pi, axis: SIMD3<Float>(0, 1, 0))
                pieceEntity.model?.materials[0] = SimpleMaterial(color: .blue, isMetallic: true)
                
            }
            
        }
        self.generateCollisionShapes(recursive: true)
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
}
