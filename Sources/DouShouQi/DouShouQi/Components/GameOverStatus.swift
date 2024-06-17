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
        HStack{
            Spacer()
            VStack {
                Spacer()
                Image(systemName: isWinner ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)

                Text(isWinner ? String(localized: "You Won !") : String(localized: "You Loosed !")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .foregroundColor(isWinner ? DSQColors.primaryColor : .white)
            Spacer()
        }.background(isWinner ? DSQColors.topPhotoPickerBackgroundColor : DSQColors.bottomPhotoPickerBackgroundColor)
    }
}

#Preview("winner") {
    GameOverStatus(isWinner: true)
}

#Preview("looser") {
    GameOverStatus(isWinner: false)
}

