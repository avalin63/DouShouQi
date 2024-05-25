//
//  GameView.swift
//  DouShouQi
//
//  Created by Emre Kartal on 22/05/2024.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var gameScene: BoardScene
    
    init() {
        gameScene = BoardScene(size: BoardSceneValues.GRID_SIZE)
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
                PlayerIndicatorCell()
                
                Spacer()
                
                MoveIndicatorCell()
            }
            
            SpriteView(scene: gameScene)
                .border(.black, width: 3.0)
                .padding(.all, 8)
                .ignoresSafeArea()
            
            Button(action: {}) {
                Text(String(localized: "validate"))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(DSQColors.primaryColor)
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
