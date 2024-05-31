//
//  Language.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 28/05/2024.
//

import Foundation

enum Language: String, CaseIterable, CustomStringConvertible{
    case fr = "French"
    case en = "English"
    
    var initial: String {
        switch self{
        case .fr:
            return "fr"
        case .en:
            return "en"
        }
    }
    
    var description : String {
        switch self {
        case .fr: return String(localized: "French")
        case .en: return String(localized: "English")
        }
    }
}
