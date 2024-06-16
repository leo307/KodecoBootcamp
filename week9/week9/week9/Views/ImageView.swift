//
//  ImageView.swift
//  week9
//
//  Created by Leo DelPrete on 6/16/24.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageStore: ImageStore
    @State private var downloadedImageURL: URL?
    let imageUrl: String

    var body: some View {
        VStack {
            if let downloadedImageURL = downloadedImageURL,
               let imageData = try? Data(contentsOf: downloadedImageURL),
               let uiImage = UIImage(data: imageData) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
            } else {
                ProgressView()
                    .onAppear {
                        imageStore.downloadImage(imageUrl: imageUrl) { url in
                            DispatchQueue.main.async {
                                self.downloadedImageURL = url
                            }
                        }
                    }
            }
        }
        .navigationTitle("Image")
        .navigationBarTitleDisplayMode(.inline)
    }
}
