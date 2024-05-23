//
//  HomeView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .scaledToFill()
                .opacity(colorScheme == .dark ? 0.3 : 1.0)
                .edgesIgnoringSafeArea(.all)
                .position(x: 160, y: 150)
            VStack{
                Text(String(localized: "DouShouQi"))
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(DSQColors.titleColor)
                Spacer()
                PrimaryLeftButton(leading:
                                    {Image(systemName: "gamecontroller.fill")}
                                  ,label: String(localized: "new_game"))
                OptionsLeftButton(leading:
                                    {Image(systemName: "chart.pie.fill")}
                                  , label: String(localized: "statistics"))
                OptionsLeftButton(leading:
                                    {Image(systemName: "gearshape.fill")}
                                  , label: String(localized: "options"))
            }
            .padding(.top, 100)
            .padding(.bottom,200)
        }
        .background(DSQColors.backgroundColor)
    }
}

#Preview("Light"){
    HomeView()
}

#Preview("Dark") {
    HomeView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
