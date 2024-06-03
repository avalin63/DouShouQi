//
//  GameView.swift
//  DouShouQi
//
//  Created by Emre Kartal on 22/05/2024.
//

import SwiftUI
import SpriteKit
import DouShouQiModel

let player1: Player = HumanPlayer(
    withName: "Dave",
    andId: .player1
)!

let player2: Player = HumanPlayer(
    withName: "Lucas",
    andId: .player2
)!

class GameViewState : ObservableObject {
    @Published var currentPlayer: Player = player1
}

struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var state = GameViewState()
    @StateObject var gameColors = GameColors()
    var gameScene: BoardScene {
        BoardScene(
            size: BoardSceneValues.GRID_SIZE,
            colors: gameColors,
            board: ClassicRules.createBoard(),
            state: state
        )
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text(String(localized: "Round \(12)"))
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
                    text: state.currentPlayer.name,
                    color: state.currentPlayer.id.playerColor!
                )
                
                Spacer()
                
                MoveIndicatorCell(move: nil, animal: nil)
            }
            
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
                state.currentPlayer = if (state.currentPlayer.id == .player2){
                    player1
                } else {
                    player2
                }
            }) {
                Text(String(localized: "validate"))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(state.currentPlayer.id.playerColor!)
            }
            .background()
            .padding(.bottom, 24)
        }
        .padding(.vertical, 20)
        .background(DSQColors.backgroundColor)
    }
}

#Preview("Light") {
    GameView()
}

#Preview("Dark"){
    GameView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
