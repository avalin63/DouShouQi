//
//  HomeView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 13/05/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var path: [Route]

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
            
                PrimaryLeftButton(
                    leading: {
                        Image(systemName: "gamecontroller.fill")
                    },
                    label: String(localized: "new_game"),
                    action: { path.append(.startGame) }
                )
                                
                OptionsLeftButton(
                    leading: {
                        Image(systemName: "chart.pie.fill")
                    },
                    label: String(localized: "statistics"),
                    action: { path.append(.statistics) }
                )
                                
                OptionsLeftButton(
                    leading: {
                        Image(systemName: "gearshape.fill")
                    },
                    label: String(localized: "options"),
                    action: { path.append(.options) }
                )
            }
            .padding(.top, 100)
            .padding(.bottom,200)
        }
        .background(DSQColors.backgroundColor)
    }
}

#Preview("Light"){
    @State var path = [Route]()
    return HomeView(path: $path)
}

#Preview("Dark") {
    @State var path = [Route]()
    return HomeView(path: $path)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
