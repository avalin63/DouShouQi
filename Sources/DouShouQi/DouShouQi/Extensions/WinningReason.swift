//
//  WinningReason.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/06/2024.
//

import Foundation
import DouShouQiModel

extension WinningReason: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .denReached:
            return "Den reached"
        case .noMorePieces:
            return "No more pieces"
        case .tooManyOccurences:
            return "Too many occurrences"
        case .noMovesLeft:
            return "No moves left"
        @unknown default:
            return "NaN"
        }
    }
}
