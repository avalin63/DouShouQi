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
    
    @State var selectedImage: Image?
    @State var username: String = ""
    @State var isCheckmarkVisible = false
    
    var body: some View {
        ZStack{
            VStack {
                PicturePicker(backgroundColor: picturePickerBackground, foregroundColor: picturePickerForeground, selectedImage: $selectedImage)
                    .frame(width: 170, height: 170)
                    .padding(.bottom, 30)
                
                PlayerNameTextInput(username: $username,style:textInputStyle)
            }
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaleEffect(isCheckmarkVisible ? 1 : 0)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .font(.largeTitle)
                .opacity(isCheckmarkVisible ? 1 : 0) // Apply opacity animation
                .position(x:180, y:0)
        }
        .frame(width: 170, height: 170)
        .padding(.bottom, 30)
        .onChange(of: username) {
          updateCheckmarkVisibility()
        }
        .onChange(of: selectedImage) {
          updateCheckmarkVisibility()
        }
    }
    
    private func updateCheckmarkVisibility() {
        withAnimation{
            isCheckmarkVisible = !username.isEmpty && selectedImage != nil
        }
    }
}

#Preview("Light") {
    PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor )
}

#Preview("Dark") {
    PlayerPreparation(textInputStyle: TopUsernameTextInputStyle(), picturePickerBackground: DSQColors.topPhotoPickerBackgroundColor, picturePickerForeground: DSQColors.topPhotoPickerForegroundColor )
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
