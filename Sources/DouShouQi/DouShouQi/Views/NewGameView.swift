//
//  NewGameView.swift
//  DouShouQi
//
//  Created by Arthur Valin on 14/05/2024.
//

import SwiftUI

struct NewGameView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            VStack{
                PrimaryLeftButton(
                    leading: {
                        Image(systemName: "gamecontroller.fill")
                    },
                    label: "1 joueur"
                ){
                    
                }
                
                PrimaryLeftButton(
                    leading: {
                        Image("icTwoPlayers")
                    },
                    label: "2 joueur"
                ){
                    
                }
                
                HStack {
                    Text("Historique")
                        .padding(.leading, 24)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
            
            }
            .background(DSQColors.backgroundColor)
    }
}

#Preview("Light"){
    NewGameView()
}

#Preview("Dark") {
    NewGameView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
