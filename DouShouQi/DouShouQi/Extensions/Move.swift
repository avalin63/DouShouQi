//
//  Move.swift
//  DouShouQi
//
//  Created by Arthur Valin on 30/05/2024.
//

import Foundation
import DouShouQiModel

extension Move {
    private static let rows = ["A", "B", "C", "D", "E", "F", "G"]
    var label: String {
        "\(Move.rows[self.columnDestination])\(self.rowDestination)"
    }
}
