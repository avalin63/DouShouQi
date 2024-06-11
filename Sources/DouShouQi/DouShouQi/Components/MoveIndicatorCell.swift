//
//  MoveIndicatorCell.swift
//  DouShouQi
//
//  Created by Emre Kartal on 23/05/2024.
//

import SwiftUI
import DouShouQiModel

struct MoveIndicatorCell: View {
    
    let move: Move?
    let animal: Animal?
    @State private var animatePulse: CGFloat = 1
    @State private var arrowPulse: CGFloat = 1


    var body: some View {
        let text = move?.label ?? String(localized: "waiting")
        let color = move?.owner.playerColor ?? DSQColors.moveCellBackgroundColor
        
        ZStack(alignment: .leading) {
            HStack{
                Spacer()
                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(.trailing, 10)
            .frame(width: 150, height: 50)
            .background(color)
            .cornerRadius(30, corners: [.bottomLeft, .topLeft])
            if let a = animal {
                HStack{
                    Image(a.pieceImage)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .scaleEffect(animatePulse)
                        .onAppear{
                            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                animatePulse = 1.25 * animatePulse
                            }
                        }
                    
                    Image("icMoveArrow")
                        .resizable()
                        .frame(width: 60, height: 50)
                        .padding(.leading, -10)
                        .padding(.leading,arrowPulse)
                        .onAppear{
                            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                arrowPulse = 10 * arrowPulse
                            }
                        }
                }.padding(.leading, 10)
            }
        }
    }
}

#Preview("Waiting") {
    MoveIndicatorCell(move: nil, animal: nil)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

#Preview("Move") {
    MoveIndicatorCell(
        move: Move(
            of: .player1,
            fromRow: 3,
            andFromColumn: 3,
            toRow: 4,
            andToColumn: 4
        ),
        animal: .cat
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
