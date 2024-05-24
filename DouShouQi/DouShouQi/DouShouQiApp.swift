//
//  DouShouQiApp.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

@main
struct DouShouQiApp: App {
    var body: some Scene {
        WindowGroup {
            PreparationTwoPlayersView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
