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
    
    var body: some View {
        let text = if let m = self.move {
            m.label
        } else {
            String(localized: "waiting")
        }
        
        let color = if let m = self.move {
            m.owner.playerColor!
        } else {
            DSQColors.moveCellBackgroundColor
        }
        
        HStack {
            if let a = animal {
                Image(a.pieceImage)
                  .resizable()
                  .frame(width: 50, height: 50)
                
                Image("icMoveArrow")
                  .resizable()
                  .frame(width: 50, height: 50)
            }
            
            Text(text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .padding(.leading, 30)
        .padding(.trailing, 20)
        .padding(.vertical, 10)
        .background(color)
        .cornerRadius(30, corners: [.bottomLeft, .topLeft])
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
