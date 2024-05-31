//
//  GameOverView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 31/05/2024.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                        VStack{
                            GameOverStatus(isWinner: false)
                        }.frame(width: geo.size.width,height: geo.size.height * (1/2))
                        VStack{
                            GameOverStatus(isWinner: true)
                        }.frame(width: geo.size.width,height: geo.size.height * (1/2))
                    }
                }
    }
}

#Preview {
    GameOverView()
}
