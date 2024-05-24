//
//  StartOnePlayerView.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 24/05/2024.
//

import SwiftUI

struct StartOnePlayerView: View {
    var body: some View {
        VStack{
            PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor)
        }
        .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        .background(DSQColors.topUserContaierBackgroundColor)
    }
}


#Preview("Light") {
    StartOnePlayerView()
}

#Preview("Dark") {
    StartOnePlayerView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
