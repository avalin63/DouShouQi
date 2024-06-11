//
//  Theme.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, CustomStringConvertible{
    
    case systemdefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    var colorScheme: ColorScheme? {
        switch self{
        case .systemdefault:
            return .none
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
    
    var description : String {
        switch self {
        case .systemdefault: return String(localized: "System")
        case .light: return String(localized: "Light")
        case .dark: return String(localized: "Dark")
        }
    }
}
