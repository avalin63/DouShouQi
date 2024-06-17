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
    
    public var pieceObject: String {
        switch(self) {
        case .rat:
            "rat"
        case .cat:
            "cat"
        case .dog:
            "dog"
        case .wolf:
            "wolf"
        case .leopard:
            "leopard"
        case .tiger:
            "tiger"
        case .lion:
            "lion"
        case .elephant:
            "elephant"
        @unknown default:
            ""
        }
    }
}
