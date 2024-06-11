//
//  GameView.swift
//  DouShouQi
//
//  Created by Emre Kartal on 22/05/2024.
//

import SwiftUI
import SpriteKit
import DouShouQiModel

struct GameView: View {

    @EnvironmentObject var gameVM: GameVM
    @State private var navigateToSummary = false
    
    var body: some View {
        VStack() {
            HStack {
                Text(String(localized: "Round \(gameVM.nbRoundsPlayed / 2)"))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(DSQColors.titleColor)
                
                Spacer()
                
                Text("12min34s")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(DSQColors.titleColor)
            }
            .padding([.leading, .trailing], 30)
            
            HStack {
                PlayerIndicatorCell(
                    text: gameVM.currentPlayer?.name ?? "",
                    color: gameVM.currentPlayer?.id.playerColor ?? DSQColors.player1
                )
                
                Spacer()
                
                MoveIndicatorCell(move: nil, animal: nil)
            }
            
            if let gameScene = gameVM.gameScene {
                SpriteView(scene: gameScene)
                    .border(.black, width: 3.0)
                    .aspectRatio(
                        CGSize(
                            width: BoardSceneValues.GRID_WIDTH,
                            height: BoardSceneValues.GRID_HEIGHT
                        ),
                        contentMode: .fit
                    )
                    .padding(.all, 8)
                    .ignoresSafeArea()
                
                Button(action: {
                    if let move = gameScene.selectedMove?.move {
                        Task {
                            try await gameVM.game?.onPlayed(with: move, from: gameVM.currentPlayer!)
                        }
                    }
                }) {
                    Text(String(localized: "validate"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 70)
                        .background(gameVM.currentPlayer?.id.playerColor ?? DSQColors.player1)
                }
                .background()
                .padding(.bottom, 24)
            }
        
        }
        .alert(isPresented: $gameVM.isOver) {
            Alert(
                title: Text("Partie terminée"),
                message: Text(gameVM.defeatReason),
                dismissButton: .default(Text("Ok")) {
                    navigateToSummary = true
                }
            )
        }
        .background(
            NavigationLink(destination: HomeView().navigationBarHidden(true), isActive: $navigateToSummary) {
                EmptyView()
            }
        )
        .padding(.vertical, 20)
        .background(DSQColors.backgroundColor)

    }
}

#Preview("Light") {
    GameView()
        .environmentObject(GameVM())
}

#Preview("Dark"){
    GameView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(GameVM())
}
