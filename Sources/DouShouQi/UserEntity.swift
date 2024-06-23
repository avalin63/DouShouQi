//
//  UserEntity.swift
//  
//
//  Created by Lucas Delanier on 22/06/2024.
//
//

import Foundation
import SwiftData


@Model public class UserEntity {
    var id: UUID?
    var username: String?
    var picture: String?
    public init() {

    }
    
}
