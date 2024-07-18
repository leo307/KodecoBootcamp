//
//  DownloadedAssetView.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/17/24.
//
import SwiftUI

import SwiftUI

struct DownloadedAssetsView: View {
    @Binding var assets: [Asset]
    
    var body: some View {
        List(assets.filter { isAssetDownloaded($0) }) { asset in
            VStack(alignment: .leading, spacing: 8) {
                if let thumbnail = asset.thumbnail, let url = URL(string: thumbnail.url) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 120)
                    .padding(.bottom, 8)
                }
                
                Text(asset.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
        }
        .listStyle(PlainListStyle())
    }
}

    func isAssetDownloaded(_ asset: Asset) -> Bool {
        guard let fileName = asset.file?.url else { return false }
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent(URL(fileURLWithPath: fileName).lastPathComponent)
        
        print(fileName)
        return fileManager.fileExists(atPath: filePath.path)
    }

