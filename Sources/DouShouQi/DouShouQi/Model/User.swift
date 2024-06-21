//
//  User.swift
//  DouShouQi
//
//  Created by Emre Kartal on 02/06/2024.
//

import Foundation
import UIKit

public struct User : Hashable {
    var image: UIImage?
    var name: String
    
    init() {
        self.image = nil
        self.name = ""
    }
}
