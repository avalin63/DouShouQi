//
//  GameView.swift
//  DouShouQi
//
//  Created by Emre Kartal on 22/05/2024.
//

import SwiftUI

struct GameView: View {
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
            
            Spacer()
            
            Button(action: {}) {
                Text(String(localized: "validate"))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(DSQColors.primaryColor)
            }
            .background()
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
