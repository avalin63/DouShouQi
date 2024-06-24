//
//  User.swift
//  DouShouQi
//
//  Created by Emre Kartal on 02/06/2024.
//

import Foundation
import UIKit

public struct User : Hashable, Identifiable {
    public var id: UUID = UUID()
    var image: UIImage?
    var name: String
    
    init() {
        self.id = UUID()
        self.name = ""
    }
    init(id: UUID, image: UIImage?, name: String){
        self.id = id
        self.name = name
        self.image = image
    }
}
