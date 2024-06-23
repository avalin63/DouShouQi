//
//  GameARViewReprensentable.swift
//  DouShouQi
//
//  Created by Emre Kartal on 12/06/2024.
//

import SwiftUI
import DouShouQiModel

struct GameARViewReprensentable: UIViewRepresentable {
    
    var gameARView: GameARView
    
    func makeUIView(context: Context) -> GameARView {
        return gameARView
    }

    func updateUIView(_ uiView: GameARView, context: Context) {}
}
