//
//  LanguageManager.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @AppStorage("user_lang") var selectedLang: Language = .en
}
