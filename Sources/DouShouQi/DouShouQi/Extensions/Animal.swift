//
//  Animal.swift
//  DouShouQi
//
//  Created by Arthur Valin on 30/05/2024.
//

import Foundation
import DouShouQiModel

extension Animal {
    public var pieceImage: String {
        switch(self) {
        case .rat:
            "pieceRat"
        case .cat:
            "pieceCat"
        case .dog:
            "pieceDog"
        case .wolf:
            "pieceWolf"
        case .leopard:
            "pieceLeopard"
        case .tiger:
            "pieceTiger"
        case .lion:
            "pieceLion"
        case .elephant:
            "pieceElephant"
        @unknown default:
            ""
        }
    }
}
