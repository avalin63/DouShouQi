//
//  PicturePicker.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/05/2024.
//
import PhotosUI
import SwiftUI

struct PicturePicker: View {
    var backgroundColor: Color
    var foregroundColor: Color
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var isShowingDialog = false
    @State private var isShowingImagePicker = false
    
    var body: some View {
        ZStack{
            
            if let image = selectedImage {
                Circle().fill(backgroundColor).scaledToFit()
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
            } else {
                Circle().fill(backgroundColor).scaledToFit()
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(foregroundColor)
                    .padding(40)
            }
                
        }
        .onTapGesture {
            isShowingDialog = true
        }
        .confirmationDialog(
              "Depuis quelle source souhaitez vous prendre votre photo de profil ?",
              isPresented: $isShowingDialog,
              titleVisibility: .visible
            ) {
              Button("Galerie") {
                  isShowingImagePicker = true
              }
              Button("Appareil Photo") {
                  // Handle camera.
              }
              Button("Annuler", role: .cancel) {
                isShowingDialog = false
              }
            }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}
