//
//  LoadImage.swift
//  BeautyBar
//
//  Created by Илья on 06.09.2021.
//

import SwiftUI

struct LoadImage: View {
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        getImage(from: url)
            .resizable()
            .frame(width: width, height: height)
    }
    
    private func getImage(from url: URL) -> Image {
        guard let imageData = try? Data(contentsOf: url) else { return Image(systemName: "xmark.shield") }
        guard let image = UIImage(data: imageData) else { return Image(systemName: "xmark.shield") }
        return Image(uiImage: image)
    }
}

