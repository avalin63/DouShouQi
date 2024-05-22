//
//  PicturePicker.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//

import SwiftUI

struct PicturePicker: View {
    var body: some View {
        ZStack{
            Circle().scaledToFit()
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding(20)
                
        }
    }
}

#Preview {
    PicturePicker()
}
