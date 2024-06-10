//
//  CellType.swift
//  DouShouQi
//
//  Created by Arthur Valin on 30/05/2024.
//

import Foundation
import DouShouQiModel


extension CellType {
    public var tileImage: String? {
        switch(self) {
        case .unknown, .jungle:
            nil
        case .water:
            "tileWater"
        case .trap:
            "tileTrap"
        case .den:
            "tileDen"
        @unknown default:
            nil
        }
    }
}
