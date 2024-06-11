//
//  PlayerIndicatorCell.swift
//  DouShouQi
//
//  Created by Emre Kartal on 23/05/2024.
//

import SwiftUI

struct PlayerIndicatorCell: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.leading, 30)
            .padding(.trailing, 20)
            .padding(.vertical, 10)
            .background(color)
            .cornerRadius(30, corners: [.bottomRight, .topRight])
    }
}

#Preview {
    PlayerIndicatorCell(text: "Player 1", color: DSQColors.primaryColor)
}
