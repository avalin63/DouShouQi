//
//  SKNode.swift
//  DouShouQi
//
//  Created by Arthur Valin on 14/06/2024.
//

import Foundation
import SpriteKit

extension SKNode {
    
    func getUserData<T: Any>(key: String) -> T? {
        if let nodeType = self.userData?.value(forKey: key) {
            return nodeType as? T
        } else {
            return nil
        }
    }
    
    func hasType(type: NodeType) -> Bool {
        let nodeType: NodeType? = self.getUserData(key: "type")
        return nodeType == type
    }
}
