//
//  ContentView.swift
//  week9
//
//  Created by Leo DelPrete on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var imageStore = ImageStore()
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchQuery, onCommit: {
                    Task {
                        await imageStore.fetchImages(query: searchQuery)
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                if !imageStore.images.isEmpty {
                    List(imageStore.images, id: \.id) { image in
                        NavigationLink(destination: ImageView(imageStore: imageStore, imageUrl: image.src.large2x)) {
                            Text(image.photographer)
                        }
                    }
                }
            }
            .navigationTitle("Pexel Image Search")
        }
    }
}
