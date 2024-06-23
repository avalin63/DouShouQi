//
//  Strings.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 31/05/2024.
//

import SwiftUI

extension String {
    func localizedLanguage(language: String = "en") -> String {
        if let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj") {
            if let bundle = Bundle(path: bundlePath) {
                return bundle.localizedString(forKey: self, value: self, table: nil)
            }
        }
        
        return self
    }
    
    func normalized() -> String {
        return self.lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
