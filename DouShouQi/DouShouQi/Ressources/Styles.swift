//
//  Styles.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import Foundation
import SwiftUI


struct LeftButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    var isExpanded: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.leading, 60)
            .padding(.vertical, 14.0)
            .font(.title3)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(15, corners: [.bottomRight, .topRight])
            .padding(.trailing, isExpanded ? -0 : 30)
            .contentShape(Rectangle())
    }
}
