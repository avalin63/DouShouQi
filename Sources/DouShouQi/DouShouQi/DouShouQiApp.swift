//
//  DouShouQiApp.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI
import DouShouQiModel

enum Route : Hashable {
    case options
    case startGame
    case startGameOnePlayer
    case startGameTwoPlayers
    case game(user1: User, user2: User? = nil)
    
}

@main
struct DouShouQiApp: App {
    @StateObject var themeManager = ThemeManager()
    @StateObject var languageManager = LanguageManager()
    
    @State private var path = [Route]()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                HomeView(path: $path)
                    .navigationDestination(for: Route.self) { route in
                        switch(route) {
                        case .options:
                            OptionsView()
                            
                        case .startGame:
                            StartGameView(path: $path)
                            
                        case .startGameOnePlayer:
                            StartOnePlayerView(path: $path)
                            
                        case .startGameTwoPlayers:
                            StartTwoPlayersView(path: $path)
                            
                        case .game(let user1, let user2): {
                            let vm = GameVM(firstUser: user1, secondUser: user2)                            
                            vm.startGame()
                            
                            return GameView(gameVM: vm, path: $path)
                            }()
                        }
                    }
            }
            .preferredColorScheme(themeManager.selectedTheme.colorScheme)
            .environmentObject(themeManager)
            .environmentObject(languageManager)
        }
    }
}
