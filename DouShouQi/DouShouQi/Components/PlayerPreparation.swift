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

    @State private var isShowingDialog = false
    
    var body: some View {
        VStack {
            PicturePicker(backgroundColor: picturePickerBackground, foregroundColor: picturePickerForeground).onTapGesture {
                isShowingDialog = true
            }
            .frame(width: 170, height: 170)
            .padding(.bottom, 30)
            
            PlayerNameTextInput(style:textInputStyle)
        }
        .confirmationDialog(
              "Depuis quelle source souhaitez vous prendre votre photo de profil ?",
              isPresented: $isShowingDialog,
              titleVisibility: .visible
            ) {
              Button("Galerie") {
              // Handle Galerie.
              }
              Button("Appareil Photo") {
              // Handle camera.
              }
              Button("Annuler", role: .cancel) {
                isShowingDialog = false
              }
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
