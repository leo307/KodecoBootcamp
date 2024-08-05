//
//  AllAssetsView.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/17/24.
//
import SwiftUI

struct AllAssetsView: View {
    @Binding var assets: [Asset]
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        List(assets) { asset in
            NavigationLink(destination: AssetDetailView(assetID: asset.id, isAuthenticated: $isAuthenticated)) {
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
            .buttonStyle(PlainButtonStyle())
        }
    }
}
