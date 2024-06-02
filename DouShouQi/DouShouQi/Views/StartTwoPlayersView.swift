//
//  PreparationTwoPlayersView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PreparationTwoPlayersView: View {
    @EnvironmentObject var gameVM: GameVM
    @State var isReadyFirst = false
    @State var isReadySecond = false
    @State private var isGameStarted = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                VStack{
                    PlayerPreparation(style:.defaultStyle, textInputStyle: TopUsernameTextInputStyle(), isCheckmarkVisible: $isReadyFirst, username: $gameVM.firstUser.name)
                }
                .frame(width: geo.size.width,height: geo.size.height * (1/2))
                .background(DSQColors.topUserContaierBackgroundColor)
                VStack{
                    PlayerPreparation(style: .variant, textInputStyle: BottomUsernameTextInputStyle(), isCheckmarkVisible: $isReadySecond, username: $gameVM.secondUser.name)
                }
                .frame(width: geo.size.width,height: geo.size.height * (1/2))
                .background(DSQColors.bottomUserContainerBackgroundColor)
            }
        }
        .onAppear() {
            gameVM.isVersusAI = false
        }
        .onChange(of: isReadyFirst) {
            check()
        }
        .onChange(of: isReadySecond) {
            check()
        }
        .background(
            NavigationLink(destination: GameView().navigationBarHidden(true), isActive: $isGameStarted) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }
    
    private func check() {
        if isReadyFirst && isReadySecond {
            gameVM.startGame()
            isGameStarted = true
        }
    }
}

#Preview("Light") {
    PreparationTwoPlayersView()
}

#Preview("Dark") {
    PreparationTwoPlayersView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
