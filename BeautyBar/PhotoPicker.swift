//
//  PhotoPicker.swift
//  BeautyBar
//
//  Created by Илья on 21.09.2021.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        return
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.3),
                      let compressedImage = UIImage(data: data) else {
                    return
                }
                photoPicker.selectedImage = compressedImage
            } else {
                return
            }
            picker.dismiss(animated: true)
        }
    }
    
    
}
