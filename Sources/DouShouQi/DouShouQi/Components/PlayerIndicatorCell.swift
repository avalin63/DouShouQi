//
//  PlayerIndicatorCell.swift
//  DouShouQi
//
//  Created by Emre Kartal on 23/05/2024.
//

import SwiftUI

struct PlayerIndicatorCell: View {
    var body: some View {
        Text(String(localized: "player \(1)"))
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.leading, 30)
            .padding(.trailing, 20)
            .padding(.vertical, 10)
            .background(DSQColors.primaryColor)
            .cornerRadius(30, corners: [.bottomRight, .topRight])
    }
}

#Preview {
    PlayerIndicatorCell()
}
