//
//  AsyncImageView.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import SwiftUI

struct AsyncImageView: View {
    let urlString: String
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("loadingImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            ImageLoader().loadImage(from: "https://image.tmdb.org/t/p/w500" + urlString) { loadedImage in
                self.image = loadedImage
            }
        }
    }
}
