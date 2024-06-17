//
//  User.swift
//  DouShouQi
//
//  Created by Emre Kartal on 02/06/2024.
//

import Foundation

public struct User : Hashable {
    var image: String
    var name: String
    
    init() {
        self.image = ""
        self.name = ""
    }
}
