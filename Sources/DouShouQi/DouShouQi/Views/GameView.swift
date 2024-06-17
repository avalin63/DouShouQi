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
    
    var gameVM: GameVM
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var historicVM: HistoricVM
    
    @State private var navigateToSummary = false
    @State private var elapsedTime: TimeInterval = 0
    @Binding var path: [Route]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack() {
                    HStack {
                        Text(String(localized: "Round \(gameVM.nbRoundsPlayed / 2)"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(DSQColors.titleColor)
                        
                        Spacer()
                        
                        Text(timeString(time: elapsedTime))
                            .font(.title3)
                            .fontWeight(.light)
                            .foregroundStyle(DSQColors.titleColor)
                            .onReceive(timer) { _ in
                                elapsedTime += 1
                            }
                    }
                    .padding([.leading, .trailing], 30)
                    
                    HStack {
                        PlayerIndicatorCell(
                            text: gameVM.currentPlayer?.name ?? "",
                            color: gameVM.currentPlayer?.id.playerColor ?? DSQColors.player1
                        )
                        Spacer()
                        if gameVM.gameScene?.selectedMove?.move != nil{
                            if let animal = gameVM.game?.board.grid[gameVM.gameScene?.selectedMove?.move.rowOrigin ?? 0][gameVM.gameScene?.selectedMove?.move.columnOrigin ?? 0].piece?.animal {
                                MoveIndicatorCell(move: gameVM.gameScene?.selectedMove?.move, animal: animal)
                            }
                        }
                        else{
                            MoveIndicatorCell(move: gameVM.gameScene?.selectedMove?.move, animal: nil)
                        }
                    }
                    
                    if let gameScene = gameVM.gameScene {
                        SpriteView(scene: gameScene)
                            .border(.black, width: 3.0)
                            .aspectRatio(
                                CGSize(
                                    width: gameVM.game?.board.gridWidth ?? 0,
                                    height: gameVM.game?.board.gridHeight ?? 0
                                ),
                                contentMode: .fit
                            )
                            .padding(.all, 8)
                            .frame(maxHeight: .infinity)
                            .ignoresSafeArea()
                            .onAppear {
                                gameScene.updateColor(colors: GameColors())
                            }
                            .onChange(of: colorScheme) {
                                gameScene.updateColor(colors: GameColors())
                            }
                        
                        Button(action: {
                            if let move = gameScene.selectedMove?.move {
                                gameScene.onValidateMove(move)
                            }
                        }) {
                            Text(String(localized: "validate"))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .background(
                                    gameVM.gameScene?.selectedMove == nil ? DSQColors.moveCellBackgroundColor : gameVM.currentPlayer?.id.playerColor ?? DSQColors.player1
                                )
                        }
                        .background()
                        .disabled(gameVM.gameScene?.selectedMove == nil)
                        .padding(.bottom, 24)
                    }
                    
                }
                .onChange(of: gameVM.isOver) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        historicVM.saveCurrentGame(startGameDate: gameVM.startGameDate, endGameDate: gameVM.endGameDate, isVersusAI: gameVM.isVersusAI, firstUser: gameVM.firstUser, secondUser: gameVM.secondUser, isOver: gameVM.isOver, defeatReason: gameVM.defeatReason, nbRoundsPlayed: gameVM.nbRoundsPlayed, winPlayer: gameVM.winPlayer)
                        path = []
                    }
                }
                .padding(.vertical, 20)
                .background(DSQColors.backgroundColor)
                .safeAreaPadding(.top, 50)
            }
            VStack(spacing: -5){
                GameOverStatus(isWinner: gameVM.winPlayer == gameVM.game?.players.values.first).frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .animation(.spring(), value: gameVM.isOver)
                Spacer()
                GameOverStatus(isWinner: gameVM.winPlayer != gameVM.game?.players.values.first).frame(width: geo.size.width,height: geo.size.height * (1/2))
                    .animation(.spring(), value: gameVM.isOver)
            }
            .frame(height: gameVM.isOver ? geo.size.height : geo.size.height * 2)
            .padding(.top,gameVM.isOver ? 0 : -geo.size.height * (1/2))
            
            
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}

#Preview("Light") {
    let vm = GameVM(firstUser: User(), secondUser: nil)
    vm.startGame()
    return GameView(gameVM: vm, path: State(initialValue: [Route]()).projectedValue)
}

#Preview("Dark"){
    let vm = GameVM(firstUser: User(), secondUser: nil)
    vm.startGame()
    return GameView(gameVM: vm, path: State(initialValue: [Route]()).projectedValue)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
