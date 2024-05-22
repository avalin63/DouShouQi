//
//  PlayerNameTextInput.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI
import Combine

struct PlayerNameTextInput<Style: TextFieldStyle>: View {
    @State private var username: String = ""
    let textLimit = 20
    var style: Style
    
    @State private var isShaking = false
    
    var body: some View {
        TextField("Pseudonyme", text: $username)
            .onReceive(Just(username)) { _ in limitText(textLimit) }
            .textFieldStyle(style)
            .modifier(ShakeEffect(shakes: isShaking ? 2 : 0)) // Apply shake effect conditionally
    }
    
    func limitText(_ upper: Int) {
        if username.count > upper {
            username = String(username.prefix(upper))
            withAnimation(Animation.default.repeatCount(1).speed(2)) {
                isShaking = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isShaking = false
            }
        }
    }
}

#Preview("Light") {
    PlayerNameTextInput(style: BottomUsernameTextInputStyle())
}

#Preview("Dark") {
    PlayerNameTextInput(style: BottomUsernameTextInputStyle())
        .preferredColorScheme(.dark)
}
