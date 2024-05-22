//
//  PicturePicker.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PicturePicker: View {
    var backgroundColor: Color
    var foregroundColor: Color
    var body: some View {
        ZStack{
            Circle().fill(backgroundColor).scaledToFit()
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(foregroundColor)
                .padding(40)
                
        }
    }
}

#Preview {
    PicturePicker(backgroundColor: DSQColors.topPhotoPickerBackgroundColor, foregroundColor: DSQColors.topPhotoPickerForegroundColor)
}
