//
//  StartGameView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 16/05/2024.
//

import SwiftUI

struct StartGameView: View {
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                PrimaryLeftButton(leading: {Image(systemName: "gamecontroller.fill")}
                                  ,label: "1 joueur")
                PrimaryLeftButton(leading: {Image(systemName: "gamecontroller.fill")
                    Image(systemName: "gamecontroller.fill")}
                                  ,label: "2 joueurs")
            }.padding(.bottom, 30)
            VStack(alignment: .leading){
                Text("Historique")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(DSQColors.titleColor)
                    .padding(.horizontal, 30)
                ScrollView{
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                    PartyResumeCell()
                }.fadeOutTop(fadeLength: 30)
            }
            Spacer()
        }
        .padding(.top, 20)
        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
        .background(DSQColors.backgroundColor)
    }
}

#Preview("Light") {
    StartGameView()
}

#Preview("Dark"){
    StartGameView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
