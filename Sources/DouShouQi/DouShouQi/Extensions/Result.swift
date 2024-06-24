//
//  Result.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/06/2024.
//

import Foundation
import DouShouQiModel

extension Result: CustomStringConvertible{
    
    public var description: String {
        switch self {
        case .notFinished:
            return "The game is not finished."
        case .even:
            return "The game ended in a draw."
        case .winner(let winner, let reason):
            return "\(reason)"
        @unknown default:
            return "Nan"
        }
    }
    
    
}
