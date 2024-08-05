//
//  AssetDetailsView.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/18/24.
//
import SwiftUI

struct AssetDetailsView: View {
    let asset: Asset?

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                if let asset = asset {
                    VStack(spacing: 10) {
                        Text(asset.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text(asset.description ?? "Description not given or not available for this asset.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text(asset.summary ?? "Summary not given or not available for this asset.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    if let watchURL = asset.watchURL, let url = URL(string: watchURL) {
                        HStack {
                            Text("Watch URL: ")
                                .font(.body)
                                .foregroundColor(.primary)

                            Link("Watch Here", destination: url)
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    } else {
                        Text("Watch URL not given or not available for this asset.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    VStack(spacing: 5) {
                        Text("Asset UUID: \(asset.uuid)")
                            .font(.body)
                            .foregroundColor(.secondary)

                        Text("Team ID: \(asset.teamID)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                } else {
                    ProgressView("Loading asset information please be patient.")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(radius: 10)
            )
            .padding()
        }
    }
}
