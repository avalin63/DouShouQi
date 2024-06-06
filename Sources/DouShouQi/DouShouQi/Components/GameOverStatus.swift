//
//  GameOverStatus.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 31/05/2024.
//

import SwiftUI

struct GameOverStatus: View {
    let isWinner: Bool

    var body: some View {
        VStack {
            Image(systemName: isWinner ? "checkmark.circle.fill" : "xmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(isWinner ? DSQColors.primaryColor : .white)

            Text(isWinner ? String(localized: "Win") : String(localized: "Game Over"))
        }
        .background(isWinner ? DSQColors.primaryColor : .white)
    }
}

#Preview {
    GameOverStatus(isWinner: true)
}

