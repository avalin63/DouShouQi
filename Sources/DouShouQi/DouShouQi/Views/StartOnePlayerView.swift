//
//  StartOnePlayerView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/05/2024.
//

import SwiftUI

struct StartOnePlayerView: View {
    @EnvironmentObject var gameVM: GameVM
    @State var isReady = false
    
    var body: some View {
        VStack{
            PlayerPreparation(style: .defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isCheckmarkVisible: $isReady, username: $gameVM.firstUser.name)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(DSQColors.topUserContaierBackgroundColor)
        .onAppear() {
            gameVM.isVersusAI = true
        }
        .background(
            NavigationLink(destination: GameView().navigationBarHidden(true), isActive: $isReady) {
                EmptyView()
            }
        )
        .navigationDestination(isPresented: $isReady) {
            GameView()
        }
        .onChange(of: isReady) {
            gameVM.startGame()
        }
    }
}


#Preview("Light") {
    StartOnePlayerView()
}

#Preview("Dark") {
    StartOnePlayerView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
