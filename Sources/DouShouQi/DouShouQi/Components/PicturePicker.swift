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
    @State private var selectedItem: PhotosPickerItem?
    @Binding var selectedImage: UIImage?
    @State private var isShowingDialog = false
    @State private var isShowingImagePicker = false
    @State private var isShowCamera = false
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            selectedImage = UIImage(data: imageData)?.faceCrop()
            
        }
    }
    
    var body: some View {
        ZStack{
            
            if let selectedImage = selectedImage{
                Image(uiImage: selectedImage)
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
            String(localized: "Source question"),
            isPresented: $isShowingDialog,
            titleVisibility: .visible
        ) {
            Button(String(localized: "Gallery")) {
                isShowingImagePicker = true
            }
            Button(String(localized: "Camera")) {
                isShowCamera = true
            }
            Button(String(localized: "Cancel"), role: .cancel) {
                isShowingDialog = false
            }
        }
        .onChange(of: selectedItem, loadImage)
        
        .photosPicker(isPresented: $isShowingImagePicker, selection: $selectedItem)
        .fullScreenCover(isPresented: $isShowCamera) {
            accessCameraView(selectedImage: self.$selectedImage).ignoresSafeArea(.all)
        }
        
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
