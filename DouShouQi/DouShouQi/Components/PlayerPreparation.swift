//
//  PlayerPreparation.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI
import PhotosUI

struct PlayerPreparation<TextStyle: TextFieldStyle>: View {
    let style: PlayerPreparationStyle
    var textInputStyle: TextStyle
    
    @State var image: UIImage? = nil
    
    @State var username: String = ""
    @State var isCheckmarkVisible = false
    
    var body: some View {
        ZStack{
            VStack {
                PicturePicker(backgroundColor: style.picturePickerBackground, foregroundColor: style.picturePickerForeground, selectedImage: $image)
                    .frame(width: 170, height: 170)
                    .padding(.bottom, 30)
                
                PlayerNameTextInput(username: $username,style: textInputStyle)
            }
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaleEffect(isCheckmarkVisible ? 1 : 0)
                .frame(width: 30, height: 30)
                .foregroundColor(style.checkMarkColor)
                .font(.largeTitle)
                .opacity(isCheckmarkVisible ? 1 : 0)
                .position(x:180, y:0)
        }
        .frame(width: 170, height: 170)
        .padding(.bottom, 30)
        .onChange(of: username) {
            updateCheckmarkVisibility()
        }
        .onChange(of: image) {
            updateCheckmarkVisibility()
        }
    }
    
    private func updateCheckmarkVisibility() {
        withAnimation{
            isCheckmarkVisible = !username.isEmpty && image != nil
        }
    }
}

struct PlayerPreparationStyle {
    let picturePickerBackground: Color
    let picturePickerForeground: Color
    let checkMarkColor: Color
}

#Preview("Light") {
    PlayerPreparation(style:.defaultStyle, textInputStyle: TopUsernameTextInputStyle())
}

#Preview("Dark") {
    PlayerPreparation(style: .variant, textInputStyle: BottomUsernameTextInputStyle())
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
