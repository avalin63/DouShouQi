//
//  PlayerPreparation.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PlayerPreparation<TextStyle: TextFieldStyle>: View {
    var textInputStyle: TextStyle
    var picturePickerBackground: Color
    var picturePickerForeground: Color
    
    var body: some View {
        VStack {
            PicturePicker(backgroundColor: picturePickerBackground, foregroundColor: picturePickerForeground)
            .frame(width: 170, height: 170)
            .padding(.bottom, 30)
            
            PlayerNameTextInput(style:textInputStyle)
        }
        .frame(width: 170, height: 170)
        .padding(.bottom, 30)
    }
}

#Preview("Light") {
    PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor )
}

#Preview("Dark") {
    PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor )
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
