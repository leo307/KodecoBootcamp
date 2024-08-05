//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI

struct AssetListView: View {
    @StateObject private var viewModel = AssetListViewModel()
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            List(viewModel.assets) { asset in
                NavigationLink(destination: AssetDetailView(assetID: asset.id, isAuthenticated: $isAuthenticated)) {
                    HStack {
                        if let thumbnail = asset.thumbnail, let url = URL(string: thumbnail.url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 75)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 75)
                            }
                        } else {
                            Color.gray
                                .frame(width: 100, height: 75)
                        }

                        VStack(alignment: .leading) {
                            Text(asset.title)
                                .font(.headline)
                                .lineLimit(1)
                                .accessibilityIdentifier("assetTitle_\(asset.id)")
                            Text("ID: \(asset.id)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .accessibilityIdentifier("assetID_\(asset.id)")
                        }
                        .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
                .accessibilityIdentifier("assetLink_\(asset.id)")
            }
            .onAppear {
                Task {
                    await viewModel.fetchAssets()
                }
            }
            .navigationTitle("Assets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.signOut()
                        isAuthenticated = viewModel.isAuthenticated
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Sign Out")
                        }
                    }
                    .accessibilityIdentifier("signOutButton")
                }
            }
        }
    }
}
