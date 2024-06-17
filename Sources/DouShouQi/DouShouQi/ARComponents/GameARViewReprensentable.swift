//
//  GameARViewReprensentable.swift
//  DouShouQi
//
//  Created by Emre Kartal on 12/06/2024.
//

import SwiftUI
import DouShouQiModel

struct GameARViewReprensentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> GameARView {
        return GameARView(board: ClassicRules.createBoard())
    }

    func updateUIView(_ uiView: GameARView, context: Context) {}
}
