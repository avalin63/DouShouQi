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
                            PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor)
                        }.frame(width: geo.size.width,height: geo.size.height * (1/2))
                            .background(DSQColors.topUserContaierBackgroundColor)
                        VStack{
                            PlayerPreparation(textInputStyle: BottomUsernameTextInputStyle(), picturePickerBackground: DSQColors.bottomPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.bottomPhotoPickerForegroundColor)
                        }.frame(width: geo.size.width,height: geo.size.height * (1/2))
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
