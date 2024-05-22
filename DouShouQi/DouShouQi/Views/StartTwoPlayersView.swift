//
//  PreparationTwoPlayersView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PreparationTwoPlayersView: View {
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                        VStack{
                            HStack{
                                Spacer()
                                PlayerPreparation(textInputStyle: TopUsernameTextInputStyle())
                                Spacer()
                            }
                        }.frame(height: geo.size.height * (1/2))
                            .background(DSQColors.topUserContaierBackgroundColor)
                        VStack{
                            HStack{
                                Spacer()
                                PlayerPreparation(textInputStyle: BottomUsernameTextInputStyle())
                                Spacer()
                            }
                        }.frame(height: geo.size.height * (1/2))
                            .background(DSQColors.bottomUserContainerBackgroundColor)
                    }
                }
    }
}

#Preview("Light") {
    PreparationTwoPlayersView()
}

#Preview("Dark") {
    PreparationTwoPlayersView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
