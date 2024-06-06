//
//  GameColors.swift
//  DouShouQi
//
//  Created by Arthur Valin on 30/05/2024.
//

import Foundation
import SpriteKit
import SwiftUI

class GameColors: ObservableObject {
    @Published var boardColor: UIColor = UIColor(named: "BoardColor")!
    @Published var boardGridColor: UIColor = UIColor(named: "BoardGridColor")!
    @Published var waterColor: UIColor = UIColor(named: "WaterColor")!
}
