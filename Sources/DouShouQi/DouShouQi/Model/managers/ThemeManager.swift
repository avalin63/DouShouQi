//
//  ThemeManager.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {

    @AppStorage("user_theme") var selectedTheme: Theme = .systemdefault {
        didSet {
            objectWillChange.send()
        }
    }
}
