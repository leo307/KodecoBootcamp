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
            VStack{
            if let asset = asset {
                Text(asset.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 20)
                Text(asset.description ?? "Description not given or not available for this asset.")
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 20)
                Text(asset.summary ?? "Summary not given or not available for this asset.")
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 20)
                if let watchURL = asset.watchURL, let url = URL(string: watchURL) {
                    HStack{
                    Text("Watch URL : ")
                    Link(asset.watchURL ?? "Watch URL could not be found.", destination: url)
                        .multilineTextAlignment(.center)
                    }
                } else {
                    Text("Watch URL not available for this asset.")
                        .multilineTextAlignment(.center)
                }
                Spacer().frame(height: 20)
                Text("Asset UUID : \(asset.uuid)")
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 20)
                Text("Team ID : \(asset.teamID)")
                    .multilineTextAlignment(.center)

            } else {
                ProgressView("Loading...")
            }
        }
        .padding()
        }
    }
}
