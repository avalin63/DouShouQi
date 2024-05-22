//
//  PlayerNameTextInput.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PlayerNameTextInput<Style: TextFieldStyle>: View {
    @State private var username: String = ""
    var style: Style
    var body: some View {
        TextField("Pseudonyme",text: $username)
            .textFieldStyle(style)
    }
}

#Preview("Light") {
    PlayerNameTextInput(style: BottomUsernameTextInputStyle())
}

#Preview("Dark") {
    PlayerNameTextInput(style: BottomUsernameTextInputStyle())
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
