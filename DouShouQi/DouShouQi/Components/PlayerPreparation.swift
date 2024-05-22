//
//  PlayerPreparation.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PlayerPreparation<Style: TextFieldStyle>: View {
    var textInputStyle: Style

    var body: some View {
        VStack {
            PicturePicker()
                .frame(width: 170, height: 170)
                .padding(.bottom, 30)
            
            PlayerNameTextInput(style:textInputStyle)
        }
    }
}

#Preview {
    PlayerPreparation(textInputStyle: TopUsernameTextInputStyle())
    
}
