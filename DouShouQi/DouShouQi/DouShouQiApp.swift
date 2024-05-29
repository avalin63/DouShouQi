//
//  DouShouQiApp.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

@main
struct DouShouQiApp: App {
    @StateObject var themeManager = ThemeManager()
    @StateObject var languageManager = LanguageManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environment(\.locale, Locale(identifier: languageManager.selectedLang.description))
            }
            .preferredColorScheme(themeManager.selectedTheme.colorScheme)
            .environmentObject(themeManager)
            .environmentObject(languageManager)
            
        }
    }
}
